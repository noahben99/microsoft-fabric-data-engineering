param (
    [string]$RepoRoot = "$PSScriptRoot\..",
    [string]$ChangelogPath = "$PSScriptRoot\..\CHANGELOG.md",
    [switch]$NoLog,
    [switch]$AutoMessage
)

function Get-CommitMessage {
    param ([string[]]$DiffSummary)

    $fileCount = $DiffSummary.Count
    if ($fileCount -eq 1) {
        return "! updated $($DiffSummary[0])"
    } else {
        $fileList = $DiffSummary -join ', '
        return "! updated $fileCount files: $fileList"
    }
}

function Get-ChangelogEmoji {
    param ([string]$Message)

    switch -Regex ($Message) {
        "docs|note"    { return "!" }
        "fix|bug"      { return "!" }
        "feature|add"  { return "!" }
        default        { return "!" }
    }
}

# Navigate to repo
Set-Location $RepoRoot

# Preview staged changes
Write-Host "`n! Staged Changes:"
git status

# Generate commit message
if ($AutoMessage) {
    $diffSummary = git diff --cached --name-only | Where-Object { $_ -ne "" }
    $CommitMessage = Get-CommitMessage -DiffSummary $diffSummary
} else {
    $CommitMessage = Read-Host "Enter commit message"
}

# Git operations
git add .
git commit -m $CommitMessage
git push origin main

# Optional changelog logging