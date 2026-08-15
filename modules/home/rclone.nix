{ config, lib, pkgs, secrets, ... }:

{
  options.rclone.enable = lib.mkEnableOption "Enable rclone";

  config = lib.mkIf config.rclone.enable {
    sops.enable = true;
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
