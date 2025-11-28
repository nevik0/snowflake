{pkgs, ...}: {
  services.mako = {
    enable = true;
    settings = {
      border-size = 4;
      border-radius = 8;
    };
  };
  catppuccin.mako.enable = true;
  stylix.targets.mako.enable = false;
  home.packages = [pkgs.libnotify];
}
