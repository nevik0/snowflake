{ pkgs, ... }:
{
  imports = [
    ./nvf
    ./python.nix
    ./vscode.nix
  ];

  # Nix tooling
  home.packages = with pkgs; [
    deadnix
    nil
    nix-init
    nixpkgs-fmt
    nixfmt-rfc-style
    nurl
    statix
  ];
}