{ 
  desktop, 
  username,
  hostname,
  nevik,
  self,
  stateVersion,
  ... 
}:
let
  inherit (self.nixosConfigurations."${hostname}") config;
in 
{
  # Only import desktop configuration if the host is desktop enabled
  # Only import user specific configuration if they have bespoke settings
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    ./shell
  ] 
  ++ nevik.invoke desktop ./common/desktop
  ++ nevik.invoke' ./${username};

  home = {
    inherit username stateVersion;
    homeDirectory = "${config.users.users.${username}.home}";
  };

  nixpkgs = {
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
      permittedInsecurePackages = [ "electron-25.9.0" ];
    };
    # Add overlays your own flake exports (from overlays and pkgs dir):
    overlays = builtins.attrValues self.overlays;
  };  
}