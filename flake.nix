{
  description = "nunocf's flake";

  inputs = {
    # Where we get most of our software. Giant mono repo with recipes 
    # called derivations that say how to build certain software.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Manages configs, links things to home directory
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Controls system level software and settings including fonts
    darwin = {
      url = "github:/lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = inputs: {
    darwinConfigurations.Nunos-MBP =
      inputs.darwin.lib.darwinSystem {

        system = "aarch64-darwin";

        pkgs = import inputs.nixpkgs { system = "aarch64-darwin"; };

        modules = [
          ({ pkgs, ... }: {
            # here go the darwin preferences and configuration items
            programs.zsh.enable = true;
            environment.shells = [ pkgs.bash pkgs.zsh ];
            environment.loginShell = pkgs.zsh;
            environment.systemPackages = [ pkgs.coreutils ];
            nix.extraOptions = ''
              experimental-features = nix-command flakes
            '';
            system.keyboard.enableKeyMapping = true;
            system.keyboard.remapCapsLockToEscape = true;
            fonts.fontDir.enable = true;
            fonts.fonts = [ (pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; }) ];
            services.nix-daemon.enable = true;

            system.defaults.finder.AppleShowAllExtensions = true;
            system.defaults.finder._FXShowPosixPathInTitle = true;
            system.defaults.dock.autohide = true;
            system.defaults.NSGlobalDomain.AppleShowAllExtensions = true;
            system.defaults.NSGlobalDomain.InitialKeyRepeat = 14;
            system.defaults.NSGlobalDomain.KeyRepeat = 1;

            # backwards compatibility. Don't change
            system.stateVersion = 4;
          })

          inputs.home-manager.darwinModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.nunocf.imports = [
                ({ pkgs, ... }: {

                  # Don't change this when you change package input. Leave it alone.
                  home.stateVersion = "24.05";

                  # specify my home-manager configs
                  home.packages = [
                    pkgs.ripgrep
                    pkgs.fd
                    pkgs.curl
                    pkgs.less
                  ];

                  home.sessionVariables = {
                    PAGER = "less";
                    CLICOLOR = 1;
                    EDITOR = "nvim";
                    TERMINAL = "kitty";
                    PATH = "$HOME/.ghcup/bin:$PATH";
                  };

                  programs.bat.enable = true;
                  programs.bat.config.theme = "TwoDark";

                  programs.fzf.enable = true;
                  programs.fzf.enableZshIntegration = true;

                  programs.exa.enable = true;

                  programs.git = { 
                    enable = true;
                    userName  = "Nuno Ferreira";
                    userEmail = "nunogcferreira@gmail.com";

                    lfs = { enable = true; };

                    aliases = {
                      aa = "add --all";
                      ap = "add --patch";
                      amend = "commit --amend";
                      ci = "commit";
                      co = "checkout";
                      dc = "diff --cached";
                      di = "diff";
                      publish = "push -u origin HEAD";
                      root = "rev-parse --show-toplevel";
                      st = "status";
                      yoda = "push --force-with-lease";
                    }; 
                  };

                  programs.direnv.enable = true;
                  programs.direnv.nix-direnv.enable = true;

                  programs.zsh = {
                    enable = true;
                    enableCompletion = true;
                    enableAutosuggestions = true;
                    enableSyntaxHighlighting = true;
                    shellAliases = {
                      ls = "ls --color=auto -F";
                      ll = "ls -l";
                      update = "home-manager switch --impure";
                      edit = "home-manager edit";
                      nri = "cd ~/dev/NoRedInk";
                    };
                  };

                  programs.starship.enable = true;
                  programs.starship.enableZshIntegration = true;

                  programs.kitty = {
                    enable = true;
                    settings = {
                      font_size = "16.0";
                      font_family = "FiraCode Nerd Font";
                      disable_ligatures = "cursor";
                      copy_on_select = "yes";
                    };

                    theme = "Nord";

                    keybindings = {
                      "ctrl+shift+h" = "goto_layout horizontal";
                    };
                  };
                })
              ];
            };
          }
        ];
      };
  };
}
