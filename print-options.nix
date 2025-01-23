{
  pkgs,
  packages,
  ...
}: let
  finalOpts = {
    default = null;
    description = null;
    example = null;
    name = null;
    type = null;
  };
  getOpts = optionAttrs:
    builtins.intersectAttrs finalOpts (
      optionAttrs // {type = getType optionAttrs;}
    );

  getType = set:
    if builtins.hasAttr "type" set
    then set.type.description
    else null;

  buildFinalOpts = optionAttrSet:
    builtins.mapAttrs
    (name: value: (getOpts value) // {name = name;})
    optionAttrSet;

  isOption = attrSet: builtins.hasAttr "default" attrSet;

  options = pkgs.callPackage ./modules/nostr-rs-relay/options.nix {inherit packages;};
in
builtins.toJSON
(builtins.removeAttrs
  (builtins.mapAttrs (
    name: value:
      if isOption value
      then (getOpts value) // {name = name;}
      else buildFinalOpts value
  )
  options)
   ["override" "overrideDerivation" ])
