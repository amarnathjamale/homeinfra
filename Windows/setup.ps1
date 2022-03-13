# Debloat Windows
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force
Set-Location $DownloadsFolder
Invoke-RestMethod script.sophi.app | Invoke-Expression
Set-Location $DownloadsFolder\Sophia*
.\Sophia.ps1

# Setup for Ansible Host
# Upgrading PowerShell and .NET Framework
$url = "https://raw.githubusercontent.com/jborean93/ansible-windows/master/scripts/Upgrade-PowerShell.ps1"
$file = "$env:temp\Upgrade-PowerShell.ps1"
$username = "Administrator"
$password = "Password"

(New-Object -TypeName System.Net.WebClient).DownloadFile($url, $file)
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Force

# version can be 3.0, 4.0 or 5.1
&$file -Version 5.1 -Username $username -Password $password -Verbose

# WinRM Memory Hotfix
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$url_hostfix = "https://raw.githubusercontent.com/jborean93/ansible-windows/master/scripts/Install-WMF3Hotfix.ps1"
$file_hostfix = "$env:temp\Install-WMF3Hotfix.ps1"

(New-Object -TypeName System.Net.WebClient).DownloadFile($url_hostfix, $file_hostfix)
powershell.exe -ExecutionPolicy ByPass -File $file_hostfix -Verbose

# This isn't needed but is a good security practice to complete
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Force

$reg_winlogon_path = "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon"
Set-ItemProperty -Path $reg_winlogon_path -Name AutoAdminLogon -Value 0
Remove-ItemProperty -Path $reg_winlogon_path -Name DefaultUserName -ErrorAction SilentlyContinue
Remove-ItemProperty -Path $reg_winlogon_path -Name DefaultPassword -ErrorAction SilentlyContinue

# winrm setup 

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$url_winrm = "https://raw.githubusercontent.com/ansible/ansible/devel/examples/scripts/ConfigureRemotingForAnsible.ps1"
$file_winrm = "$env:temp\ConfigureRemotingForAnsible.ps1"

(New-Object -TypeName System.Net.WebClient).DownloadFile($url_winrm, $file_winrm)

powershell.exe -ExecutionPolicy ByPass -File $file_winrm


choco install --package-parameters=/SSHServerFeature openssh

# Modify Windows Configurations

# Install Necessary Drivers

# Install Core Apps

Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
winget install Git.Git
winget install python
choco install mpv -y

# Install Necessary Applications with their customizations

# Reboot
