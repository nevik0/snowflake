{ 
  lib,
  pkgs,
  ...
}:
{
  users = {
    defaultUserHome = "/home";
    defaultUserShell = pkgs.zsh;
    allowNoPasswordLogin = true;
    mutableUsers = lib.mkDefault true;
  };
}