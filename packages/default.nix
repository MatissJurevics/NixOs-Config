{ stdenv, lib, fetchurl }:

stdenv.mkDerivation rec {
  pname = "nord-vpn";
  version = "3.10.0";

  src = fetchurl {
    url = "https://repo.nordvpn.com/deb/nordvpn/debian/pool/main/nordvpn_3.10.0-1_amd64.deb";
    sha256 = "0qqbfzk0428a97h5n1i9m2gzmwrbx1fj62pmqllwchk56ag0il04";
  };

  meta = with lib; {
    homepage = "https://nordvpn.com/";
    description = "Client for Nord VPN";
    platforms = [ "x86_64-linux" ];
  };
}

