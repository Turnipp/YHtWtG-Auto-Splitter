state("YHtWtG")
{
  /*
   * Put startup variables here mate
   * E.g booleen states (what orbs have been collected)
   */
   float timer : 0x00000000; /* timer's location in memory */
}

startup
{
  /* Add splits */
  settings.Add("Cerulean Aura", true);
  settings.Add("Crimson Aura", true);
  settings.Add("Springheel Boots", true);
  settings.Add("Spider Gloves", true);
  settings.Add("Win the Game", true);
}

gameTime
{
  return TimeSpan.FromSeconds(current.timer);
}

isLoading
{
  /* implemented to ensure that in-game timer is always used */
  return true;
}
