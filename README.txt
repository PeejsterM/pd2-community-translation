# pd2-community-translation
A community-driven translation script for PAYDAY 2.
At present, the following features exist:
> Translation!
> Cooking Meth for Dummies
> Script exports text to stringdump.txt

To use this in your game, postrequire this script to lib/managers/localizationmanager. 

If you are not running any scripts at all, download the script hook and replace the contents of your PD2hook.yml file with the following.

Config:
  OutputMode: 1
  OutputFile: PD2Hook.log
  PrintOffsets: false
  ExtraCols: 10
  ExtraRows: 10
PostRequireScripts:
  - ['lib/managers/localizationmanager', relative\path\to\this\file.lua]
  
