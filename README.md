# dotfiles
nateharward's personal dotfiles

Does not include any work-specific config

Contains submodules, may want to clone with --recursive
git clone --recursive https://github.com/nateharward/dotfiles

otherwise:
$ git submodule init
$ git submodule update


contains rc files that map to the following:
* VIM     ~/.vimrc
* TMUX    ~/.tmux.conf
* BASH    ~/.bashrc.$USER (sourced by .bashrc)
* XTERM   ~/.Xresources
* TIG     ~/.tigrc
* SCIM    ~/.scimrc
* ALIASES ~/.aliases-personal (bash aliases sourced by .bashrc.$USER)
* GIT     ~/.gitconfig

todo
* gitconfig
* aliases

#### Proxy setup notes

.curlrc add 
    proxy =http://<path>:<port>

.wgetrc add 
    http_proxy=http://<path>:<port>"
    https_proxy=https://<path>:<port>"

http git, add to .gitconfig
    [http]
        proxy = http://<path>:<port>
    [https]
        proxy = https://<path>:<port>

git:// on ssh
    Host github.com
        ProxyCommand nc -X 5 -x <path>:<port> %h %p

apt install  /etc/apt/apt.conf   
    Acquire::http::Proxy "http://<path>:<port>";
    Acquire::ftp::Proxy "TODO";


