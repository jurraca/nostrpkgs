{ lib, buildGoModule, fetchFromGitHub, fuse2 }:

buildGoModule rec {
  pname = "nak";
  version = "0.20.1";

  src = fetchFromGitHub {
    owner = "fiatjaf";
    repo = "nak";
    rev = "v" + version;
    sha256 = "sha256-QP2r+Eq0O9cRyF3NLT6s8L1CZqfiRdJ2O+nDfvrO5iI=";
  };

  vendorHash = "sha256-uftDwPMu2pK5wEfMrO6HSRFcvcr+Cst3uQ8cpOMESs4=";
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

