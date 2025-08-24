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
    $rootFolderName = (Split-Path $sourcePath -Leaf)

    # Get all markdown files recursively
    $markdownFiles = Get-ChildItem -Path $sourcePath -Recurse -Filter *.md

    foreach ($file in $markdownFiles) {
        $fileContent = Get-Content $file.FullName -Encoding UTF8
        $fileName = $file.Name
        $fileDirectory = Split-Path $file.FullName -Parent
        $relativeDir = $fileDirectory.Substring($sourcePath.Length).TrimStart('\') -replace '\\', '/'

        $folderKey = if ($relativeDir) { $relativeDir } else { $rootFolderName }
        if (-not $tree.ContainsKey($folderKey)) {
            $tree[$folderKey] = @{}
        }

        $tree[$folderKey][$fileName] = @()

        foreach ($line in $fileContent) {
            if ($line -match '^\s*#{1,2}\s+(.*)') {
                $headingText = $Matches[1].Trim()

                # Normalize fragment for Markdown anchor
                $cleanHeading = $headingText -replace '[\uD800-\uDBFF][\uDC00-\uDFFF]', '' # surrogate pairs
                $cleanHeading = $cleanHeading -replace '[^\w\s-]', ''                      # remove punctuation
                $fragmentSource = $cleanHeading -replace '\s+', '-'                        # normalize spaces
                $fragment = $fragmentSource.ToLower()

                # Construct GitHub-safe absolute link with root folder prefix
                $linkPath = if ($relativeDir) {
                    "$rootFolderName/$relativeDir/$fileName"
                } else {
                    "$rootFolderName/$fileName"
                }

                $link = "$githubBaseUrl/$linkPath#$fragment"
                $tree[$folderKey][$fileName] += "- 🔗 [$headingText]($link)"
            }
        }
    }

    $outputLines = @()
    $outputLines += "- 📁 $rootFolderName/"
    foreach ($folder in $tree.Keys | Sort-Object) {
        $folderIndent = "    "
        $folderPath = "$folder/"
        $outputLines += "${folderIndent}- 📁 $folderPath"

        foreach ($file in $tree[$folder].Keys | Sort-Object) {
            $fileIndent = "${folderIndent}    "
            $filePath = "$rootFolderName/$folder/$file"
            $fileLink = "$githubBaseUrl/$filePath"
            $outputLines += "${fileIndent}- 📄 [$file]($fileLink)" -replace '.md', ''

            foreach ($link in $tree[$folder][$file]) {
                $linkIndent = "${fileIndent}    "
                $outputLines += "${linkIndent}$link"
            }
        }
    }

    # Write to MarkdownFilePath
    $outputLines | Set-Content -Path $MarkdownFilePath -Encoding UTF8

    # Open the file after creation
    Start-Process -FilePath $MarkdownFilePath
}