{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.latex;
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
    xltabular
  ]);
in
{
  options.latex.enable = lib.mkEnableOption "Enable latex";

  config.home.packages = lib.mkIf cfg.enable [
    mylatex
  ];
}
