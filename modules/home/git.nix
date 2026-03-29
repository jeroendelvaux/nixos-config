{ config, lib, pkgs, secrets, ... }:

{
  options.git.enable = lib.mkEnableOption "Enable git";

  config = lib.mkIf config.git.enable {
    sops.enable = true;
    programs.git = {
      enable = true;
      settings = {
        user = {
          name = secrets.git.userName;
          email = secrets.git.userEmail;
        };
        init.defaultBranch = "main";
      };
    };
    programs.delta = {
      enable = true;
      enableGitIntegration = true;
      options = {
        line-numbers = true;
        side-by-side = true;
      };
    };
  };
}
