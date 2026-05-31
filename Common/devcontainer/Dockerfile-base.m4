FROM docker.io/debian:trixie

ARG DOT_HOME="/root"
ARG DOTFILES_REPO="https://git.jakobstendahl.no/jakobst1n/dotfiles"
ARG GIT_EMAIL="jakob@jakobstendahl.no"
ARG GIT_USER="jakobst1n"

# Install base requirements
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    fzf \
    man-db \
    less \
    supervisor \
    git \
    make \
    dialog \
    m4 \
    npm \
    sudo

# Create and switch to non-root-user
#RUN useradd -d ${DOT_HOME} -m devuser
#RUN usermod -a -G sudo devuser
#RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

WORKDIR ${DOT_HOME}
#USER devuser

# Install dotfiles
RUN mkdir -p ${DOT_HOME}/
RUN git clone ${DOTFILES_REPO} ${DOT_HOME}/dotfiles
WORKDIR ${DOT_HOME}/dotfiles
RUN cat > config <<EOF
DT_DISTRO=debian
DT_DOTFILES_DIR=${DOT_HOME}/dotfiles
DT_DOTFILES_TYPE=remote
DT_EDITOR=nvim
DT_GIT_EMAIL=${GIT_EMAIL}
DT_GIT_USER=${GIT_USER}
DT_HOME_DIRECTORY=${DOT_HOME}
DT_SHELL=/bin/bash
DT_SYSID=1
DT_HOMEBIN=yes
DT_BASH=yes
DT_INPUTRC=yes
DT_MYCLI=yes
DT_NEOVIM=yes
DT_OS=linux
DT_OTHER_SYMLINKS=yes
DT_TMUX=yes
DT_TOOLS=yes
DT_VIM=yes
EOF
RUN m4 -P Makefile.m4 > Makefile
RUN make Makefile
RUN make && rm -rf /tmp/nvim && rm -rf /var/lib/api/lists/*
RUN nvim --headless +qa

# Create project directory
#RUN mkdir -p ${DOT_HOME}/project
#WORKDIR ${DOT_HOME}/project
RUN mkdir -p /workspace
WORKDIR /workspace

# Install usefull tools
RUN npm i -g opencode-ai

# Copy supervisord conf
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
#RUN mkdir -p ${DOT_HOME}/.local/share/supervisord && \
#    touch ${DOT_HOME}/.local/share/supervisord/supervisord.log
#RUN touch ${DOT_HOME}/.local/share/supervisord/supervisord.pid && \
#    chown devuser:devuser /var/run/supervisord.pid

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
