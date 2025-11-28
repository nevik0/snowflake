{
  desktop,
  hostname,
  modulesPath,
  nevik,
  self,
  stateVersion,
  username,
  ...
}:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (./. + "/${hostname}/boot.nix")
    (./. + "/${hostname}/hardware.nix")

    ./common/base
    ./common/users/${username}
  ] 
  ++ nevik.invoke' ./${hostname}/extra.nix
  # Include desktop config if a desktop is defined
  ++ nevik.invoke desktop ./common/desktop;

  nixpkgs = {
    config.allowUnfree = true;
    config.joypixels.acceptLicense = true;
    # Add overlays your own flake exports;
    overlays = builtins.attrValues self.overlays;
  };

  system = {
    inherit stateVersion;
  };
}