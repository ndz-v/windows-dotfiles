######################
## PowerShell setup ##
######################

# Set execution policy to remote signed
Set-ExecutionPolicy RemoteSigned

# Set network category to private
Set-NetConnectionProfile -NetworkCategory Private

# PowerShell
New-Item -Force -ItemType SymbolicLink "$HOME\Documents\" -Name "WindowsPowerShell" -Value "$HOME\dev\windows-dotfiles\WindowsPowerShell"

# Install posh git 
PowerShellGet\Install-Module posh-git -Scope CurrentUser -Force

# Install oh-my-posh ##
Install-Module oh-my-posh -Scope CurrentUser

########################
## Install Chocolatey ##
########################

Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

########################
## Install software ##
########################

choco.exe install conemu -y
choco.exe install git -y
choco.exe install vscode -y

################################
## Install VS Code Extensions ##
################################
# $installation_block = { 
#     $extensions =
#     'albert.TabOut',
#     'eamodio.gitlens',
#     'ms-vscode.csharp',
#     'ms-vscode.powershell',
#     'ms-vsliveshare.vsliveshare',
#     'PKief.material-icon-theme',
#     'ritwickdey.LiveServer',
#     'shd101wyy.markdown-preview-enhanced',
#     'sidneys1.gitconfig',
#     'Tyriar.sort-lines',
#     'VisualStudioExptTeam.vscodeintellicode',
#     'yycalm.linecount',
#     'zhuangtongfa.Material-theme'

#     for ($i = 0; $i -lt $extensions.Count; $i++) {
#         code --install-extension $extensions[$i]
#     } 
# }

# # Invoke new poweshell instance so code is in path
# Start-Process powershell -ArgumentList "-command $installation_block"

###########################
## Create symbolik links ##
###########################

# Visual Studio Code settings.json
New-Item -Force -ItemType SymbolicLink $HOME\AppData\Roaming\Code\User\ -Name settings.json -Value $HOME\dev\windows-dotfiles\vscode\settings.json

# Visual Studio Code keybindings
New-Item -Force -ItemType SymbolicLink $HOME\AppData\Roaming\Code\User\ -Name keybindings.json -Value $HOME\dev\windows-dotfiles\vscode\keybindings.json

# .gitconfig
New-Item -Force -ItemType SymbolicLink $HOME\ -Name .gitconfig -Value $HOME\dev\windows-dotfiles\git\.gitconfig

# ConEmu Settings
New-Item -Force -ItemType SymbolicLink $HOME\AppData\Roaming -Name ConEmu.xml -Value $HOME\dev\windows-dotfiles\ConEmu\ConEmu.xml

# Update the current session environment variables
Update-SessionEnvironment 

# Clone this repository bare
git clone --bare git@github.com:ndz-v/windows-dotfiles.git .git

# Enable WSL feature
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
# Enable Virtual Machine feature
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
