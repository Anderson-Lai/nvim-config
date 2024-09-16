### Installing Neovim on Ubuntu
```
cd ~
sudo snap install nvim --classic
sudo ln -s ~/snap/nvim nvim
```

### Downloading Neovim Plugins
```
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
mkdir ~/.config
```

### Fetching Neovim configs
```
cd ~/.config
git clone https://github.com/Anderson-Lai/neovim-config.git
mv neovim-config nvim
```

### Setting up file tree 
Download CodeNewRoman Nerd Font [here](https://www.nerdfonts.com/font-downloads)  
Extract the file
```
sudo mv ~/Downloads/CodeNewRoman /usr/share/fonts
sudo fc-cache -fv
```
Terminal Preferences -> Profiles -> Unnamed -> Text -> Custom font -> CodeNewRoman Nerd Font Mono  
Set the size to 14

### Setting up xclip
```
sudo apt install xclip
exit
```

### Installing Plug Extensions
```
nvim
:PlugInstall
:qa!
```

### Installing Coc Extensions
```
nvim
:CocInstall coc-clangd
:CocInstall coc-html
:CocInstall coc-tsserver
:CocInstall coc-rust-analyzer
:CocInstall coc-pyright
:CocInstall coc-json
:CocInstall coc-cmake
:CocList extensions (use to ensure all extensions are installed)
:qa!
```
### Installing Treesitter Extensions
```
:TSInstall c
:TSInstall cpp 
:TSInstall html 
:TSInstall javascript 
:TSInstall typescript
:TSInstall query
:TSInstall vimdoc
:TSInstall lua
```

### Setting up intellisense for C/C++
```
sudo apt install clang
sudo apt install clangd
sudo apt install llvm 
sudo apt install ccls
sudo apt install nodejs
sudo apt install npm
```

### Setting up intellisense for Rust
#### First, install rust and cargo
```
curl https://sh.rustup.rs -sSf | sh 
exit
```

#### Installing rust-analyzer
```
rustup component add rustc
rustup component add rust-analyzer-preview
```

### Installing Javascript/Typescript support
```
sudo npm install -g typescript-language-server
sudo npm install -g typescript
```

### Installing Tailwind support
```
sudo npm install -g tailwindcss-language-server
```

### Installing Python support
```
sudo apt install python3-pynvim
```

### Cleanup
```
cd ~
rm -rf nvim
```

### Fixing git
Use [this](https://github.com/git-ecosystem/git-credential-manager/blob/release/docs/install.md) to fix git credentials
