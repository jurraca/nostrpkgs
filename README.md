# Nostrpkgs

A collection of [Nostr](https://github.com/nostr-protocol/nostr) tools to be used with the [Nix](https://github.com/NixOS/nix/) package manager.

## Goals

Be the easiest, fastest, and free-est way to use Nostr tools.

## Big goals

- Modules for relays: provide canonical module implementations so that users can just pull in a relay to their NixOS config, declare its settings, and throw it in the cloud.
- Play nice with [nix-bitcoin](https://github.com/fort-nix/nix-bitcoin/): should just work by adding to, or combining with, a nix-bitcoin config. Think how alby-hub can use a LN node, or NWC.
- A Cache for binaries: provide a cache for users to leverage prebuilt binaries of theses tools, a la cache.nixos.org.
- An auto-update bot, like [nixpkgs-update](https://github.com/nix-community/nixpkgs-update).
- A terminal UI for searching packages or configuring modules (module configs are forms, basically).

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

Some pointers/warnings:
- This is for tools, not libraries.
- It's intended primarily for CLI and desktop, not mobile, but that may change!
- Aim to package projects that are actively maintained.
- Some languages are far easier to package than others: Go, Rust, Elixir.
- Think about the future generations and avoid JavaScript if you can help it.
- Python remains the gnarliest language to package with Nix.
