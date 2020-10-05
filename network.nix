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

  networking.extraHosts = ''
    10.4.6.16 rco-sto-utv01
  '';
}
