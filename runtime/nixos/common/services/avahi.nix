{ desktop, ... }:
{
  services = {
    avahi = {
      enable = true;
      openFirewall = true;
      nssmdns4 = true;
      publish = {
        enable = true;
        addresses = true;
        workstation = if desktop then true else false;
      };
    };
  };
}
