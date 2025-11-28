{ inputs }:
let
  # Self-referential extension function.
  makeExtensible' =
    rattrs:
    let
      self = rattrs self // {
        extend = function: nevik.nixpkgs.makeExtensible (nevik.nixpkgs.extends function rattrs);
      };
    in
    self;
  # Library Definition.
  nevik = makeExtensible' (
    nevik': 
    let 
      invokeLib = name: 
        if builtins.isPath name 
        then import name { nevik = nevik'; } 
        else inputs.${name}.lib;
    in
    {
      # External library.
      nixpkgs = invokeLib "nixpkgs";
      home-manager = invokeLib "home-manager";

      # Auxiliary library.
      assists = invokeLib ./assists.nix;
      makes = invokeLib ./makes.nix;

      # Extract partial functions to secondary fields
      inherit (nevik'.makes) 
        makeConfigs
        ;
      inherit (nevik'.assists)
        invoke
        invoke'
        mkGLColor
        mkSwhkdrc
        ;
    }
  );
in 
nevik