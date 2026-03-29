{ config, lib, pkgs, secrets, ... }:

{
  options.picocom.enable = lib.mkEnableOption "Enable picocom";

  config = lib.mkIf config.picocom.enable {
    home.packages = with pkgs; [
      picocom
    ];
  };
}
