{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    nodePackages.bitwarden-cli
    dropbox-cli
    git
    ntfs3g
    vim
    wget
    (pkgs.callPackage ./vpn.nix {})
  ];
}
