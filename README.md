# Nostrpkgs

A collection of [Nostr](https://github.com/nostr-protocol/nostr) tools to be installed with the [Nix](https://github.com/NixOS/nix/) package manager.

## Usage

You can think of this repository as a collection which contains build recipes for packages. It aims to provide these recipes for all major architectures, irrespective of a project's programming language or build system.

For example, if you want to build `nak` on your local machine, you could do:
```
nix build github:jurraca/nostrpkgs#nak
```
Nix can resolve the GitHub URL, find this repo, and find the `nak` package within the `flake.nix` by addressing it with a `#`. This will create a build in your current directory under `result/bin/nak`.

You could also just run it without creating a userspace reference to the build with `nix run`:
```
nix run github:jurraca/nostrpkgs#nak --help
```
You can pass arguments to it like you usually would, in this case print the help text.

## Contributing

Please contribute packages via PRs or request packages you would like to see included via Issues.

When contributing, please follow Nixpkgs [commit conventions](https://github.com/NixOS/nixpkgs/blob/master/CONTRIBUTING.md#commit-conventions).

