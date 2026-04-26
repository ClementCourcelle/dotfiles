apt install -y curl ca-certificates build-essential
sudo install -m 0755 -d /etc/apt/keyrings

# docker
install_docker() {
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
  curl chmod a+r /etc/apt/keyrings/docker.asc

  # Add the repository to Apt sources:
  tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/docker.asc
EOF

  apt update
  apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
  groupadd docker
  usermod -aG docker $SUDO_USER
}

# venv
install_python_env() {
  apt install -y python3-venv python3-pip
}

# Kitty
install_kitty() {
  curl -L https://sw.kovidgoyal.net/kitty/installer.sh -o /tmp/kitty-installer.sh
  sh /tmp/kitty-installer.sh
  ln -s $SUDO_HOME/.local/kitty.app/bin/kitty /usr/local/bin/kitty 
  ln -s $SUDO_HOME/.local/kitty.app/bin/kitten /usr/local/bin/kitten
  update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/local/bin/kitty 100
}

# Zsh
install_zsh() {
  apt install -y zsh
  chsh -s $(which zsh)
}

#fzf, fd
install_find() {
  apt install -y fd-find
  ln -s $(which fdfind) /usr/local/bin/fd
  git clone --depth 1 https://github.com/junegunn/fzf.git $SUDO_HOME/.fzf
  $SUDO_HOME/.fzf/install --key-bindings --completion --no-update-rc
  ln -s $SUDO_HOME/.fzf/bin/fzf /usr/local/bin/fzf
}

# Tmux
install_tmux() {
  apt install -y tmux 
}

# Nvim
install_nvim() {
  curl -L https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz -o /tmp/nvim
  tar -C /opt -xzf /tmp/nvim
  ln -s /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim
}

# TODO Clang

# Nodejs
install_node() {
  curl -fsSL https://deb.nodesource.com/setup_23.x -o /tmp/node_setup.sh
  sh /tmp/node_setup.sh
  apt install -y nodejs
}

install_docker
install_python_env
install_kitty
install_zsh
install_find
install_tmux
install_nvim
install_node
