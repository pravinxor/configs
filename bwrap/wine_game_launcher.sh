#!/bin/sh

# Function to restore the original scale of all outputs
restore_scale() {
    printf '%s\n' "$outputs" | while read -r name scale; do
        swaymsg output "$name" scale "$scale"
    done
}

# Trap signals to ensure that the original scale is always restored
trap restore_scale KILL TERM

# Get the display names and their scales
outputs=$(swaymsg -t get_outputs | jq -r '.[] | .name + " " + (.scale|tostring)')

# Set the scale of all outputs to 1
swaymsg output "*" scale 1

# Run the game
bwrap \
    --setenv DXVK_ENABLE_NVAPI 1 \
    --setenv VKD3D_CONFIG dxr11 \
    --setenv PULSE_LATENCY_MSEC 60 \
    --unshare-all \
    --share-net \
    --die-with-parent \
    --proc /proc \
    --tmpfs /tmp \
    --dev-bind /dev /dev \
    --ro-bind /sys /sys \
    --ro-bind /var /var \
    --ro-bind /run /run \
    --ro-bind /etc /etc \
    --ro-bind /usr/share /usr/share \
    --ro-bind /usr/bin /usr/bin \
    --ro-bind /usr/lib /usr/lib \
    --ro-bind /usr/lib32 /usr/lib32 \
    --symlink /usr/bin /bin \
    --symlink /usr/lib /lib \
    --symlink /usr/lib /lib64 \
    --symlink /usr/bin /sbin \
    --ro-bind ~/Downloads/Torrents ~/Downloads/Torrents \
    --bind ~/.wine ~/.wine \
    wine64 "$@"

# Restore the original scale of all outputs
restore_scale
