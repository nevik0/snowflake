{ config, lib, pkgs, ... }:

{ 
  imports = [ ./wallpaper.nix ];
  
  stylix = {
    enable = true;
    cursor = {
      name = "phinger-cursors-light";
      package = pkgs.phinger-cursors;
      size = 20;
    };
    iconTheme = {
      enable = true;
      package = pkgs.papirus-icon-theme;
      dark = "Papirus-Dark";
    };
    polarity = "dark";
    base16Scheme = ./base16/catppuccin-mocha.yaml;
    fonts = {
      monospace = {
        name = "MesloLGSDZ Nerd Font Mono";
        package = pkgs.meslo-fonts;
      };
      sansSerif = {
        name = "Inter";
        package = pkgs.inter;
      };
      emoji = {
        name = "Joypixels";
        package = pkgs.joypixels;
      };
      sizes = {
        applications = 13;
        desktop = 13;
        popups = 13;
        terminal = 13;
      };
      serif = config.stylix.fonts.sansSerif;
    };
  };

  catppuccin = {
    flavor = "mocha";
    accent = "mauve";
  };
}