{ config, lib, pkgs, secrets, ... }:

{
  options.ascii.enable = lib.mkEnableOption "Enable ascii";

  config = lib.mkIf config.ascii.enable {
    home.packages = with pkgs; [
      ascii
    ];
  };
}
