{
  pkgs,
  nunocf-nvim,
  username,
  ...
}: {
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
      pkgs.jq
      pkgs.nodejs
      pkgs.yarn
      pkgs.gh
      pkgs.lazygit
      pkgs.fzf

      # replace cd
      pkgs.zoxide

      # themes for kitty
      pkgs.kitty-themes

      # Haskell
      pkgs.haskell-language-server
      # pkgs.ormolu
      # pkgs.ihp-new

      # Elm
      # pkgs.elmPackages.elm-language-server
      # pkgs.elmPackages.elm-format

      # JS
      pkgs.nodePackages.eslint
      pkgs.nodePackages.prettier
      pkgs.prettierd
      pkgs.yamllint

      # my vim flake
      nunocf-nvim.packages."aarch64-darwin".default
    ];

    sessionVariables = {
      PAGER = "less";
      CLICOLOR = 1;
      EDITOR = "nvim";
      TERMINAL = "kitty";
      SHELL = "/etc/profiles/per-user/${username}/bin/zsh";
    };

    file.".inputrc".source = ./dotfiles/inputrc;
    file.".hushlogin".text = "";
  };
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = ["JetBrainsMono Nerd Font"];
    };
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
    zoxide = import ./zoxide;
    oh-my-posh = import ./oh-my-posh pkgs;
    kitty = import ./kitty;
  };
}
