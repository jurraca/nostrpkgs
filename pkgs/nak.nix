{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "nak";
  version = "0.10.0";

  src = fetchFromGitHub {
    owner = "fiatjaf";
    repo = "nak";
    rev = "v" + version;
    sha256 = "sha256-TagKZd0oTFQ6gmfK45Kh9obN+8WD6OLjGZLQNT+ra+4=";
  };

  vendorHash = "sha256-m+8td2SG2Jkxvy5s2Zs/gz0Za+mztyArzvr/twA7OdY=";

  doCheck = false;

  meta = with lib; {
    description = "a command line tool for doing all things nostr";
    homepage = "https://github.com/fiatjaf/nak";
    license = licenses.mit;
  };
}

