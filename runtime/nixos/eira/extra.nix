{ self, ... }:

{
  inports = [
    ../common/services/networkmanager.nix
  ];

  programs.firefox.enable = true; 
}