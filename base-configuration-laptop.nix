{ config, lib, pkgs, ... }:

{
  hardware.bumblebee.enable = true;

  services = {
    xserver = {
      dpi = 180;
      libinput.enable = true;
    };
    upower.enable = true;
  };

  networking.wireless = {
    # Enables wireless support via wpa_supplicant.
    enable = true;
    networks = {
      AirLink2277b0 = {
        psk = "riNMmF3W";
      };
      Headquarters-5G = {
        psk = "allyourbaseare";
      };
      Strandhyddan = {
        psk = "8972524000";
      };
      OnePlus3 = {
        psk = "pappapappa";
      };
      "free.wifi" = {};
    };
  };

  services.xserver.dpi = 180;
}
