# Get-TableOfContentsFromFolder PowerShell Function

## Purpose
This function generates a Markdown-formatted Table of Contents (TOC) by scanning all .md files within a specified folder. 
It extracts headings (# or ##) and builds relative links that are valid from the location of a target Markdown file.


## Parameters
``-Path``
``-MarkdownFilePath``


## How It Works
- Resolves both paths to absolute form.
- Calculates the relative path from the Markdown file to the folder being scanned.
- Recursively scans all .md files in the source folder.
- Extracts headings (# or ##) from each file.
- Normalizes heading text into Markdown anchor fragments.
- Constructs relative links that work from the Markdown file’s location.
- Returns a list of Markdown-formatted links.

## Sample Invocation

```powershell
Powershell
$tableOfContents = Get-TableOfContentsFromFolder `
    -Path "C:\Users\sjacobs\OneDrive\Documents\Evanescent\microsoft-fabric-data-engineering\fabric\dataflows" `
    -MarkdownFilePath "C:\Users\sjacobs\OneDrive\Documents\Evanescent\microsoft-fabric-data-engineering\learning-modules"

# print to the screen
$tableOfContents | ForEach-Object { Write-Output $_ }

#save to a file
$tableOfContents | Set-Content -Path "$MarkdownFilePath\TOC.md"

```

## Sample Output
```markdown
Markdown
[Refreshing Column Mapping in Dataflows Gen2](../../fabric/dataflows/dataflow-destination.md#refreshing-column-mapping-in-dataflows-gen2)
[What Happens When Source Schema Changes?](../../fabric/dataflows/dataflow-destination.md#what-happens-when-source-schema-changes)
[Gen2 Workflow Documentation](../../fabric/dataflows/gen2-overview.md#gen2-workflow-documentation)
[Documentation Best Practices](../../fabric/dataflows/gen2-overview.md#documentation-best-practices)
[Automated Schema Extraction Methods – Dataflows Gen2](../../fabric/dataflows/schema-extraction.md#automated-schema-extraction-methods--dataflows-gen2)
```

- Links are valid from the Markdown file’s location
- Headings are normalized into anchor fragments
- Paths are relative and reproducible across machines

## Troubleshooting Tips
- **No output**? Make sure to include `$tableOfContents | ForEach-Object { Write-Output $_ }`
- **Double slashes**? Ensure `$subfolderPath` doesn’t end with /, and clean up with `-replace '//', '/'`
- **Incorrect relative path**? Use `System.Uri.MakeRelativeUri()` to calculate traversal from Markdown file to source folder
- **Headings not matched**? Use a flexible regex: `'^\s*#{1,2}\s+(.*)'` to catch indented or multi-level headings
