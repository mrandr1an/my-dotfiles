{hostName ? "laptop"}:
let
  entries = builtins.readDir ../hosts/${hostName};
  names = builtins.attrNames entries;
  candidates = builtins.filter (n: n == "schema.nix") names;
  count = builtins.length candidates;
in
if count == 0 then
  builtins.throw "No schema.nix found."
else if count > 1 then
  builtins.throw "Multiple schema.nix found."
else
  let
    archetype = import ../hosts/${hostName}/schema.nix;
  in
    if builtins.isAttrs archetype then
      archetype
    else
      builtins.throw "Schema must contain an attribute set."
