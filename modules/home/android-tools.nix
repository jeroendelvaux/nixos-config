{ config, lib, pkgs, secrets, ... }:

{
  options.android-tools.enable = lib.mkEnableOption "Enable android-tools";

  config = lib.mkIf config.android-tools.enable {
    home.packages = with pkgs; [
      android-tools
    ];
  };
}
