{
  desktop,
  lib,
  pkgs,
  ...
}:
{
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    jack.enable = true;
    pulse.enable = true;
    alsa.support32Bit = true;
    wireplumber.enable = true;
  };

  services.pulseaudio.enable = lib.mkForce false;

  environment.systemPackages = if desktop then [ pkgs.pwvucontrol ] else [ ];
}
