# run as admin

# remove chocolatey directory if it exists
Remove-Item 'C:\ProgramData\chocolatey' -Recurse
# make link for chocolatey install dir
# old way
# cmd /c mklink /d c:\ProgramData\chocolatey d:\ProgramData\chocolatey
# new way
New-Item -ItemType SymbolicLink -Path "C:\ProgramData\chocolatey" -Target "D:\ProgramData\chocolatey"

# install chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# app install dir
$installdir= "D:\chocolatey_installs"
# apps to install
$apps=  # drivers
        "amd-ryzen-chipset",
        "realtek-hd-audio-driver",
        "intel-bluetooth-drivers",
        "nvidia-display-driver",        
        # tools
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
        "wsl",
        "wsl-ubuntu-2204", # update?
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
        "powershell-core",
        "go",
        # misc
        "shotcut",
        "spotify",
        "steam-client",


# install each app in array
Foreach ($app in $apps) {
    choco install $app --install-directory="$installdir\$app" -y
}

# install battle.net client
wget https://www.battle.net/download/getInstallerForGame?os=win&gameProgram=BATTLENET_APP&version=Live
./Battle.net-Setup.exe
