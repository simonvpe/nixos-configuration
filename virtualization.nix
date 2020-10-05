{ config, lib, pkgs, ... }:

{
  virtualisation.docker = {
    enable = true;
    enableNvidia = true;
    enableOnBoot = true;
  };

  virtualisation.libvirtd.enable = true;

  virtualisation.virtualbox.host.enable = true;

  # virtualisation.vmware.guest.enable = true;
}
