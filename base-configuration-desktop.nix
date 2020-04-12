{ config, lib, pkgs, ... }:

{
  services.xserver = {
    dpi = 100;
    videoDrivers = [ "nvidia" ];
  };
}
