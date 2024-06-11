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

    git = {
      enable = true;
      userName = "Nuno Ferreira";
      userEmail = "nunogcferreira@gmail.com";

      lfs = {enable = true;};

      aliases = {
        aa = "add --all";
        ap = "add --patch";
        amend = "commit --amend";
        ci = "commit";
        co = "checkout";
        dc = "diff --cached";
        di = "diff";
        glog = "log --oneline";
        publish = "push -u origin HEAD";
        root = "rev-parse --show-toplevel";
        st = "status";
        yoda = "push --force-with-lease";
      };
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      shellAliases = {
        ls = "ls --color=auto -F";
        ll = "ls -l";
        nixup = "pushd ~/.config2; nix flake update; nixswitch; popd";
        nixswitch = "darwin-rebuild switch --flake ~/.config2/.#";
        nri = "cd ~/dev/NoRedInk";
      };
    };

    starship = {
      enable = true;
      enableZshIntegration = true;
    };

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
