{ lib, buildGoModule, fetchFromGitHub, fuse2 }:

buildGoModule rec {
  pname = "nak";
  version = "0.20.7";

  src = fetchFromGitHub {
    owner = "fiatjaf";
    repo = "nak";
    rev = "v" + version;
    sha256 = "sha256-4hnzi68K99rQjg3JtRND6TgM24qwD+8wVDNQT4u7eIo=";
  };

  vendorHash = "sha256-nX4kt4HhO8YKqfd6XtNAbAPznHyg5BUZUu4oZh9mabc=";
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

