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
            type = secrets.rclone.type;
            hostname = secrets.rclone.hostname;
          };
          secrets = {
            token = config.sops.secrets.rclone.path;
          };
          mounts = {
            "/" = {
              enable = true;
              mountPoint = "/home/${secrets.user.name}/${secrets.rclone.type}";
            };
          };
        };
      };
    };
  };
}
