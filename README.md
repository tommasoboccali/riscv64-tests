All the .sh files can be executed for a given test. Please edit the paths before!

(the best solutionis to use them directly from CVMFS)

G4: all executed with 1 2 4 8 16 32 64 threads

  G4-DMparticle.sh: the exetended / darkmatter test of G4
  
  G4-ParFullCMS.sh: the full CMS geometry
  
  G4-AnaEx01.sh: the extended  /analysis 01 example

  G4-NullTest.sh: just sleeps for 100 sec to get baseline (runs only at 1 thread)


  use a command like "source run_all.sh >& LOG_TOTAL.log &" to execute all
