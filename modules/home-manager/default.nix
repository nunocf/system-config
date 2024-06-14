{
  pkgs,
  nunocf-nvim,
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

      # replace cd
      pkgs.zoxide

      # themes for kitty
      pkgs.kitty-themes

      # Haskell
      pkgs.haskell-language-server
      pkgs.hlint
      pkgs.cabal-install
      pkgs.haskellPackages.cabal-fmt
      pkgs.haskellPackages.implicit-hie
      pkgs.ormolu
      pkgs.ghc

      # Elm
      pkgs.elmPackages.elm-language-server
      pkgs.elmPackages.elm-format

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
    zoxide = import ./zoxide;
    oh-my-posh = import ./oh-my-posh pkgs;

    kitty = {
      enable = true;
      darwinLaunchOptions = ["--start-as=maximized"];
      settings = {
        font_size = "16.0";
        font_family = "FiraCode Nerd Font";
        disable_ligatures = "cursor";
        copy_on_select = "yes";

        enabled_layouts = "tall:bias=30;full_size=1;mirrored=false";
        hide_window_decorations = "titlebar-only";
        window_padding_width = "10";

        tab_title_template = "Tab {index}: {title}";
        active_tab_font_style = "bold";
      };

      theme = "Kanagawa";

      keybindings = {
        "ctrl+shift+enter" = "new_window_with_cwd";
      };
    };
  };
}
