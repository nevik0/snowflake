# from https://github.com/sodiboo/niri-flake
{
  config,
  lib,
  options,
  pkgs,
  ...
}:
let
  cfg = config.programs.niri;
in
{
  disabledModules = [ "programs/wayland/niri.nix" ];

  options.programs.niri = {
    enable = lib.mkEnableOption "niri";
    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.niri;
      description = "The niri package to use.";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.xdg-utils
      cfg.package
    ];

    xdg = {
      autostart.enable = lib.mkDefault true;
      menus.enable = lib.mkDefault true;
      mime.enable = lib.mkDefault true;
      icons.enable = lib.mkDefault true;
    };

    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;
      config = {
        niri = {
          default = [
            "gtk"
            "gnome"
          ];
          "org.freedesktop.impl.portal.FileChooser" = "gtk";
          "org.freedesktop.impl.portal.ScreenCast" = "gnome";
          "org.freedesktop.impl.portal.Screenshot" = "gnome";
        };
        common.default = ["gtk" "gnome"];
      };
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-gnome
      ];
      configPackages = [ cfg.package ];
    };

    systemd.user.services.polkit-gnome-authentication-agent-1 = {
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
      description = "polkit-gnome-authentication-agent-1";
    };
    
    security.polkit.enable = true;
    services.gnome.gnome-keyring.enable = true;
    services.displayManager.sessionPackages = [ cfg.package ];
    hardware.graphics.enable = lib.mkDefault true;
  };
}