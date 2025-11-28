{ pkgs, ... }:
{
  programs.waybar = {
    enable = true;
    package = pkgs.stable.waybar;
    systemd = {
      enable = true;
      target = config.wayland.systemd.target;
    };
  };
  imports = [./settings.nix ./style.nix];
}