{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.git;
in
{
  options.git.enable = lib.mkEnableOption "Enable git";

  config.sops.enable = lib.mkIf cfg.enable true;

  config.programs.git = lib.mkIf cfg.enable {
    enable = true;
    settings = {
      user = {
        name = secrets.users.owner.git.name;
        email = secrets.users.owner.git.email;
      };
      init.defaultBranch = "main";
    };
  };

  config.programs.delta = lib.mkIf cfg.enable {
    enable = true;
    enableGitIntegration = true;
    options = {
      line-numbers = true;
      side-by-side = true;
    };
  };
}
