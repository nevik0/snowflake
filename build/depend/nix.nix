{ 
  config, 
  inputs, 
  lib, 
  username, 
  ... 
}:
{
  nix = {
    settings = {
      experimental-features = [
        "flakes"
        "nix-command"
        "pipe-operators"
      ];
      substituters = [
        "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
        "https://mirrors.ustc.edu.cn/nix-channels/store"
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
        "https://hyprland.cachix.org"
        "https://niri.cachix.org"
        "https://nixpkgs-wayland.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
        "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
      ];
      keep-outputs = true;
      trusted-users = [ "${username}" "root" ];
      keep-derivations = true;
      auto-optimise-store = true;
      channel.enable = true;
      download-buffer-size = 262144000; # 250 MB (250 * 1024 * 1024)
    };
    optimise.automatic = true;
    # This will add each flake input as a registry
    # To make nix3 commands consistent with your flake
    registry = lib.mkForce (lib.mapAttrs (_: value: { flake = value; }) inputs);
    # This will additionally add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    nixPath = lib.mkForce (lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry);
  };

}