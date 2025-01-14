{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "gitstr";
  version = "0.0.7";

  src = fetchFromGitHub {
    owner = "fiatjaf";
    repo = "gitstr";
    rev = "v" + version;
    sha256 = "sha256-djgyQqNwxtYbAzzQi+BLPrLafptQ/9218VQRwRkeJaA=";
  };

  vendorHash = "sha256-RRt8qnW0lUzuGbyHfbxg7mxDvGwBHjpZMahyguyjfHg=";

  doCheck = false;

  meta = with lib; {
    description = "Send and receive git patches over Nostr, using NIP-34.";
    homepage = "https://github.com/fiatjaf/gitstr";
    license = licenses.mit;
  };
}

