# powershell install script for windows
# needs to be run as admin (but where home still points to user $HOME)

Write-Host "--------------------" -ForegroundColor Green
Write-Host "  Linking Dotfiles  " -ForegroundColor Red
Write-Host "--------------------" -ForegroundColor Green

# link vimrc
New-Item -ItemType SymbolicLink -Path "$HOME/_vimrc" -Target "$HOME/Repos/dotfiles/vimrc" 

# link Windows Terminal user settings
# there has got to be a better path without hashes in the name. Also cant seem to delete and get the link to work.  Diff files for now
#New-Item -ItemType SymbolicLink -Path "$HOME/AppData/Local/Packages/Microsoft.WindowsTerminal*/settings.json" -Target "$HOME/Repos/dotfiles/windows_term.settings.json" 
vimdiff "$HOME/Repos/dotfiles/windows_term.settings.json" "$HOME/AppData/Local/Packages/Microsoft.WindowsTerminal*/settings.json" 

# link VSCode user settings
# Diff files for now
#New-Item -ItemType SymbolicLink -Path "$HOME/AppData/Roaming/Code/User/settings.json" -Target "$HOME/Repos/dotfiles/vscode.settings.json" 
vimdiff "$HOME/Repos/dotfiles/vscode.settings.json"  "$HOME/AppData/Roaming/Code/User/settings.json" 

Write-Host "FIXME all other files" -ForegroundColor Green
