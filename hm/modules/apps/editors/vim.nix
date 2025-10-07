#hm/modules/apps/editors/vim.nix
{config, lib, ...} :
let
  cfg = config.dev.vim;
in
{
  options.dev.vim = {
    enable = lib.mkEnableOption "Vim via home-manager module.";
  };

  config = lib.mkIf cfg.enable {
    programs.vim.enable = true;
  };
}
