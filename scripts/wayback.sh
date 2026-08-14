#!/bin/bash

brightness=$(brightnessctl get)
max=$(brightnessctl max)
percent=$(( brightness * 100 / max ))

blocks=10
filled=$(( (percent * blocks + 50) / 100 ))
empty=$(( blocks - filled ))

bar=$(printf '█%.0s' $(seq 1 $filled))
bar+=$(printf '░%.0s' $(seq 1 $empty))

echo  [$bar] $percent%
