{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "nak";
  version = "0.11.4";

  src = fetchFromGitHub {
    owner = "fiatjaf";
    repo = "nak";
    rev = "v" + version;
    sha256 = "sha256-xFATXMK7wyEgnJXmTq9BdW27xqgXUP1Mo0m5QhFIv0I=";
  };

  vendorHash = "sha256-VkeQLWtyDfZiR0nrhmd5KCi/BIuqrFem9WhcTd3VRcc=";

  doCheck = false;

  meta = with lib; {
    description = "a command line tool for doing all things nostr";
    homepage = "https://github.com/fiatjaf/nak";
    license = licenses.mit;
  };
}

