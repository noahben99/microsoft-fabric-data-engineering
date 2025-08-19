
# 🛠 Utilities

This folder contains helper scripts and tools that support workflow efficiency, automation, and asset management for the **Microsoft Fabric Data Engineering** training repository.

---

## 📄 Included Scripts

### 1. `save-clipboard-image.ps1`
> Save an image from your Windows clipboard directly into the correct `assets` folder for a given training week and return a ready‑to‑paste Markdown link.

**Features:**
- Accepts **week path** (`week01`–`week06`) and **filename** as parameters.
- Can **prompt interactively** if parameters are not provided.
- Automatically locates the matching `weekNN_*` folder and its `assets` subfolder.
- Appends `.png` extension automatically.
- Outputs Markdown syntax:  


**Usage examples:**
```powershell
# With parameters
cd "C:\Users\sjacobs\OneDrive\Documents\Evanescent\microsoft-fabric-data-engineering\utilities"  
.\save-clipboard-image.ps1 -path week03 -filename dataflow_overview

# Interactive prompts
cd "C:\Users\sjacobs\OneDrive\Documents\Evanescent\microsoft-fabric-data-engineering\utilities"  .\save-clipboard-image.ps1


Other one-liners
```powershell
# create a file and open in code.  Be sure you're in the correct directory
    Set-Content -Path .\README.md -Value "" ; code .\README.md

#jump to that repo, stage everything, commit with your message, and push
cd "C:\Users\sjacobs\OneDrive\Documents\Evanescent\microsoft-fabric-data-engineering"
git add .
git commit -m "added utilities and notes on module 1"
git push origin main
