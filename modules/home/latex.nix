{ config, lib, pkgs, ... }:

let
  cfg = config.modules.home.latex;
  mylatex = pkgs.texliveBasic.withPackages (ps: with ps; [
    algorithm2e
    amsmath
    biber
    biblatex
    booktabs
    caption
    cleveref
    cm-super
    csquotes
    datatool
    enumitem
    environ
    etoolbox
    fontspec
    geometry
    glossaries
    glossaries-extra
    graphics
    hyperref
    ifoddpage
    koma-script
    kvoptions
    lastpage
    latexmk
    lipsum
    lm
    ltablex
    mathtools
    mfirstuc
    microtype
    multirow
    needspace
    parskip
    pgf
    pgfplots
    relsize
    sectsty
    tocloft
    tools
    tracklang
    xcolor
    xetex
    xltabular
  ]);
in
{
  options.modules.home.latex.enable = lib.mkEnableOption "LaTeX";

  config = lib.mkIf cfg.enable {
    home.packages = [
      mylatex
    ];
  };
}
