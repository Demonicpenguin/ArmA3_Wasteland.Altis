class CfgRestartWarnings
{
   class dynamic
   {
      interval = 6; // after how many hours of uptime the server will restart | ignore if using scheduled restarts
   };
   class scheduled
   {
      schedule[] = {6,12,18,24}; // hours at which the server will restart | ignore if using non-scheduled restarts
   };
   forceLeave = 0; // (in minutes) | kicks players to lobby if still in-game at this amount of minutes before restart | use 0 to disable
   giveWarningsAt[] = {60,50,40,30,20,10,5,2,1}; // higher numbers before lower
   mode = 2; // 1 = non-scheduled | 2 = scheduled
};

// DYNAMIC means: server will always restart after it has been up for a specified amount of hours
// SCHEDULED means: server will always restart at fixed/specified times
