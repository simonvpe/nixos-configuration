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
  boot.loader.grub.extraEntries = ''
    menuentry 'Windows 10' --class windows --class os $menuentry_id_option 'osprober-chain-4CBE4D19BE4CFD48' {
      insmod part_msdos
      insmod ntfs
      set root='hd0,msdos1'
      if [ x$feature_platform_search_hint = xy ]; then
        search --no-floppy --fs-uuid --set=root --hint-bios=hd0,msdos1 --hint-efi=hd0,msdos1 --hint-baremetal=ahci2,msdos1 4CBE4D19BE4CFD48
      else
        search --no-floppy --fs-uuid --set=root 4CBE4D19BE4CFD48
      fi
      parttool ''${root} hidden-
      chainloader +1
    }
  '';
}
