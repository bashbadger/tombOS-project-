# PowerShell installer for Tomb-OS (Windows)
# Requires admin rights
# Install Node.js via winget if missing
if (-not (Get-Command node -ErrorAction SilentlyContinue)) {
  Write-Host "Installing Node.js via winget..."
  winget install -e --id OpenJS.NodeJS
}
# Install serve globally
npm install -g serve
# Copy files to ProgramData
$target = "C:\ProgramData\tomb-os"
New-Item -ItemType Directory -Force -Path $target
Copy-Item -Recurse -Force "$PSScriptRoot\*" $target
# Create a shortcut in %ProgramFiles% for easy launch
$shortcutPath = "C:\Program Files\tomb-os\tomb-os.bat"
New-Item -ItemType File -Force -Path $shortcutPath -Value "@echo off`nserve -s \"$target\" -l 8080"
# Register a Scheduled Task to run at startup
$action = New-ScheduledTaskAction -Execute $shortcutPath
$trigger = New-ScheduledTaskTrigger -AtStartup
Register-ScheduledTask -TaskName "TombOS" -Action $action -Trigger $trigger -RunLevel Highest -Force
Write-Host "Installation complete. Open http://localhost:8080 in a browser."
