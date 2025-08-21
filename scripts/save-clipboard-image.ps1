param(
    [string]$filename,
    [string]$path
)

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# --- Prompt for filename if not supplied ---
if (-not $filename) {
    $filename = Read-Host "Enter filename (without extension)"
}

# --- Get image from clipboard ---
$image = [Windows.Forms.Clipboard]::GetImage()
if ($null -eq $image) {
    Write-Host "No image found in clipboard." -ForegroundColor Yellow
    exit 1
}

# --- Determine save path ---
$finalName = "$filename.png"

if ($path) {
    $basePath = "C:\Users\sjacobs\OneDrive\Documents\Evanescent\microsoft-fabric-data-engineering"
    $saveDirectory = Join-Path $basePath $path
} else {
    $saveDirectory = Get-Location
}

# --- Ensure target directory exists ---
if (-not (Test-Path $saveDirectory)) {
    Write-Host "Directory not found: $saveDirectory" -ForegroundColor Red
    exit 1
}

$savePath = Join-Path $saveDirectory $finalName
$image.Save($savePath, [System.Drawing.Imaging.ImageFormat]::Png)

# --- Markdown link output ---
$mdLink = "![${filename}](${finalName})"
Write-Host $mdLink