{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "nak";
  version = "0.12.0";

  src = fetchFromGitHub {
    owner = "fiatjaf";
    repo = "nak";
    rev = "v" + version;
    sha256 = "sha256-oF+ayWBXmHSDPHsFcOONTqQ/fhdJuVP1X1uWZldy7wA=";
  };

  vendorHash = "sha256-j7UwG00KrK8WatYeC8BV7iovN/N9a+MLL8dEebHewUk=";

  doCheck = false;

  meta = with lib; {
    description = "a command line tool for doing all things nostr";
    homepage = "https://github.com/fiatjaf/nak";
    license = licenses.mit;
  };
}

