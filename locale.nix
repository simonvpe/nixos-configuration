{ config, lib, pkgs, ... }:

{
  console.keyMap = "dvorak";
  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "Europe/Amsterdam";
}
