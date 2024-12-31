{
  pkgs,
  username,
  ...
}: {
  # here go the darwin preferences and configuration items
  programs.zsh.enable = true;

  environment = {
    shells = [pkgs.zsh pkgs.bash];
    systemPackages = [pkgs.coreutils];
    systemPath = ["/opt/homebrew/bin"];
    pathsToLink = ["/Applications"];
  };

  nix.extraOptions = ''
    experimental-features = nix-command flakes
    keep-outputs = true
  '';
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
      # Following line should allow us to avoid a logout/login cycle
      /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
    '';
  };
  fonts = {
    packages = [
      pkgs.nerd-fonts.fira-code
      pkgs.nerd-fonts.jetbrains-mono
      pkgs.nerd-fonts._0xProto
    ];
  };

  services.nix-daemon.enable = true;

  users.users."${username}" = {
    home = "/Users/${username}";
    shell = pkgs.zsh;
  };

  # backwards compatibility. Don't change
  system.stateVersion = 4;
  homebrew = {
    enable = true;
    caskArgs.no_quarantine = true;
    global.brewfile = true;
    masApps = {};
    casks = ["raycast" "amethyst"];
    taps = ["fujiapple852/trippy"];
    brews = ["trippy"];
  };
}
