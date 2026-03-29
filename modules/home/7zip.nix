{ config, lib, pkgs, secrets, ... }:

{
  options."7zip".enable = lib.mkEnableOption "Enable 7zip";

  config = lib.mkIf config."7zip".enable {
    home.packages = with pkgs; [
      _7zz
    ];
    programs.fish.shellAbbrs = lib.mkIf (config.fish.enable or false) {
      "7z" = "7zz";
    };
  };
}
