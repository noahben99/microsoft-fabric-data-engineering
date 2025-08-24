function Get-TableOfContentsFromFolder {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$Path,

        [Parameter(Mandatory = $true)]
        [string]$MarkdownFilePath
    )

    $toc = @()

    # Normalize paths
    $sourcePath = (Resolve-Path $Path).Path
    $targetPath = (Resolve-Path $MarkdownFilePath).Path
    # Write-Host "Source Path: $sourcePath"
    # Write-Host "Target Path: $targetPath"

    # Calculate relative path from MarkdownFilePath to Path
    $uriTarget = New-Object System.Uri("$targetPath\")
    $uriSource = New-Object System.Uri("$sourcePath\")
    $relativePath = $uriTarget.MakeRelativeUri($uriSource).ToString() -replace '%20', ' ' -replace '/', '/'
    # Write-Host "Relative Path: $relativePath"

    # Get all markdown files recursively
    $markdownFiles = Get-ChildItem -Path $sourcePath -Recurse -Filter *.md
    # Write-Host "Markdown files found: $($markdownFiles.Count)"

    foreach ($file in $markdownFiles) {
        $fileContent = Get-Content $file.FullName
        $fileName = $file.Name
        $fileDirectory = Split-Path $file.FullName -Parent

        # Determine subfolder path relative to $Path
        $subfolder = $fileDirectory.Substring($sourcePath.Length).TrimStart('\') -replace '\\', '/'
        $subfolderPath = if ($subfolder) { "$subfolder" } else { "" }

        foreach ($line in $fileContent) {
            if ($line -match '^\s*#{1,2}\s+(.*)') {
                $headingText = $Matches[1].Trim()
                # Write-Host "Matched heading: $headingText"

                # Normalize fragment for Markdown anchor
                $fragmentSource = $headingText -replace '\p{So}', '' -replace '[^\w\s-]', '' -replace '\s+', '-'
                $fragment = $fragmentSource.ToLower()

                # Construct valid Markdown link
                $link = "$relativePath/$subfolderPath/$fileName#$fragment" -replace '//', '/'
                $toc += "[${headingText}]($link)"
                # Write-Host "TOC Entry: [$headingText]($link)"
            }
        }
    }

    # Write-Host "TOC count: $($toc.Count)"
    return $toc
}
