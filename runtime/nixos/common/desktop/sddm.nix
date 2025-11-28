{
  config,
  pkgs,
  ...
}: 
let
  catppuccin-sddm = pkgs.catppuccin-sddm.override {
    flavor = "mocha";
    accent = "mauve";
    font  = "Inter";
    fontSize = "10";
    background = "${toString config.wallpaper.normal}";
    loginBackground = true;
    userIcon = true;
  };
in 
{
  services.displayManager.sddm = {
    package = pkgs.kdePackages.sddm;
    extraPackages = [ catppuccin-sddm ];
    enable = true;
    wayland.enable = true;
    theme = "catppuccin-mocha-mauve";
    settings = {
      Wayland.SessionDir = "${pkgs.niri-unstable}/share/wayland-sessions";
    };
  };

  environment.systemPackages = [ catppuccin-sddm ];
}