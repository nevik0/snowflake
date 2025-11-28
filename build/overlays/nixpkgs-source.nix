{ inputs }:
final: _prev: {
  nur = import inputs.nixpkgs-nur {
    pkgs = final;
  };
  
  master = import inputs.nixpkgs-master {
    inherit (final) system;
    overlays = [ ];
    config.allowUnfree = true;
    config.allowUnsupportedSystem = true;
  };
  
  stable = import inputs.nixpkgs-stable {
    inherit (final) system;
    overlays = [ ];
    config.allowUnfree = true;
    config.allowUnsupportedSystem = true;
  };
}
