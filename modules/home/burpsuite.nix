{ config, lib, pkgs, secrets, ... }:

{
  options.burpsuite.enable = lib.mkEnableOption "Enable Burp Suite";

  config = lib.mkIf config.burpsuite.enable {
    java.enable = true;
    home.packages = [
      pkgs.burpsuite
    ];
    xdg = {
      configFile."burp/user-config.json".text = builtins.toJSON {
        user_options = {
          display = {
            user_interface = {
              font_size = 16;
              look_and_feel = "Dark";
            };
          };
        };
      };
      desktopEntries.burpsuite = let
        burpExe = "${pkgs.burpsuite}/bin/burpsuite";
        confPath = ".config/burp/user-config.json";
      in {
        name = "Burp Suite Community Edition";
        exec = "${burpExe} --user-config-file=\"${confPath}\"";
        icon = "burpsuite";
        terminal = false;
      };
    };
    programs.fish.shellAbbrs = lib.mkIf (config.fish.enable or false) {
      "burpsuite" = "burpsuite --user-config-file=$HOME/.config/burp/user-config.json";
    };
    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
      "burpsuite"
    ];
  };
}
