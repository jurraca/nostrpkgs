{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "narr";
  version = "0.3.2";

  src = fetchFromGitHub {
    owner = "fiatjaf";
    repo = "narr";
    rev = "v" + version;
    sha256 = "sha256-MdDM7ULgi/Ow3t0QcYWNSZHO/r09u1OZBUk/7RHuZCg=";
  };

  vendorHash = "sha256-8TaBQM1lwnhVFene3em4AFnS1Riqpu6k1ScxsKCzz1k=";

  tags = [ "sqlite_foreign_keys sqlite_math_functions" ];

  ldflags = [ "-s" "-w" "-X main.Version=${version}" ];

  doCheck = false;

  meta = with lib; {
    description = "self-hosted Nostr and RSS reader";
    homepage = "https://github.com/fiatjaf/narr";
    license = licenses.mit;
  };
}

