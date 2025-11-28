{ hostname, lib,  ... }:
let
  
  syncthing = {
    hosts = [ ];
    tcpPorts = [ ];
    udpPorts = [ ];
  };
in
{
  networking = {
    firewall = {
      enable = true;
      allowedTCPPorts = lib.optionals (builtins.elem hostname syncthing.hosts) syncthing.tcpPorts;
      allowedUDPPorts = lib.optionals (builtins.elem hostname syncthing.hosts) syncthing.udpPorts;
    };
  };
}
