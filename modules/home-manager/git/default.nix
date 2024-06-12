{
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
}
