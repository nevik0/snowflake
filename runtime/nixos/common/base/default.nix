{
  hostname,
  lib,
  pkgs,
  username,
  ...
}:

{
  imports = [
    ./boot.nix
    ./console.nix
    ./hardware.nix
    ./locale.nix
    ./nh.nix
    ./users-rules.nix
  ] ++ [
    ../services/doas.nix
    ../services/avahi.nix
    ../services/firewall.nix
    ../services/openssh.nix
    ../services/tailscale.nix
  ];

  networking = {
    hostName = hostname;
    useDHCP = lib.mkDefault true;
  };

  environment = {
    pathsToLink = [ "/share/zsh" ];
    systemPackages = import ./packages.nix {inherit pkgs;};
  };
  programs = {
    zsh.enable = true;
    nix-ld.enable = true;
  };
  
  security = {
    rtkit.enable = true;
    polkit.enable = true;
  };

  systemd.tmpfiles.rules = [ "d /nix/var/nix/profiles/per-user/${username} 0755 ${username} root" ];
}