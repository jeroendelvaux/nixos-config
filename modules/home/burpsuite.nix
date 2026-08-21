{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.burpsuite;
in
{
  options.burpsuite.enable = lib.mkEnableOption "Enable Burp Suite";

  config.java.enable = lib.mkIf cfg.enable true;

  config.home.packages = lib.mkIf cfg.enable [
    (pkgs.symlinkJoin {
      name = "burpsuite-wrapped";
      paths = [ pkgs.burpsuite ];
      buildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/burpsuite --add-flags \
          "--user-config-file=${config.xdg.configHome}/burp/user-config.json"
      '' ;
    })
  ];

  config.xdg.configFile = lib.mkIf cfg.enable {
    "burp/user-config.json".text = builtins.toJSON {
      user_options = {
        display = {
          user_interface = {
            font_size = 16;
            look_and_feel = "Dark";
          };
        };
      };
    };
  };
}
