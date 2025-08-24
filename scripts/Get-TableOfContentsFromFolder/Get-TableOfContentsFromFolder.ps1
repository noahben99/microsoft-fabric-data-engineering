function Get-TableOfContentsFromFolder {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$Path,

        [Parameter(Mandatory = $true)]
        [string]$MarkdownFilePath
    )

    $tree = @{}

    # Hard-coded GitHub base URL — CHANGE THIS if using a different repo or branch
    $githubBaseUrl = "https://github.com/noahben99/microsoft-fabric-data-engineering/blob/main"

    # Normalize source path
    $sourcePath = (Resolve-Path $Path).Path

    # Extract root folder name from $Path
    $rootFolderName = (Split-Path $sourcePath -Leaf).ToLower() + "/"

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

                # Construct GitHub-safe absolute link
                $linkPath = if ($relativeDir) { "$relativeDir/$fileName" } else { "$fileName" }
                $link = "$githubBaseUrl/$linkPath#$fragment" -replace '//+', '/'
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

            # GitHub-safe absolute link to file (no anchor)
            $filePath = if ($folder) { "$folder/$file" } else { "$file" }
            $fileLink = "$githubBaseUrl/$filePath" -replace '//+', '/'
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