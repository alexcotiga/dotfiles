{ config, pkgs, user, ... }:

let
  dotfiles = "${config.home.homeDirectory}/.dotfiles";
in

{
  home.username = user;
  home.homeDirectory = "/Users/${user}";
  home.stateVersion = "24.11";
  home.packages = with pkgs; [
    bat
    broot
    btop
    bun
    cmake
    dua
    eza
    fd        # fast find
    gh
    gh
    gron
    helix
    hexyl
    htop      # interactive process viewer
    jjui
    jless
    jq
    jq        # json on the command line
    jujutsu
    lazygit
    lazygit
    lsd
    mosh
    mprocs
    neovim
    nerd-fonts.hack
    ninja
    ranger
    rich-cli
    ripgrep   # fast search
    television
    tig       # text-mode git interface
    timewarrior
    tmux
    tree
    uv        # fast python package manager
    visidata
    zellij
  ];
  fonts.fontconfig.enable = true;
  home.sessionVariables.EDITOR = "nvim";
  home.sessionVariables.IDASRC = "/Volumes/Hex/code/ida";
  home.sessionPath = [ "$HOME/.local/bin" ];

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;      # ghost text from history
    syntaxHighlighting.enable = true;  # commands turn green when valid
    history = {
      size = 100000;
      save = 100000;
      extended = true;         # timestamps in history file
      ignoreAllDups = true;    # only keep the most recent copy of any command
      findNoDups = true;       # don't show dupes when searching (great for fzf CTRL-R)
      saveNoDups = true;       # don't write dupes to the file
      # share, ignoreDups, ignoreSpace stay at their sensible defaults (true)
    };
    initContent = ''
      bindkey '^f' autosuggest-accept
      # Case-insensitive tab completion (lowercase also matches uppercase).
      zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
      if [ -f "/Volumes/Hex/code/ida/tools/mac/env" ]; then
        source "/Volumes/Hex/code/ida/tools/mac/env"
      fi
    '';
    shellAliases = {
      ".." = "cd ..";
      # z = "cd";  # `z foo` jumps via zoxide (cd is zoxide-backed, see programs.zoxide)
      add = "git add .";
      push = "git push";
      pull = "git pull";
      # ls = "exa";
      # l = "exa -l";
      # la = "exa -la";
      ls = "lsd";
      l  = "lsd -l --group-dirs=first --sort=time --icon-theme fancy --blocks=date,permission,size,name";
      ll = "lsd -Lal --group-dirs=first";
      # m = "git switch main";
      cc = "claude --dangerously-skip-permissions";
      co = "codex --full-auto";
    };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;   # CTRL-R history, CTRL-T files, ALT-C cd
    defaultCommand = "fd --type f --hidden --follow --exclude .git";
    changeDirWidgetCommand = "fd --type d --hidden --follow --exclude .git";
  };

  programs.zoxide = {
    enable = true;                 # installs the zoxide binary too
    enableZshIntegration = true;   # hooks the shell so directory jumps are tracked
    options = [ "--cmd cd" ];      # `cd` itself becomes zoxide (plain cd still works)
  };

  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      # Two-line prompt: a box-drawing gutter (╭─ … ╰─❯) brackets each execution
      # so runs are easy to tell apart. Connector chars are unstyled, so they use
      # the terminal foreground and follow the GitHub High Contrast theme automatically.
      format = "╭─ $directory$git_branch$git_status$cmd_duration$line_break╰─$character";
      character = {
        success_symbol = "[❯](purple) ";
        error_symbol = "[❯](red) ";
      };
      cmd_duration.format = "[$duration]($style) ";
    };
  };

  # Edit-in-place: the real file stays in my repo, ~/.config just points at it.
  home.file.".config/wezterm".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/.config/wezterm";
  home.file.".config/lsd".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/.config/lsd";
  home.file.".config/nvim".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/.config/nvim";
  home.file.".config/ghostty".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/.config/ghostty";
  home.file.".config/helix".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/.config/helix";
  home.file.".config/herdr/config.toml".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/.config/herdr/config.toml";
  home.file.".claude/settings.json".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/.claude/settings.json";

  home.file.".claude/CLAUDE.md".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/AGENTS.md";
  home.file.".codex/AGENTS.md".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/AGENTS.md";
  home.file.".config/opencode/AGENTS.md".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/AGENTS.md";
}
