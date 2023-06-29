#!/bin/bash

# Export all required variables
export SSH_AUTH_SOCK=/run/user/1000/keyring/ssh
export BROWSER=brave-browser

# Hyprland
export XDG_CURRENT_DESKTOP=Hyprland
export XDG_SESSION_TYPE=wayland
export XDG_SESSION_DESKTOP=Hyprland

# GTK themes
export GTK_THEME=Lavanda-Dark-Compact-dark
export GTK_ICON_THEME=Colloid-nord
export XCURSOR_THEME=Bibata-Modern-Ice

# Start hyprland finally
exec Hyprland
