{ config, lib, pkgs, ... }:

{
  users.users.starlord = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "libvirtd" "dialout" ]; # Enable ‘sudo’ for the user.
  };

  nix.trustedUsers = [ "starlord" ];
}
