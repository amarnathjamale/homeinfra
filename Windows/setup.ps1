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
    winget install VisualStudioCode
    winget install VideoLAN.VLC
    choco install mpv -y
}

function Spotify {
    #Installs Spotify and patches it for adblock
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; iex "& { $((iwr -useb 'https://raw.githubusercontent.com/SpotX-CLI/SpotX-Win/main/Install.ps1').Content) } -confirm_uninstall_ms_spoti -confirm_spoti_recomended_over -cache_off -block_update_on -start_spoti"
    #Install spicetify
    Invoke-WebRequest -UseBasicParsing "https://raw.githubusercontent.com/spicetify/spicetify-themes/master/Dribbblish/install.ps1" | Invoke-Expression
    #Configure spicetify
    spicetify config color_scheme Purple
    spicetify apply
}

function ALL {
    Apps
    VSCode
    WSL
    Hardening
    Spotify
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
    Write-Host "5: Spotify Setup"
    Write-Host "6. ALL"
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
        '5' { Spotify }
        '6' { ALL }
    }
    pause
}
until ($selection -eq 'q')