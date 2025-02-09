{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "haven";
  version = "1.0.4";

  src = fetchFromGitHub {
    owner = "bitvora";
    repo = "haven";
    rev = "v" + version;
    sha256 = "sha256-/0j8BP7NQAqKt/1SXcPI565+YCAxuI4Kn/rSDW57oS8=";
  };

  vendorHash = "sha256-YqXzlNIXGg8a9cw4qxGGs4UYs5PnKhXQxlziSIFcDc0=";

  doCheck = false;

  meta = with lib; {
    description = "High Availability Vault for Events on Nostr";
    homepage = "https://github.com/bitvora/haven";
    license = licenses.mit;
  };
}

