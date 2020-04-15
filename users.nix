{ config, lib, pkgs, ... }:

{
  users.users.starlord = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "libvirtd" ]; # Enable ‘sudo’ for the user.
  };
}
