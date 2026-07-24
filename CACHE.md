## Nostrpkgs binary cache

URL: `https://nostrpkgs.cachix.org`
Public Key: `nostrpkgs.cachix.org-1:ORjugy6T0QRYc9/yGMiV+PIako4Sl1HeW2BHIcqFJgg=`

If you have `cachix` locally, just run `cachix use nostrpkgs`. It will populate you `nix.conf` settings for you.

If not, edit the settings manually:
- your `nix.conf` file (usually at `~/.config/nix/nix.conf`) should contain the default nixos cache `cache.nixos.org` and its corresponding public key. Add the nostrpkgs URL under the `substituters` key and its public key under `trusted-public-keys`, as below:
```
substituters = https://cache.nixos.org/ https://nostrpkgs.cachix.org
trusted-public-keys = cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY= nostrpkgs.cachix.org-1:ORjugy6T0QRYc9/yGMiV+PIako4Sl1HeW2BHIcqFJgg=
```
- restart the nix daemon to use the cache: `sudo systemctl restart nix-daemon`. If you're using nixOS, you may also need to do a `nixos-rebuild switch` on your machine.


