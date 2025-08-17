
param(
    [ValidateSet("week01", "week02", "week03", "week04", "week05", "week06")]
    [string]$path,

    [string]$filename
)

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# --- Base repo path ---
$basePath = "C:\Users\sjacobs\OneDrive\Documents\Evanescent\microsoft-fabric-data-engineering"

# --- Prompt for path if not supplied ---
if (-not $path) {
    $validWeeks = @("week01","week02","week03","week04","week05","week06")
    do {
        $path = Read-Host "Enter week (week01 - week06)"
    } until ($validWeeks -contains $path)
}

# --- Prompt for filename if not supplied ---
if (-not $filename) {
    $filename = Read-Host "Enter filename (without extension)"
}

# --- Find matching week folder ---
$weekFolder = Get-ChildItem -Path $basePath -Directory |
              Where-Object { $_.Name -like "$path*" } |
              Select-Object -First 1

if (-not $weekFolder) {
    Write-Host "No folder found starting with $path under $basePath" -ForegroundColor Red
    exit 1
}

# --- Assets folder path ---
$assetsFolder = Join-Path $weekFolder.FullName "assets"

if (-not (Test-Path $assetsFolder)) {
    Write-Host "Assets folder not found at $assetsFolder" -ForegroundColor Red
    exit 1
}

# --- Get image from clipboard ---
$image = [Windows.Forms.Clipboard]::GetImage()
if ($null -eq $image) {
    Write-Host "No image found in clipboard." -ForegroundColor Yellow
    exit 1
}

# --- Save the image ---
$finalName = "$filename.png"
$savePath  = Join-Path $assetsFolder $finalName
$image.Save($savePath, [System.Drawing.Imaging.ImageFormat]::Png)

# --- Markdown link output ---
$relativePath = "assets/$finalName"
$mdLink = "![${filename}](${relativePath})"

Write-Host $mdLink
