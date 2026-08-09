{
  pkgs,
  moduleName,
  packages,
  ...
}: let
  lib = pkgs.lib;
  optSet = import ./modules/${moduleName}/options.nix {inherit lib packages;};
  ev = lib.evalModules {modules = [{options = optSet;}];};

  serializeDefault = d:
    if lib.isDerivation d
    then d.name or null
    else d;

  serializeOption = path: opt: {
    name = lib.concatStringsSep "." path;
    description = opt.description or null;
    default = serializeDefault (opt.default or null);
    example = opt.example or null;
    type = opt.type.description or null;
  };

  serializeOptions = prefix: opts:
    builtins.concatMap
    (name:
      let v = opts.${name}; in
      if name == "_module"
      then []
      else if lib.isOption v
      then [(serializeOption (prefix ++ [name]) v)]
      else serializeOptions (prefix ++ [name]) v)
    (builtins.attrNames opts);
in
serializeOptions [] ev.options
