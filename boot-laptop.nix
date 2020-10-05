{ config, lib, pkgs, ... }:

{
  boot.supportedFilesystems = [ "ntfs" ];
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.configurationLimit = 2;
  boot.loader.grub.efiInstallAsRemovable = true;
}
