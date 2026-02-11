# Load Windows Forms assembly
Add-Type -AssemblyName System.Windows.Forms

# Define the URL for the latest Extended Stable Chrome installer (Enterprise MSI)
$chromeInstallerUrl = "https://dl.google.com/dl/chrome/install/googlechromestandaloneenterprise64.msi"

# Define the path to save the installer
$installerPath = "C:\Temp\chrome_installer.msi"

# Notify the user about the update
$popupMessage = "Google Chrome needs to be updated to the latest version. 
All open Chrome windows will be closed during the update. 
Please save your work. The update will start in 5 minutes."
[System.Windows.Forms.MessageBox]::Show($popupMessage, "Chrome Update Notification", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)

# Wait for 5 minutes (300 seconds) before proceeding
Start-Sleep -Seconds 300

# Close Chrome gracefully
$chromeProcess = Get-Process -Name "chrome" -ErrorAction SilentlyContinue
if ($chromeProcess) {
    Write-Output "Closing Chrome..."
    Stop-Process -Name "chrome" -Force
    Start-Sleep -Seconds 10 # Allow time for Chrome to close completely
}

# Ensure the Temp directory exists
if (-not (Test-Path "C:\Temp")) {
    New-Item -ItemType Directory -Path "C:\Temp" | Out-Null
}

# Download the latest Chrome Extended Stable installer
try {
    Write-Output "Downloading Chrome Extended Stable installer..."
    Invoke-WebRequest -Uri $chromeInstallerUrl -OutFile $installerPath
} catch {
    Write-Output "Failed to download Chrome Extended Stable installer."
    exit 1
}

# Run the MSI installer silently
Write-Output "Installing Chrome Extended Stable..."
$installProcess = Start-Process -FilePath "msiexec.exe" -ArgumentList "/i `"$installerPath`" /qn /norestart" -Wait -PassThru

# Check if installation was successful
if ($installProcess.ExitCode -eq 0) {
    Write-Output "Chrome Extended Stable update successful!"
    Remove-Item -Path $installerPath -Force
} else {
    Write-Output "Chrome Extended Stable update may have failed. Exit code: $($installProcess.ExitCode)"
}
