{ desktop, pkgs, ... }:

{
  hardware.bluetooth = {
    enable = true;
    package = pkgs.bluez;
    settings = {
      General = {
        Experimental = true;
        KernelExperimental = true;
      };
    };
    powerOnBoot = true;
  };

  environment.systemPackages = if desktop then [ pkgs.blueberry ] else [ ];
}