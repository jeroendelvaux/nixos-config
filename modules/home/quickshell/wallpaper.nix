{ config, lib, pkgs, ... }:

let
  cfg = config.modules.quickshell;
  wallpapers = [
    {
      url = "https://w.wallhaven.cc/full/rq/wallhaven-rq3d3j.jpg";
      hash = "sha256-w/4tAMCoTv7/vC21q8F0O3XnYZOE+7c+//kjKFBeucA=";
    }
    {
      url = "https://w.wallhaven.cc/full/72/wallhaven-727m9e.jpg";
      hash = "sha256-SLF0ZpezZHrhMkq9fmRUF8HkGfBeHBnHfwbORoNITK0=";
    }
    {
      url = "https://w.wallhaven.cc/full/48/wallhaven-48lx3k.jpg";
      hash = "sha256-plIbtR4r0IJy+ftuybVaYQ/FzbGvknkMLilMPHjpw8U=";
    }
    {
      url = "https://w.wallhaven.cc/full/mp/wallhaven-mpkrx1.jpg";
      hash = "sha256-2es5Eta4Z2fVZ8b58gW6syOBVeawj8JjoDuOXJW+Vvw=";
    }
    {
      url = "https://w.wallhaven.cc/full/48/wallhaven-48g910.jpg";
      hash = "sha256-/BE/hWuTMMT+MAdbYYhmVas4jioYkHUIezCElXRkr4E=";
    }
    {
      url = "https://w.wallhaven.cc/full/28/wallhaven-28dro6.jpg";
      hash = "sha256-Gz3g8okFgARY/JF8HOUzgVPKa6Ye9MyyLChJa/0mAgk=";
    }
    {
      url = "https://w.wallhaven.cc/full/3l/wallhaven-3lgrr3.jpg";
      hash = "sha256-G7pPQ+3zbzlqyA3ehtXtJ9+X6zdfkzPonbD5+Msf1+g=";
    }
  ];

  downloadedWallpapers = map (wp: 
    pkgs.fetchurl {
      inherit (wp) url hash;
    }
  ) wallpapers;

  wallpaperJson = pkgs.writeText "wallpapers.json" (
    builtins.toJSON downloadedWallpapers
  );
in
{
  config = lib.mkIf cfg.enable {
    xdg.configFile."quickshell/wallpapers.json".source = wallpaperJson;
  };
}
