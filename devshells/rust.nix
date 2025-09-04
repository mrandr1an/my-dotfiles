# Defines .#rust
{ ... }:
{
  perSystem = { pkgs, ... }: {
    devShells.rust = pkgs.mkShell {
      packages = with pkgs; [
        rustc
        cargo
        rust-analyzer
        clippy
        rustfmt
        pkg-config
        openssl.dev
        cmake
        clang
      ];
      shellHook = ''echo You are now in Rust dev mode.'';
    };
  };
}
