{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    dropbox-cli
    git
    ntfs3g
    vim
    wget
    (pkgs.callPackage ./vpn.nix {})
  ];
}
