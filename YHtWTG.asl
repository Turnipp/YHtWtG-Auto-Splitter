state("TheGame")
{
  float gameTime : 0x00194ec4, 0x14, 0x2a8, 0x58, 0x9c; /* int-game timer */
  byte cerulean_orb : 0x194B10, 0x00002968, 0x70; /* cerulean aura flag */
  byte crimson_orb : 0x194B10, 0x00002968, 0x71; /* crimson aura flag */
  byte springheel_orb : 0x194B10, 0x00002968, 0x72; /* springheel boots flag */
  byte spider_orb : 0x194B10, 0x00002968, 0x73; /* spider gloves flag */
  byte in_cutscene : 0x194c68, 0x4; /* blocking input flag */
}

state("TheGame", "Steam")
{
  float gameTime : 0x001DAEA4, 0x2c, 0x1E8, 0x6c, 0xB0; /* int-game timer */
  byte cerulean_orb : 0x1DAB18, 0x00002948, 0x84; /* cerulean aura flag */
  byte crimson_orb : 0x1DAB18, 0x00002948, 0x85; /* crimson aura flag */
  byte springheel_orb : 0x1DAB18, 0x00002948, 0x86; /* springheel boots flag */
  byte spider_orb : 0x1DAB18, 0x00002948, 0x87; /* spider gloves flag */
  byte in_cutscene : 0x001DAC58, 0x4; /* blocking input flag */
}

init
{
  vars.in_start_cutscene = 1; /* currently in in-game start cutscene */

  /* Detect if current version is steam */
  if (modules.First().ModuleMemorySize == 1986560)
  {
    version = "Steam";
  }
}

startup
{
  settings.Add("lock_time", true, "Force in-game time");
  settings.SetToolTip("lock_time", "prohibits LiveSplit Timer from approximating game time");
}


start
{
  vars.in_start_cutscene = 1;
  if (current.gameTime < old.gameTime)
  {
    return true;
  }
}

split
{
  if (current.cerulean_orb == 0x1 && old.cerulean_orb == 0x0)
  {
    return true;
  }

  if (current.crimson_orb == 0x1 && old.crimson_orb == 0x0)
  {
    return true;
  }

  if (current.springheel_orb == 0x1 && old.springheel_orb == 0x0)
  {
    return true;
  }

  if (current.spider_orb == 0x1 && old.spider_orb == 0x0)
  {
    return true;
  }

  /* split if in any cutscene, except start cutscene (win or lose cutscenes) */
  if (current.in_cutscene == 1 && old.in_cutscene == 0 && vars.in_start_cutscene != 1)
  {
    return true;
  }
}

update
{
  /* check if player has regained control from start cutscene */
  if (vars.in_start_cutscene == 1 && current.in_cutscene == 0 && old.in_cutscene == 1)
  {
    vars.in_start_cutscene = 0;
  }
}

isLoading
{
  /* stop in-game timer from being aproximated */
  return settings["lock_time"];
}

gameTime
{
  return TimeSpan.FromSeconds(current.gameTime);
}
