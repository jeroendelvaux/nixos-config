{ config, lib, pkgs, secrets, ... }:

{
  options.gimp.enable = lib.mkEnableOption "Enable gimp";

  config = lib.mkIf config.gimp.enable {
    home.packages = with pkgs; [
      gimp
    ];
  };
}
