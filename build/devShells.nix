{ 
  pkgs ? import <nixpkgs> { } 
}:

{
  default = pkgs.mkShell {
    name = "nevik-build-flake";
    NIX_CONFIG = "experimental-features = nix-command flakes";
    nativeBuildInputs = with pkgs; [
      git
      nix
      zsh
    ];
    shellHook = ''
      exec zsh
    '';
  };
}