{ config, lib, pkgs, secrets, ... }:

{
  options.wget.enable = lib.mkEnableOption "Enable wget";

  config = lib.mkIf config.wget.enable {
    home.packages = with pkgs; [
      wget
    ];
    programs.fish.shellAbbrs = lib.mkIf (config.fish.enable or false) {
      "wget" = "wget -c";
    };
  };
}
