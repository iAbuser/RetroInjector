# RetroInjector

This is a modified inject.sh from [RetroDECK/Components](https://github.com/RetroDECK/Components) to allow component injection into an existing RetroDeck installation on your SteamDeck.

## Instructions
* Ensure RetroDeck is installed (Confirmed working on the current latest version 0.10.9b) - If a new install, run through the whole setup/install first
* Download this Github's zip to your SteamDeck and extract it somewhere like your desktop
* Source your own archive file in "*-linux_x64.tar.gz" format and place it in the component folder next to the "component_" files
* Right click the inject.sh file and allow execution
* Launch terminal in this folder and run the following command: ./inject.sh 
* It should now inject your component and work like it never left...

## How it works
Searches strictly for a "*-linux_x64.tar.gz" archive in your component folders and extracts everything from its "publish" folder into your component/bin folder that it creates

Fixes permissions to ensure RetroDeck can properly launch it

It copies your component folder into your RetroDeck installation folder

Runs RetroDeck's reset command for the component you injected since it acts like an initializer for it

## Caution
This only includes soft checks and nothing to actually validate the archive or folder structure. As of June 2026, it works with the provided template as a "reference" ;)


How to make your own component folder:

The provided template is slightly modified to prevent the big issues...

Look at the link below, my inject.sh file and the provided template to see how you can get it to work with other components

[How-to: Add a Component to RetroDECK - A Cooking Philosophy](https://retrodeck.readthedocs.io/en/latest/wiki_development/components/component-guide/creating-components-guide/).

## Disclaimer
This project does not include any archive files, nor will I provide or direct you to any source for obtaining them. You are responsible for acquiring them yourself and for ensuring you have the right to use them. You assume all responsibility and risk associated with obtaining and using those files.

This project is an independent utility and is not affiliated with, endorsed by, or supported by the RetroDECK project or any of its developers.

Please do not contact the RetroDECK developers for support regarding this project. If you choose to use it, you do so entirely at your own risk. I make no guarantees regarding compatibility, stability, or functionality and accept no responsibility for any issues, data loss, or damages that may result from its use.

### This project is intended solely as a helper for integrating a user-supplied archive into RetroDECK and does not distribute any third-party software.
