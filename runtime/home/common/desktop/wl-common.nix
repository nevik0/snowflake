{ pkgs, ... }:
{
  imports = [
    ./waybar
    ./mako.nix
    ./rofi.nix
  ];

  services = {
    cliphist = {
      enable = true;
      package = pkgs.cliphist;
    };

    wlsunset = {
      enable = true;
      latitude = "33.74";
      longitude = "113.19";
    };
  };

  home.packages = with pkgs; [
    playerctl
    wl-clipboard
    wdisplays
  ];

  home.sessionVariables = {
    _JAVA_AWT_WM_NONREPARENTING = "1";
    CLUTTER_BACKEND = "wayland";
    GDK_BACKEND = "wayland";
    MOZ_ENABLE_WAYLAND = "1";
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    SDL_VIDEODRIVER = "wayland";
    XDG_SESSION_TYPE = "wayland";
    NIXOS_OZONE_WL = "1";
  };
}
