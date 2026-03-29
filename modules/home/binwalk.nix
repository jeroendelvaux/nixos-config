{ config, lib, pkgs, secrets, ... }:

{
  options.binwalk.enable = lib.mkEnableOption "Enable binwalk";

  config = lib.mkIf config.binwalk.enable {
    home.packages = with pkgs; [
      binwalk
    ];
  };
}
