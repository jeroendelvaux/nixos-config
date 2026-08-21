{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.rclone;
in
{
  options.rclone.enable = lib.mkEnableOption "Enable rclone";

  config.sops.enable = lib.mkIf cfg.enable true;

  config.programs.rclone = lib.mkIf cfg.enable {
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
}
