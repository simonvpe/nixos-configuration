{ openfortivpn
, writeScriptBin
, vpnHost ? "193.13.80.146:443"
, vpnUser ? "simonp"
, bwObject ? "18da6c75-397a-4070-ae21-ac4b009365a5"
, nodePackages
}:

writeScriptBin "vpn" ''
  sudo ${openfortivpn}/bin/openfortivpn \
    ${vpnHost} \
    -u ${vpnUser} \
    -p $(${nodePackages.bitwarden-cli}/bin/bw --raw get password ${bwObject}) \
    --trusted-cert fde5cf653d6714ee7816c6cd77f4645697771c48f7e01a3a090e1f13a70b7816
''
