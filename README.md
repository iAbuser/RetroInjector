# RetroInjector

This is a modified inject.sh from [RetroDECK/Components](https://github.com/RetroDECK/Components) to allow component injection into existing RetroDeck installations without needing to rebuild the flatpak. 

## Documentation

This iterates through all folders in the root directory of this script and attempts to inject the components. 
It includes a template...

Instructions:
Download this Github's zip to your SteamDeck and extract it somewhere like your desktop
Source your own archive file in "*-linux_x64.tar.gz" format and place it in the component folder next to the "component_" files.
Right click the inject.sh file and allow execution. Maybe do it for the folder as well.
Launch terminal in the directory your inject.sh is and run the following command: ./inject.sh 
It should now inject your component and work like it never left...

How it works:
Searches strictly for a "*-linux_x64.tar.gz" archive in your component folders and extracts everything from its "publish" folder into your component/bin folder
Fixes permissions to ensure RetroDeck can properly launch it
Runs RetroDeck's reset command for the component you injected since it acts like an initializer for it

Caution:
This only includes soft checks and nothing to actually validate the archive or folder structure. As of June 2026, it works with the provided template as a "reference" ;)


How to make your own component folder:
The provided template is slightly modified to prevent the big issues...
Look at the link below, my inject.sh file and the provided template to see how you can get it to work with other components

Please visit the [How-to: Add a Component to RetroDECK - A Cooking Philosophy](https://retrodeck.readthedocs.io/en/latest/wiki_development/components/component-guide/creating-components-guide/).


## I WILL NOT PROVIDE YOU WITH ANY ARCHIVE FILES OR SHOW YOU WHERE TO GET THEM FOR OBVIOUS REASONS. YOU CAN FIND THEM ON YOUR OWN. I AM JUST PROVIDING YOU WITH CONFIG FILES. 

## This is not affiliated with RetroDeck and is my own little project to enjoy some stuff that was sadly removed. DO NOT go to them with issues for this. Use this at your own risk.
