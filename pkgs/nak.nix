{ lib, buildGoModule, fetchFromGitHub, fuse2 }:

buildGoModule rec {
  pname = "nak";
  version = "0.19.10";

  src = fetchFromGitHub {
    owner = "fiatjaf";
    repo = "nak";
    rev = "v" + version;
    sha256 = "sha256-7j9O8SAig3OMdvtVsxP9Ar1CjUWOhFovKo63S5IbNf8=";
  };

  vendorHash = "sha256-Eeg49ida69AUY5viTHHNgiL8wTXtXRG3kTMiCrU6zCY=";
  buildInputs = [ fuse2 ];
  env = {
    CGO_LDFLAGS = "-L${lib.getLib fuse2}/lib -lfuse";
    CGO_CFLAGS = "-I${lib.getDev fuse2}/include";
  };

  doCheck = false;

  meta = with lib; {
    description = "a command line tool for doing all things nostr";
    homepage = "https://github.com/fiatjaf/nak";
    license = licenses.mit;
  };
}

