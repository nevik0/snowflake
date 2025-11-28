{ inputs }:
final: _prev: {
  inherit (inputs.nixpkgs-wayland.packages.${final.system}) swww;
}