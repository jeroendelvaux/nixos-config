{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.modules.rclone;
in
{
  options.modules.rclone.enable = lib.mkEnableOption "Enable rclone";

  config = lib.mkIf cfg.enable {
    modules.sops.enable = true;
    programs.rclone = {
      enable = true;
      remotes = {
        remote = {
          config = {
            type = secrets.users.owner.rclone.type;
            hostname = secrets.users.owner.rclone.hostname;
          };
          secrets = {
            token = config.sops.secrets.rclone.path;
          };
          mounts = {
            "/" = {
              enable = true;
              mountPoint = "${config.home.homeDirectory}/${secrets.users.owner.rclone.type}";
            };
          };
        };
      };
    };
  };
}
