{
  pkgs,
  nunocf-nvim,
  ...
}: let
  gitConfig = import ./git/default.nix;
  zshConfig = import ./zsh/default.nix;
in {
  # Don't change this when you change package input. Leave it alone.
  home = {
    stateVersion = "24.05";

    # specify my home-manager configs
    packages = [
      # base programs
      pkgs.ripgrep
      pkgs.fd
      pkgs.curl
      pkgs.less
      pkgs.kitty-themes
      pkgs.jq
      pkgs.nodejs
      pkgs.yarn

      # Language servers
      # pkgs.haskellPackages.haskell-language-server
      # pkgs.haskellPackages.hlint

      # my vim flake
      nunocf-nvim.packages."aarch64-darwin".default
    ];

    sessionVariables = {
      PAGER = "less";
      CLICOLOR = 1;
      EDITOR = "nvim";
      TERMINAL = "kitty";
      PATH = "$HOME/.ghcup/bin:$PATH";
    };

    file.".inputrc".source = ./dotfiles/inputrc;
  };

  programs = {
    bat = {
      enable = true;
      config.theme = "TwoDark";
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    eza.enable = true;

    git = import ./git;

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    zsh = import ./zsh;

    starship = import ./starship pkgs;

    kitty = {
      enable = true;
      settings = {
        font_size = "16.0";
        font_family = "FiraCode Nerd Font";
        disable_ligatures = "cursor";
        copy_on_select = "yes";
      };

      theme = "kanagawabones";

      keybindings = {
        "ctrl+shift+h" = "goto_layout horizontal";
      };
    };
  };
}
