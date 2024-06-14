{pkgs, ...}: {
  enable = true;
  enableZshIntegration = true;
  # settings = pkgs.lib.importTOML ./zen.toml;
  settings = pkgs.lib.importJSON ./zen.json;
}
