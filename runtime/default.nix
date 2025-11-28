{ inputs, self }:
let 
  inherit (self) lib;
  make = lib.makeConfigs { inherit inputs self; };
  homefile = [
    self.homeModules.default
    self.homeModules.wallpaper
    inputs.niri.homeModules.niri
    inputs.stylix.homeModules.stylix
    inputs.nvf.homeManagerModules.default
    inputs.catppuccin.homeModules.default
    inputs.agenix.homeManagerModules.default
    ./home
  ];
  nixosfile = [
    self.nixosModules.default
    self.nixosModules.wallpaper
    inputs.stylix.nixosModules.stylix
    inputs.agenix.nixosModules.default
    inputs.catppuccin.nixosModules.default
    ./nixos
  ];
in 
make [
  {
    desktop = true;
    hostname = "eira";
    stateVersion = "25.11";
    system = "x86_64-linux";
    theme = ./theme;
    username = "nevik";
    inherit homefile nixosfile;
  }
]