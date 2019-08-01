### Terminal 环境搭建

1. 下载安装ShadowSocksx-NG

   > https://github.com/shadowsocks/ShadowsocksX-NG/releases/

   > **配置好代理，下面的安装会很快**。
   >
   > ```shell
   > export all_proxy=socks5://127.0.0.1:1086
   > 
   > curl cip.cc
   > curl https://ip.cn
   > ```

2. 安装brew

   > /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

3. 安装iterm2

   >brew cask install iterm2

4. 安装oh-my-zsh

   > git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

   > **废弃，配置转mackup了**
   >
   > cd ~; mv ~/.zshrc ${HOME}/Library/Mobile\ Documents/com~apple~CloudDocs/Settings/zsh/zshrc
   >
   > ln -s "${HOME}/Library/Mobile Documents/com~apple~CloudDocs/Settings/zsh/zshrc" ~/.zshrc

5. 转换成zsh

   > chsh -s /bin/bash
   >
   > chsh -s /bin/zsh
   >
   > 查看当前的shell：ps -p $$

6. 下载solarized配色方案

   > git clone git://github.com/altercation/solarized.git

7. fzf [A command-line fuzzy finder](https://github.com/junegunn/fzf)

   > brew install fzf
   >
   > /usr/local/opt/fzf/install

8. autojump [A cd command that learns - easily navigate directories from the command line](https://github.com/wting/autojump)

   > brew install autojump
   >
   > j notes 会自动跳转到~/workspace/gitHub/notes目录

9. Awesome shell

  > 1. tree
  > 2. 