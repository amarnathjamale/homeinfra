function VSCode {
    winget install -e --id Microsoft.VisualStudioCode
}

function WSL {
    wsl --install
    winget install -e --id whitewaterfoundry.fedora-remix-for-wsl
    wsl -d fedoraremix -u root curl -fsSL https://raw.githubusercontent.com/amarnathjamale/homeinfra/master/Linux/setup.bash | bash
}

function Hardening {
    Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force
    Invoke-RestMethod script.sophi.app | Invoke-Expression
    Set-Location $DownloadsFolder\Sophia*
    .\Sophia.ps1
}

function Apps {
    winget install Git.Git
    winget install python
    choco install mpv -y
}

function ALL {
    Apps
    VSCode
    WSL
    Hardening
}

function Show-Menu {
    param (
        [string]$Title = "Amar's Windows Setup"
    )
    Clear-Host
    Write-Host "================ $Title ================"

    Write-Host "1: VSCode Setup"
    Write-Host "2: WSL Setup"
    Write-Host "3: Hardening"
    Write-Host "4: Deafult Apps"
    Write-Host "5. ALL"
    Write-Host "q: Quit"

}

Show-Menu -Title "Amar's Windows Setup"
$selection = Read-Host "Please make a selection"


do {
    Show-Menu
    $selection = Read-Host "Please make a selection"
    switch ($selection) {
        '1' { VSCode }
        '2' { WSL }
        '3' { Hardening }
        '4' { Apps }
        '5' { ALL }
    }
    pause
}
until ($selection -eq 'q')