{ config, lib, secrets, ... }:

let
  cfg = config.modules.home.rclone;
in
{
  options.modules.home.rclone.enable = lib.mkEnableOption "rclone";

  config = lib.mkIf cfg.enable {
    modules.home.sops.enable = true;
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
