{ pkgs, username, ... }:
{
  programs.zsh.enable = true;

  services.nix-daemon.enable = true;

  nix = {
    package = pkgs.nix;
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      keep-outputs = true;
      trusted-users = [ "root" username ];
    };
    # If you truly need raw lines, use extraOptions, but you don't here.
    # extraOptions = '' ... '';
  };

  # Optional: only add Brew to shells if it exists (safer on first boot)
  environment.shellInit = ''
    if [ -x /opt/homebrew/bin/brew ]; then
      eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
  '';

  environment = {
    shells = [ pkgs.zsh pkgs.bash ];
    systemPackages = [ pkgs.coreutils ];
    # You can drop this if you use the guarded shellInit above:
    # systemPath = [ "/opt/homebrew/bin" ];
    pathsToLink = [ "/Applications" ];
  };

  system = {
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
    };
    defaults = {
      finder.AppleShowAllExtensions = true;
      finder._FXShowPosixPathInTitle = true;
      dock.autohide = true;
      NSGlobalDomain = {
        AppleShowAllExtensions = true;
        InitialKeyRepeat = 14;
        KeyRepeat = 1;
      };
    };
    activationScripts.postUserActivation.text = ''
      /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
    '';
  };

  fonts.packages = [
    pkgs.nerd-fonts.fira-code
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.nerd-fonts._0xproto
  ];

  users.users."${username}" = {
    home = "/Users/${username}";
    shell = pkgs.zsh;
  };

  # Homebrew managed by nix-darwin; Brew itself bootstrapped by nix-homebrew (from your flake)
  homebrew = {
    enable = true;

    # Use this only if you actually keep a Brewfile you want to apply:
    caskArgs.no_quarantine = true;
    taps = [ "fujiapple852/trippy" ];
    brews = [ "trippy" ];
    casks = [ "raycast" "amethyst" ];
    masApps = { };
  };

  # backwards compatibility. Don't change
  system.stateVersion = 4;
}
