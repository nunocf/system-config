{
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
}
