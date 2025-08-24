function Get-TableOfContentsFromFolder {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$Path,

        [Parameter(Mandatory = $true)]
        [string]$MarkdownFilePath
    )

    $tree = @{}

    # Normalize paths
    $sourcePath = (Resolve-Path $Path).Path
    $targetPath = (Resolve-Path $MarkdownFilePath).Path

    # Extract root folder name from $Path
    $rootFolderName = (Split-Path $sourcePath -Leaf).ToLower() + "/"

    # Calculate relative path from MarkdownFilePath to Path
    $uriTarget = New-Object System.Uri("$targetPath\")
    $uriSource = New-Object System.Uri("$sourcePath\")
    $relativePath = $uriTarget.MakeRelativeUri($uriSource).ToString() -replace '%20', ' ' -replace '/', '/'

    # Get all markdown files recursively
    $markdownFiles = Get-ChildItem -Path $sourcePath -Recurse -Filter *.md

    foreach ($file in $markdownFiles) {
        $fileContent = Get-Content $file.FullName
        $fileName = $file.Name
        $fileDirectory = Split-Path $file.FullName -Parent
        $relativeDir = $fileDirectory.Substring($sourcePath.Length).TrimStart('\') -replace '\\', '/'

        $folderKey = if ($relativeDir) { $relativeDir } else { $rootFolderName.TrimEnd('/') }
        if (-not $tree.ContainsKey($folderKey)) {
            $tree[$folderKey] = @{}
        }

        $tree[$folderKey][$fileName] = @()

        foreach ($line in $fileContent) {
            if ($line -match '^\s*#{1,2}\s+(.*)') {
                $headingText = $Matches[1].Trim()

                # Normalize fragment for Markdown anchor
                $fragmentSource = $headingText -replace '\p{So}', '' -replace '[^\w\s-]', '' -replace '\s+', '-'
                $fragment = $fragmentSource.ToLower()

                # Construct valid Markdown link
                $link = "$relativePath/$folderKey/$fileName#$fragment" -replace '\\', '/' -replace '//+', '/'
                $tree[$folderKey][$fileName] += "- [$headingText]($link)"
            }
        }
    }

    $outputLines = @()
    $outputLines += "- $rootFolderName"
    foreach ($folder in $tree.Keys | Sort-Object) {
        $folderIndent = "    "
        $folderPath = "$folder/"
        $outputLines += "$folderIndent- $folderPath"

        foreach ($file in $tree[$folder].Keys | Sort-Object) {
            $fileIndent = "$folderIndent    "

            # Add file name as a markdown link (no anchor)
            $fileLink = "$relativePath/$folder/$file" -replace '\\', '/' -replace '//+', '/'
            $outputLines += "$fileIndent- [$file]($fileLink)"

            foreach ($link in $tree[$folder][$file]) {
                $linkIndent = "$fileIndent    "
                $outputLines += "$linkIndent$link"
            }
        }
    }

    # Write to MarkdownFilePath
    $outputLines | Set-Content -Path $MarkdownFilePath -Encoding UTF8

    # Open the file after creation
    Start-Process -FilePath $MarkdownFilePath
}