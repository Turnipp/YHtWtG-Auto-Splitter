# You Have to Win the Game Auto Splitter
This auto splitter is designed for both the steam and non-steam versions of YHtWtG. It allows splits to be compared to the in-game timer and will automatically split when an orb is collected.
## Installation
[Download the script](https://raw.githubusercontent.com/Turnipp/YHtWtG-Auto-Splitter/master/YHtWTG.asl) then add a Scriptable Autosplitter to you LiveSplit layout and select YHtWtG.asl in it's settings. Don't forget to set LivesSplit's `Compare Against` setting to `Game Time` or else the splitter won't work correctly.

## Usage
The Autosplitter should automaticlly start the timer when a new game is started. It will split once an orb is collected or when the player loses control (win and lose orbs). The Autosplitter does not care about the order the items are collected, so rearranging "cerulean aura" and "crimson aura" in Splits settings don't change anything. This splitter doesn't work for 100% runs, but support may be added in future.

This will display the games internal game timer. This splitter will only work when LivesSplit's `Compare Against` setting is set to `Game Time` by default, because it prohibits LiveSplit Timer from approximating game time between updates. This can be changed by unchecking `Force in-game time` in your Scriptable Autosplitter settings.

You will need to manually reset you timer you timer as the Autosplitter can't detect resets right now. The Autosplitter will split at the beginning cutscene if the timer has not been reset, before starting a new game. This is because the beginning cutscene take control away from the player (just like lose and win orbs).

## Further Reading
[Livesplit Autosplitter Documentation](https://github.com/LiveSplit/LiveSplit/blob/master/Documentation/Auto-Splitters.md) for more information 
