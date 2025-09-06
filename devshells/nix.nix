#devshell/nix.nix
{ inputs, ... } :
{
  perSystem = {pkgs, system, inputs', ...} : {
    devShells.default = pkgs.mkShell {
      packages = [
        inputs'.agenix.packages.default
        pkgs.neovim
        pkgs.git
        pkgs.libnotify
      ];
      shellHook = ''echo "You are now on NixOS dev shell for this flake."'';
    };
  };
}
