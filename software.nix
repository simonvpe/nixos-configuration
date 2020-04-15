{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    dropbox-cli
    git
    vim
    wget
  ];
}
