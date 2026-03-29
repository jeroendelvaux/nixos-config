{ config, lib, pkgs, secrets, ... }:

{
  options.file.enable = lib.mkEnableOption "Enable file";

  config = lib.mkIf config.file.enable {
    home.packages = with pkgs; [
      file
    ];
  };
}
