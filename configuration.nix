# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./base-configuration.nix
      ./software.nix
      ./network.nix
      ./boot.nix
      ./services.nix
      ./virtualization.nix
      ./users.nix
      ./fonts.nix
      ./locale.nix
    ];

  nixpkgs.config.allowUnfree = true;
  environment.variables.XCURSOR_SIZE = "64";

  environment.pathsToLink = [ "/libexec" ];

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.03"; # Did you read the comment?
}
