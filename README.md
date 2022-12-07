# DFM2HTML

## Install external dependencies:

1) http://www.overbyte.eu/arch/icsv858.zip       =>  icsv858\Install\D103Install.groupproj

2) https://github.com/SynEdit/SynEdit.git        =>  SynEdit\Packages\XE8

3) https://github.com/yktoo/dklang.git           =>  dklang240.dpk / dcldklang240.dpk

4) https://github.com/graphics32/graphics32.git  =>  graphics32\Source\Packages\XE8
   * may need to add GR32_Clipboard.pas if compiler complains
   * may remove this line if compiler complains: {$IFDEF IMPLICITBUILDING This IFDEF should not be used by users}

## Install internal dependencies:

1) d6/dhcomps.dpk

2) d6/dcldhcomps.dpk

3) HBuilder/hbcomps.dpk

## Run

1) HBuilder/DFM2HTML.dpr => F9
