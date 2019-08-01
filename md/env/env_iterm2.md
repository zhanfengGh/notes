### Iterm2 环境搭建

1. 安装brew

   > /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

2. 安装iterm2

   >brew cask install iterm2

3. 安装oh-my-zsh

   > git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
   >
   > cd ~; mv ~/.zshrc ${HOME}/Library/Mobile\ Documents/com~apple~CloudDocs/Settings/zsh/zshrc
   >
   > ln -s "${HOME}/Library/Mobile Documents/com~apple~CloudDocs/Settings/zsh/zshrc" ~/.zshrc

4. 转换成zsh

   > chsh -s /bin/bash
   >
   > chsh -s /bin/zsh
   >
   > 查看当前的shell：ps -p $$

5. 安装zsh-plugins

  > brew install  zsh-autosuggestions zsh-syntax-highlighting zsh-completions

6. 下载solarized配色方案

   > git clone git://github.com/altercation/solarized.git

7. 安装power-line 字体

   > ```
   > # clone
   > git clone https://github.com/powerline/fonts.git --depth=1
   > # install
   > cd fonts
   > ./install.sh
   > # clean-up a bit
   > cd ..
   > rm -rf fonts
   > ```

8. ssh 配置文件，直接关联dropbox

   ```
   cd ~/.ssh;find . -name "id_rsa"|xargs chmod 600
   ```

9. fzf [A command-line fuzzy finder](https://github.com/junegunn/fzf)

   > brew install fzf
   >
   > /usr/local/opt/fzf/install

10. autojump [A cd command that learns - easily navigate directories from the command line](https://github.com/wting/autojump)

   > brew install autojump
   >
   > j notes 会自动跳转到~/workspace/gitHub/notes目录

11. Awesome shell

   > 1. tree
   > 2. 