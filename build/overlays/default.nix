{ inputs }:

{
  # Add additional Packages
  additions = import ./additions.nix { inherit inputs; };
  # Add Modified Packages
  modifications = import ./modifications.nix { inherit inputs; };
  # Add additional nixpkgs source
  nixpkgs-source = import ./nixpkgs-source.nix { inherit inputs;};
  # Add override packages.
  override = import ./override.nix;
  # Add external packages.
  inherit (inputs.niri.overlays) niri;
}