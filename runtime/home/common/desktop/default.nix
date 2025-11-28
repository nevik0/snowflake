{ pkgs, ... }:
{
  imports = [
    ../dev
    ./niri
    ./swhkd.nix
    ./kitty.nix
    ./wl-common.nix
    ./file-associations.nix
  ];

  programs = {
    firefox.enable = true;
    mpv.enable = true;
  };

  home.packages = with pkgs; [
    catppuccin-gtk
    desktop-file-utils
    ght
    google-chrome
    libnotify
    loupe
    papers
    pwvucontrol
    thunderbird-latest
    xdg-utils
  ];

  fonts.fontconfig.enable = true;
}
