# Define the path to the Chrome executable
$chromePath = "C:\Program Files\Google\Chrome\Application\chrome.exe"

# Function to fetch the latest Chrome version from Google's API
function Get-LatestChromeVersion {
    try {
        # Fetch the latest version from Google's official API
        $url = "https://versionhistory.googleapis.com/v1/chrome/platforms/win/channels/stable/versions"
        $jsonData = Invoke-RestMethod -Uri $url -UseBasicParsing
        $latestVersion = $jsonData.versions[0].version
        return $latestVersion
    } catch {
        Write-Output "Error: Unable to fetch the latest Chrome version."
        exit 1
    }
}

# Fetch the latest Chrome version
$latestVersion = Get-LatestChromeVersion

# Check if Chrome is installed
if (Test-Path $chromePath) {
    # Get the installed Chrome version
    $installedVersion = (Get-Item $chromePath).VersionInfo.ProductVersion

    # Compare installed version with the latest version
    if ([version]$installedVersion -lt [version]$latestVersion) {
        Write-Output "Chrome is OUTDATED. Installed: $installedVersion | Latest: $latestVersion."
        exit 1
    } else {
        Write-Output "Chrome is UP-TO-DATE. Installed: $installedVersion."
        exit 0
    }
} else {
    Write-Output "Google Chrome is NOT installed."
    exit 1
}
