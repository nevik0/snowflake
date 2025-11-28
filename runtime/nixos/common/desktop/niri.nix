{ pkgs, ... }:

{
  programs = {
    niri = {
      enable = true;
      package = pkgs.niri-unstable;
    };

    dconf.enable = true;
    file-roller.enable = true;
  };

  environment = {
    variables = {
      NIXOS_OZNNE_WL = "1";
      GTK_USE_PORTAL = "1";
      GDK_DEBUG = "portals";
    };

    systemPackages = with pkgs; [
      nautilus
      zenity
      libheif
      libheif.out
      polkit
      polkit_gnome
    ];

    pathsToLink = [ "/share/thumbnailers" "/share/xdg-desktop-portal" "/share/applications" ];
  };

  services = {
    dbus = {
      enable = true;
      implementation = "broker";
      packages = with pkgs; [ gcr ];
    };

    libinput.enable = true;

    gnome = {
      sushi.enable = true;
    };

    gvfs.enable = true;
  };
}