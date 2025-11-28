{ inputs, self, ... }:
{
  imports = [    
    inputs.disko.nixosModules.disko
    inputs.nixGL.nixosModules.default
    inputs.nixos-hardware.nixosModules.common-cpu-intel
    inputs.nixos-hardware.nixosModules.common-hidpi
    inputs.nixos-hardware.nixosModules.common-pc
    inputs.nixos-hardware.nixosModules.common-pc-ssd

    ./disks.nix
    ../common/hardware/bluetooth.nix
  ];

  nixGL = {
    vulkan.enable = true;
    defaultWrapper = "mesa";
    installScripts = [ "mesa" ];
  };

  nixpkgs.hostPlatform = "x86_64-linux";
}
