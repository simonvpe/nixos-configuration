{ config, lib, pkgs, ... }:

{
  services.xserver = {
    layout = "dvorak";
    xkbVariant = "pc102";
    xkbOptions = "caps:swapescape lv3:ralt_switch";
  };
}
