state("TheGame")
{
   float gameTime : 0x00194ec4, 0x14, 0x2a8, 0x58, 0x9c; /* timer's location in memory */
   byte cerulean_orb : 0x194B10, 0x00002968, 0x70; /* pointer to cerulean aura*/
   byte crimson_orb : 0x194B10, 0x00002968, 0x71; /* pointer to crimson aura*/
   byte springheel_orb : 0x194B10, 0x00002968, 0x72; /* pointer to springheel boots*/
   byte spider_orb : 0x194B10, 0x00002968, 0x73; /* pointer to spider gloves*/
   byte in_cutscene : 0x194c68, 0x4; /* pointer to block input flag */

   
}

state("TheGame", "Steam")
{
	float gameTime : 0x001DAEA4, 0x2c, 0x1E8, 0x6c, 0xB0; /* timer's location in memory */
	byte cerulean_orb : 0x1DAB18, 0x00002948, 0x84; /* pointer to cerulean aura*/
	byte crimson_orb : 0x1DAB18, 0x00002948, 0x85; /* pointer to crimson aura*/
	byte springheel_orb : 0x1DAB18, 0x00002948, 0x86; /* pointer to springheel boots*/
	byte spider_orb : 0x1DAB18, 0x00002948, 0x87; /* pointer to spider gloves*/
	byte in_cutscene : 0x001DAC58, 0x4; /* pointer to block input flag */
}

init
{
	vars.in_start_cutscene = 1; /* currently in start in-game cutscene*/
	
	/* Detect if current version is steam */
	if (modules.First().ModuleMemorySize == 1986560)
	{
		version = "Steam";
	}
}
 
startup
{
  
  Action<string> DebugOutput = (text) => {
		print("[YHtWtG Autosplitter] "+text); 
	};
	vars.DebugOutput = DebugOutput;
	
}

start
{ 
	//vars.DebugOutput(current.orbs.ToString("G"));
	/*if (current.gameTime >= 0.0 && current.gameTime <= 1.0) {
		vars.DebugOutput("Timer started");
		return true;
	}*/
	
	/* move to start if statment */ 
	vars.in_start_cutscene = 1;
	
	vars.DebugOutput(modules.First().ModuleMemorySize.ToString("G"));
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
    return true;
}

gameTime
{
    return TimeSpan.FromSeconds(current.gameTime);
}
