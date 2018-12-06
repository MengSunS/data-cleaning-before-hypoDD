# -Matlab-Data-cleansing-before-double-difference-relocation
Background: 

Double difference algorithm (Waldhauser and Ellsworth, 2000) is a widely used method to improve the seismicity pattern precision in seismology. However, the raw data downloaded from networks can not be used as the inputs directly due to formats, info sequence, missing data, redundant info etc.. Here, we present codes to deal these problems (use Spainish local network catalog as an example) and the resulted two files can be directly used as inputs of double difference relocation (hypoDD). 


Function: 
         Data cleaning. 
         Covert the initial catalog file (information of event and traces are in a single file with messy orders, redundant info, missing          data etc.) into two standarded formated files (station.dat, phase.dat) required as inputs of double difference relocation                program (Waldhauser, 2001) 
         Here, we use Spanish local network records as an example. Users retrievd data from other networks may modify it according                  to the detailed format.

Usage:   
         Run DD_phase_Spain.m, it will automatically call splitEvtsAndtrsMB.m, readAllDat.m, ToDD_station_Spain.m

Input: 
         'IGNcatalogAlboran97_17_phases.txt' 

Output:  
          SpainNetph.pha, SpainNet_station.dat
