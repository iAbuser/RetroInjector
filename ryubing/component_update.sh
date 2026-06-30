#!/bin/bash

#########################################################################
# These actions happen conditionally based on the version being upgraded
#########################################################################

if [[ $(check_version_is_older_than "$version_being_updated" "0.10.0b") == "true" ]]; then
  # In version 0.10.0b, the following changes were made that required config file updates/reset or other changes to the filesystem:
  # - Init Ryubing as it is a new emulator
  # - Migrate legacy Ryujinx and Yuzu saves to Ryubing saves dir

  log i "0.10.0b Upgrade - Reset: Ryubing"

  log i "Checking for Ryujinx and Yuzu saves to move into Ryubing folder."
  switch_saves_moved=false

  for old_saves_path_system in "$saves_path/switch/ryujinx/nand/system/save" \
                          "$XDG_HOME_CONFIG/Ryujinx/bis/system/save" \
                          "$saves_path/switch/yuzu/nand/system/save" \
                          "$XDG_HOME_CONFIG/Yuzu/bis/system/save" ; do

    if [[ -d "$old_saves_path_system" ]]; then
      log i "Found Switch saves in $old_saves_path_system to move."
      rsync -a --ignore-existing --mkpath "$old_saves_path_system/" "$saves_path/switch/ryubing/system"
      switch_saves_moved=true
    fi

    for old_saves_path_user in "$saves_path/switch/ryujinx/nand/user/save" \
                          "$XDG_HOME_CONFIG/Ryujinx/bis/user/save" \
                          "$saves_path/switch/yuzu/nand/user/save" \
                          "$XDG_HOME_CONFIG/Yuzu/bis/user/save" ; do

      if [[ -d "$old_saves_path_user" ]]; then
        log i "Found Switch saves in $old_saves_path_user to move."
        rsync -a --ignore-existing --mkpath "$old_saves_path_user/" "$saves_path/switch/ryubing/user"
        switch_saves_moved=true
      fi
    done

  done

  if [[ $switch_saves_moved == true ]]; then
    log i "Ryujinx and Yuzu saves have been moved into Ryubing folder."
    configurator_generic_dialog "RetroDECK - Ryubing Post Update" "<span foreground='$purple'><b>Ryujinx</b></span> and <span foreground='$purple'><b>Yuzu</b></span> save files have been consolidated into the <span foreground='$purple'><b>Ryubing</b></span> directory.\nThe previous Ryujinx save location is no longer in use and may be safely removed manually to reclaim disk space.\n\n<span foreground='$purple'><b>RetroDECK does not automatically delete any save data.</b></span>"
  fi

  prepare_component "reset" "ryubing"
fi
