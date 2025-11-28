{ 
  nixpkgs,
  inputs, 
  systems,
  self,
  ...
}:
let
  eachSystem = function: nixpkgs.lib.genAttrs systems (
    system: function nixpkgs.legacyPackages.${system}
  );
in 
{
  # A basic secondary library.
  lib = import ./lib { inherit inputs; };
  # Custom Overwirte Packages.
  overlays = import ./overlays { inherit inputs; };
  # Custom Packages.
  packages = eachSystem (pkgs: import ./packages { inherit inputs pkgs; });
  # Development environment.
  devShells = eachSystem (pkgs: import ./devShells.nix { inherit inputs pkgs; });
  # Use treefmt as the formatting tool
  formatter = eachSystem (pkgs: inputs.treefmt-nix.lib.mkWrapper pkgs {
      projectRootFile = "flake.nix";
      programs = {
        nixgmt.enable = true;
        ruff-format.enable = true;
        prettier.enable = true;
        beautysh.enable = true;
        toml-sort.enable = true;
      };
      settings.formatter = {
        jsonc = {
          command = "${pkgs.nodePackages.prettier}/bin/prettier";
          includes = ["*.jsonc"];
        };
        scripts = {
          command = "${pkgs.beautysh}/bin/beautysh";
          includes = ["*/scripts/*"];
        };
      };
      settings.global.excludes = ["*.age"];
  });
  # Some custom nixos modules
  nixosModules = {
    default = self.nixosModules.niri;
    niri = import ./modules/nixos/niri.nix;
    wallpaper = import ./modules/wallpaper.nix;
  };
  # Some custom home modules
  homeModules = {
    default = self.homeModules.mon;
    monitors = import ./modules/home/monitors.nix;
    wallpaper = import ./modules/wallpaper.nix;
  };
}