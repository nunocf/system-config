{
  enable = true;
  enableCompletion = true;
  autosuggestion.enable = true;
  syntaxHighlighting.enable = true;
  history = {
    expireDuplicatesFirst = true;
    ignoreDups = true;
    ignoreSpace = true; # ignore commands starting with a space
    save = 20000;
    size = 20000;
    share = true;
  };
  shellAliases = {
    ls = "ls --color=auto -F";
    ll = "ls -l";
    nixup = "pushd ~/nixcfg; nix flake update; nixswitch; popd";
    nixswitch = "darwin-rebuild switch --flake ~/nixcfg/.#";
    nri = "cd ~/dev/NoRedInk";
  };
}
