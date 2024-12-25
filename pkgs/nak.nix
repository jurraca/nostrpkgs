{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "nak";
  version = "0.7.3"; # You can set the appropriate version

  src = fetchFromGitHub {
    owner = "fiatjaf"; # Replace with the actual GitHub username
    repo = "nak";
    rev = "v" + version; # The specific version or commit to fetch
    sha256 = "sha256-1DL3U7x1QFDBWdt4pvB1ZVmlNdaTwZYdr5DGUFwFudk=";
  };

  vendorHash = "sha256-F969elzg1t9vPpQUszYMMU6nE6mD3wkyI/RWBo6fGcY=";

  doCheck = false;

  meta = with lib; {
    description = "a command line tool for doing all things nostr";
    homepage = "https://github.com/fiatjaf/nak";
    license = licenses.mit;
    maintainers = with maintainers; [ jurraca ];
  };
}

