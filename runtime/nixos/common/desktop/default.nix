{
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./niri.nix
    ./sddm.nix
    ../services/pipewire.nix
  ];

  boot.plymouth.enable = true;
  boot.kernelParams = [
    "quiet"
    "loglevel=3"
    "rd.udev.log_priority=3"
    "vt.global_cursor_default=0"
  ];

  location.provider = "geoclue2";
  hardware.graphics.enable = true;
  
  fonts = {
    packages = with pkgs; [
      meslo-fonts
      ubuntu_font_family
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      nerd-fonts.symbols-only
      nerd-fonts.hurmit
      nerd-fonts.monofur
      inter
      joypixels
      liberation_ttf
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [
          "${config.stylix.fonts.serif.name}"
          "${config.stylix.fonts.emoji.name}"
        ];
        sansSerif = [
          "${config.stylix.fonts.serif.name}"
          "${config.stylix.fonts.emoji.name}"
        ];
        monospace = [ "${config.stylix.fonts.monospace.name}" ];
        emoji = [ "${config.stylix.fonts.emoji.name}" ];
      };
    };
    enableDefaultPackages = false;
  };
}