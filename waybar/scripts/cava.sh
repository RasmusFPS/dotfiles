#!/bin/bash

bar=" ▂▃▄▅▆▇█"
dict="s/;//g"
bar_length=${#bar}
for ((i = 0; i < bar_length; i++)); do
    dict+=";s/$i/${bar:$i:1}/g"
done

config_file="/tmp/bar_cava_config"
cat >"$config_file" <<EOF
[general]
bars = 10
framerate = 30
mono_option = average

[input]
method = pipewire
source = alsa_output.usb-Cosair_Corsair_VOID_PRO_Surround_USB_Adapter_00000000-00.analog-stereo.monitor

[output]
method = raw
raw_target = /dev/stdout
data_format = ascii
ascii_max_range = 7
EOF

pkill -f "cava -p $config_file"

stdbuf -o0 cava -p "$config_file" | sed -u 's/[^0-9;]//g' | sed -u "$dict" | while read -r line; do
    printf '{"text": "%s"}\n' "$line"
done
