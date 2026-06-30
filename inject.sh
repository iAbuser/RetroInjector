#!/bin/bash

echo "This script will inject all the component_files and the rd_config folder into the RetroDeck component folder."
read -r -p "Do you want to continue? (Y/n): " continue

# Default to "y" if input is empty
if [[ -z "$continue" ]]; then
    continue="y"
fi

if [[ "$continue" =~ ^[Yy]$ ]]; then

    flatpak_user_installation="$HOME/.local/share/flatpak/app/net.retrodeck.retrodeck/current/active/files"
    flatpak_system_installation="/var/lib/flatpak/app/net.retrodeck.retrodeck/current/active/files"
    force_user=false
    force_system=false

    # Determine installation path
    if [ "$force_user" = true ]; then
        echo "Forcing user mode installation."
        app="$flatpak_user_installation"
    elif [ "$force_system" = true ]; then
        echo "Forcing system mode installation."
        app="$flatpak_system_installation"
    elif [ -d "$flatpak_user_installation" ]; then
        echo "RetroDECK is installed in user mode, proceeding."
        app="$flatpak_user_installation"
    elif [ -d "$flatpak_system_installation" ]; then
        echo "RetroDECK is installed in system mode, proceeding."
        app="$flatpak_system_installation"
    else
        echo "RetroDECK installation not found, are you inside a flatpak? Quitting"
        exit 1
    fi

    for dir in */; do
        folder_name="${dir%/}"
        if [[ -d "$folder_name" ]]; then

            #Look for archive file
            archive=$(find "$folder_name" -maxdepth 1 -type f -name "*-linux_x64.tar.gz" | head -n 1)

            if [[ ! -f "$archive" ]]; then
                echo "Archive not located in $folder_name."
                echo "Please place your archive inside $folder_name."
                echo "Aborting!"
                exit 1
            fi

            #Extract the archive
            echo "Found archive: $archive"
            echo "Extracting into $folder_name/bin..."

            mkdir -p "$folder_name/bin"
            tar -xzf "$archive" -C "$folder_name/bin" --strip-components=1 publish

            if [ -z "$(ls -A "$folder_name/bin")" ]; then
                echo "Extraction failed. Please check the archive."
                exit 1
            fi

            rm "$archive"

            #Check if the folder exists in the RetroDeck components directory and remove it if it does
            component_dest="$app/retrodeck/components/$folder_name"

            #This prevents potential old libraries or resources from being left behind
            if [[ -d "$component_dest" ]]; then
                echo "Found existing component, removing: $component_dest..."
                sudo rm -rf "$component_dest"
            fi

            #Fix permissions before moving the files over
            echo "Fixing permissions..."
            find "$folder_name" -type f \( -name "*.sh" -o -path "*/bin/*" \) -exec chmod 755 {} \;

            #Copy the files or "inject" them into the RetroDeck installation
            echo "Injecting folder: $folder_name..."
            sudo cp -r "$folder_name" "$app/retrodeck/components/"

            #Soft check to see if the folder was copied over, then run the RetroDeck reset command to initialize the component
            if [[ -d "$component_dest" ]]; then
                echo "Running RetroDeck initialization (component reset) for $folder_name..."
                flatpak run net.retrodeck.retrodeck --reset "$folder_name"
            else
                echo "Injection seems to have failed for $folder_name. Skipping."
            fi

        else
            echo "Skipping non-directory item: $folder_name"
        fi

    done

else
    echo "Aborting the injection."
    exit 1
fi