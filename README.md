## DFM2HTML

# Dependencies:

http://www.overbyte.eu/arch/icsv858.zip       =>  icsv858\Install\D103Install.groupproj

https://github.com/SynEdit/SynEdit.git        =>  SynEdit\Packages\XE8

https://github.com/yktoo/dklang.git           =>  dklang240.dpk / dcldklang240.dpk

https://github.com/graphics32/graphics32.git  =>  graphics32\Source\Packages\XE8
    * may need to add GR32_Clipboard.pas if compiler complains
    * remove line if compiler complains:
        {$IFDEF IMPLICITBUILDING This IFDEF should not be used by users}