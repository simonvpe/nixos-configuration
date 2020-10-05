{ config, lib, pkgs, ... }:

{
  services.xserver = {
    dpi = 100;
    videoDrivers = [ "nvidia" ];
  };

  boot.kernelModules = [ "kvm-amd" ];

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # This is for RCO
  nix.envVars.TMPDIR = "/yocto/tmp";
  # nix.binaryCaches = [ "http://10.4.6.95:8099/" "https://cache.nixos.org/" ];
  # nix.trustedBinaryCaches = [ "http://10.4.6.95:8099/" ];
  # nix.requireSignedBinaryCaches = false;
}
