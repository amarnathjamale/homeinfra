# Debloat Windows
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force
Set-Location $DownloadsFolder
Invoke-RestMethod script.sophi.app | Invoke-Expression
Set-Location Sophia*
.\Sophia.ps1

# Setup Windows Variables

# Modify Windows Configurations

# Install Necessary Drivers

# Install Core Apps

Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
winget install Git.Git
winget install python

# Install Necessary Applications with their customizations

# Reboot