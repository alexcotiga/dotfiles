{ user, ... }:

{
  # ─── Nix / nixpkgs ─────────────────────────────────────────────
  # Determinate already manages the Nix daemon, so nix-darwin shouldn't.
  nix.enable = false;

  nixpkgs.config.allowUnfree = true;
  nixpkgs.hostPlatform = "aarch64-darwin";  # use x86_64-darwin for Intel CPU

  # ─── User ──────────────────────────────────────────────────────
  system.primaryUser = user;
  users.users.${user} = {
    home = "/Users/${user}";
  };

  # ─── System ────────────────────────────────────────────────────
  system.stateVersion = 6;

  system.defaults = {
    # Keyboard
    NSGlobalDomain = {
      KeyRepeat = 2;                  # fast key repeat
      InitialKeyRepeat = 15;          # short delay before repeat

      # Appearance
      # AppleInterfaceStyle = "Light";
      # _HIHideMenuBar = true;          # auto-hide the menu bar
      AppleShowAllExtensions = true;  # always show file extensions
    };

    # Dock
    dock.autohide = true;

    # Finder
    finder = {
      FXPreferredViewStyle = "clmv";
      CreateDesktop = false;          # clean desktop
      AppleShowAllFiles = true;       # show hidden and system files
      ShowPathbar = true;             # path bar at the bottom of windows
      ShowStatusBar = true;           # status bar with icon size and free space
    };

    # Trackpad
    trackpad.Clicking = true;         # tap to click
  };

  # ─── Homebrew ──────────────────────────────────────────────────
  nix-homebrew = {
    enable = true;
    inherit user;
  };

  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";     # fully declarative: remove anything not listed here
    onActivation.autoUpdate = true;
    onActivation.extraFlags = [ "--force" ];

    brews = [
      "herdr"
    ];

    casks = [
      "ghostty"
      "wezterm"
      "claude-code"
      "font-aporetic"
      "font-fira-code"
    ];
  };
}
