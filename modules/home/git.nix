{ config, lib, secrets, ... }:

let
  cfg = config.modules.home.git;
in
{
  options.modules.home.git.enable = lib.mkEnableOption "git";

  config = lib.mkIf cfg.enable {
    modules.home.sops.enable = true;
    programs.git = {
      enable = true;
      settings = {
        user = {
          name = secrets.users.owner.git.name;
          email = secrets.users.owner.git.email;
        };
        init.defaultBranch = "main";
      };
    };
    programs.delta = {
      enable = true;
      enableGitIntegration = true;
      options = {
        line-numbers = true;
        side-by-side = false;
      };
    };
  };
}
