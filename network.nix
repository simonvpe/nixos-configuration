{ config, lib, pkgs, ... }:

{
  networking.firewall = {
    allowedTCPPorts = [
      17500 # dropbox
    ];
    allowedUDPPorts = [
      17500 # dropbox
    ];
  };
}
