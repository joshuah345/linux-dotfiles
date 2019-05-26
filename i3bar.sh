#!/usr/bin/env bash

pgrep polybar 

if [$? -eq 0];

then pkill polybar & polybar -c ~/.comfig/polybar/aenami.ini aenami

else polybar -c ~/.config/polybar/aenami.ini aenami

fi