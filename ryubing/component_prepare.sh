#!/bin/bash

# NOTE: Ryubing config folder is still called Ryujinx, not ryubing
# However the RetroDECK saves folder is ryubing to avoid confusion with older Ryujinx installs, so the users can move their saves easily

# Setting component name and path based on the directory name
component_name="$(basename "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")")"
component_config="/app/retrodeck/components/$component_name/rd_config"

if [[ "$action" == "reset" ]]; then # Run reset-only commands
  log i "------------------------"
  log i "Resetting $component_name"
  log i "------------------------"
  
  create_dir "$XDG_CONFIG_HOME/Ryujinx/system"
  create_dir "$ryubing_profiles_path"
  cp -fv "$component_config/Config.json" "$ryubing_config"
  cp -fvr "$component_config/profiles/controller/"* "$ryubing_profiles_path/"
  log d "Replacing placeholders in \"$ryubing_config\""
  sed -i 's#RETRODECKHOMEDIR#'"$rd_home_path"'#g' "$ryubing_config"
  sed -i 's#RETRODECKSTORAGEDIR#'"$storage_path"'#g' "$ryubing_config"
  sed -i 's#RETRODECKROMSDIR#'"$roms_path"'#g' "$ryubing_config"

  create_dir "$storage_path/switch/dlc"
  create_dir "$storage_path/switch/updates"
  dir_prep "$bios_path/switch/keys" "$XDG_CONFIG_HOME/Ryujinx/system"
  dir_prep "$bios_path/switch/firmware" "$XDG_CONFIG_HOME/Ryujinx/bis/system/Contents"
  dir_prep "$saves_path/switch/ryubing/system" "$XDG_CONFIG_HOME/Ryujinx/bis/system/save"
  dir_prep "$saves_path/switch/ryubing/user" "$XDG_CONFIG_HOME/Ryujinx/bis/user/save"
  dir_prep "$saves_path/switch/ryubing/saveMeta" "$XDG_CONFIG_HOME/Ryujinx/bis/user/saveMeta"
  dir_prep "$mods_path/Ryubing/contents" "$XDG_CONFIG_HOME/Ryujinx/mods/contents/"
  dir_prep "$logs_path/switch/Ryubing" "$XDG_CONFIG_HOME/Ryujinx/Logs"
fi

if [[ "$action" == "postmove" ]]; then # Run only post-move commands
  log i "----------------------"
  log i "Post-moving $component_name"
  log i "----------------------"

  log d "Replacing placeholders in \"$ryubing_config\""
  # This is an unfortunate one-off because set_setting_value does not currently support JSON
  sed -i 's#RETRODECKHOMEDIR#'"$rd_home_path"'#g' "$ryubing_config"
  sed -i 's#RETRODECKSTORAGEDIR#'"$storage_path"'#g' "$ryubing_config"
  sed -i 's#RETRODECKROMSDIR#'"$roms_path"'#g' "$ryubing_config"
  dir_prep "$bios_path/switch/keys" "$XDG_CONFIG_HOME/Ryujinx/system"
  dir_prep "$bios_path/switch/firmware" "$XDG_CONFIG_HOME/Ryujinx/bis/system/Contents"
  dir_prep "$saves_path/switch/ryubing/system" "$XDG_CONFIG_HOME/Ryujinx/bis/system/save"
  dir_prep "$saves_path/switch/ryubing/user" "$XDG_CONFIG_HOME/Ryujinx/bis/user/save"
  dir_prep "$saves_path/switch/ryubing/saveMeta" "$XDG_CONFIG_HOME/Ryujinx/bis/user/saveMeta"
  dir_prep "$mods_path/Ryubing/contents" "$XDG_CONFIG_HOME/Ryujinx/mods/contents/"
  dir_prep "$logs_path/switch/Ryubing" "$XDG_CONFIG_HOME/Ryujinx/Logs"
fi
