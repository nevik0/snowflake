{ pkgs, ... }:

{
  imports = [
    ./yazi
    ./atuin.nix
    ./bat.nix
    ./bottom.nix
    ./eza.nix
    ./fastfetch.nix
    ./fzf.nix
    ./git.nix
    ./lazygit.nix
    ./pay-respects.nix
    ./starship.nix
    ./xdg.nix
    ./zoxide.nix
    ./zsh.nix
  ];

  programs = {
    gpg.enable = true;
    home-manager.enable = true;
    jq.enable = true;
  };

  services.gpg-agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-curses;
  };

  home.packages = with pkgs; [
    age 
    sops
  ];
}