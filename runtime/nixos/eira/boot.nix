{ lib, pkgs, ...}:
{
  boot = {
    loader = {
      grub = {
        device = "nodev";
        default = "saved";
        efiSupport = true;
        useOSProber = false;
        configurationLimit = 2;
        efiInstallAsRemovable = true;
        extraEntriesBeforeNixOS = false;
      };
      systemd-boot.enable = lib.mkForce false;
    };

    initrd = {
      availableKernelModules = [
        "ahci"
        "nvme"
        "sd_mod"
        "usb_storage"
        "usbhid"
        "xhci_pci"
      ];
    };

    kernelModules = [
      "kvm_intel"
    ]; 
    
    bootspec.enable = true;
  };
  systemd.settings.Manager = { DefaultTimeoutStopSec = "10s"; };

  catppuccin.grub.enable = true;
  stylix.targets.grub.enable = false;
}