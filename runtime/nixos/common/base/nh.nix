{ 
  inputs, 
  pkgs, 
  username, 
  ... 
}:
{
  programs.nh = {
    enable = true;
    flake = "/home/${username}/snowflake";
    clean = {
      enable = true;
      extraArgs = "--keep-since 10d --keep 3";
    };
    package = inputs.nh.packages.${pkgs.system}.nh;
  };
}