# run as admin
if([Security.Principal.WindowsIdentity]::GetCurrent().Groups -contains 'S-1-5-32-544') { 
    Write-Host 'Please re-run script as administrator...'
    Exit 1

}
# remove chocolatey directory if it exists
Remove-Item 'C:\ProgramData\chocolatey' -Recurse
# make link for chocolatey install dir
# old way
# cmd /c mklink /d c:\ProgramData\chocolatey d:\ProgramData\chocolatey
# new way
New-Item -ItemType SymbolicLink -Path "C:\ProgramData\chocolatey" -Target "D:\ProgramData\chocolatey"

# install chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# app install dir
$installdir= "D:\chocolatey_installs"
# apps to install
$apps=  # drivers
        "amd-ryzen-chipset",
        "realtek-hd-audio-driver",
        "intel-bluetooth-drivers",
        "nvidia-display-driver",        
        # tools
        "powershell-core",
        "wsl",
        "wsl-ubuntu-2204", # update?
        "7zip", 
        "googlechrome",
        "hyper",
        "virtualbox",
        "docker-desktop",
        "vscode", 
        "todobackup",
        "mremoteng",
        "samsung-magician",
        "discord",
        "signal",
        "msiafterburner",
        "bitvise-ssh-client",
        "teamviewer",
        "vlc",
        "windirstat"
        # dev
        "python", 
        "pip",
        "git",
        "ruby",
        "lua",
        "nodejs", 
        "go",
        # misc
        "shotcut",
        "spotify",
        "steam-client"

# install each app in array
Foreach ($app in $apps) {
    choco install $app --install-directory="$installdir\$app" -y
}

# install battle.net client
wget https://www.battle.net/download/getInstallerForGame?os=win&gameProgram=BATTLENET_APP&version=Live
./Battle.net-Setup.exe --lang=enUS --installpath="D:\Program Files (x86)\Battle.net"

## Uninstall BNET
#
# function Stop-ProcessName {
#     param ($ExeName)
    
#     while ($true) {
#         [array]$Processes = Get-Process $ExeName -ErrorAction SilentlyContinue
#         if($Processes.Length -gt 0) {
#             Foreach($process in $Processes) {
#             Stop-Process -Name $process -Force
#         }
#         }
#
# }
# }
#
# Stop-ProcessName('Agent')
# Stop-ProcessName('Battle.net')
#
# # app files
# Remove-Item -Recurse /S "$env:LocalAppData\Battle.net" -Force
# Remove-Item -Recurse /S "$env:LocalAppData\Blizzard Entertainment" -Force
# Remove-Item -Recurse /S "$env:AppData\Battle.net" -Force
# Remove-Item -Recurse /S "$env:ProgramData\Battle.net" -Force
# Remove-Item -Recurse /S "$env:ProgramFiles(x86)\Battle.net" -Force
# Remove-Item -Recurse /S "$env:ALLUSERSPROFILE\Microsoft\Windows\Start Menu\Programs\Battle.net*" -Force
# Remove-Item -Recurse /S "$env:PUBLICDesktop\Battle.net.lnk" -Force
# # registry
# Remove-Item HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Battle.net -Force