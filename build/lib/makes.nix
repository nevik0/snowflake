{ nevik }:

rec {
  inherit (nevik.nixpkgs) nixosSystem;
  inherit (nevik.home-manager) homeManagerConfiguration;
  
  makeConfigs = { inputs, self }: entries: let
    NIX_CONFIG = [ ../depend/nix.nix ];
    checked = if builtins.isList entries then entries else [ entries ]; 
    mkHost = {
      desktop ? false,
      hostname ? "neve-build",
      nixosfile ? "/etc/nixos/configuration.nix",
      stateVersion ? "25.11",
      theme ? null,
      username ? "nevik",
      ...
    }:
    nixosSystem {
      specialArgs = {
        inherit self inputs;
        inherit desktop hostname stateVersion username;
        nevik = import ./default.nix { inherit inputs; };
      };
      modules = (if builtins.isList nixosfile then nixosfile else [ nixosfile ])
      ++ (if builtins.isPath theme then [ theme ] else [ ]) ++ NIX_CONFIG;
    };

    mkHome = {
      desktop ? false,
      hostname ? "neve-build",
      homefile ? "/etc/nixos/home.nix",
      stateVersion ? "25.11",
      system ? "x86_64-linux",
      theme ? null,
      username ? "nevik",
      ...
    }:
    homeManagerConfiguration {
      pkgs = nixpks.legacyPackages.${system};
      extraSpecialArgs = {
        inherit self inputs;
        inherit desktop hostname stateVersion username;
        nevik = import ./default.nix { inherit inputs; };
      };
      modules = (if builtins.isList homefile then homefile else [ homefile ]) 
      ++ (if builtins.isPath theme then [ theme ] else [ ]) ++ NIX_CONFIG;
    };  
  in 
  {
    nixosConfigurations = builtins.listToAttrs (
      map (entry: {
        name = "${entry.hostname}";
        value = mkHost entry;
      }) checked
    );
    homeConfigurations = builtins.listToAttrs (
      map (entry: {
        name = "${entry.username}@${hostname}";
        value = mkHome entry;
      }) checked
    );
  };
}