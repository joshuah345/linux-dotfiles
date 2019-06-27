
echo "<txt>"$(timeout 0.15 /home/joshua/.config/polybar/player-mpris-tail.py --truncate-text "..." --icon-playing "Now Playing:" --icon-paused "Paused:" -f '{icon} {artist} - {title}')"</txt>"
echo "<txtclick>playerctl play-pause</txtclick>"
