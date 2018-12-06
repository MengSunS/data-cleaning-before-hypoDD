%Author: Meng Sun (sunx0585@umn.edu, mengsunx@gmail.com)
%University of Minnesota, Twin Cities
%02/19/2018
%----------------------------------------------------------------------------------------------------------------------------------
%Function: Data cleaning. 
%          Covert the initial catalog file (information of event and traces are in a single file with messy orders, redundant info, missing data etc.) 
%          into two standarded formated files (station.dat, phase.dat) required as inputs of double difference relocation program (Waldhauser, 2001) 
%          In this file, we use Spanish local network records as an example. Users retrievd data from other networks may modify
%          it according to the detailed format.

%Input:  'IGNcatalogAlboran97_17_phases.txt' 
%Output:  SpainNetph.pha, SpainNet_station.dat

%This file automatically calls functions of splitEvtsAndtrsMB, readAllDat,ToDD_station_Spain
%-----------------------------------------------------------------------------------------------------------------------------------

clear;

SplitEvtsAndtrsMB;
load('SpaiNetToR_pickData'); 
load('SpaiNetToR_eventData'); 
load('sumMag');
fileID = fopen('SpainNetPh.pha','w');
sumEZ=[];
countNa=0;

for i=1:length(eventData);

    YR=eventData(i).date{1}(1:4);
    MO=eventData(i).date{1}(6:7);
    DY=eventData(i).date{1}(9:10);
    HR=eventData(i).hms{1}(1:2);
    MN=eventData(i).hms{1}(4:5);
    SC=eventData(i).hms{1}(7:end);
    LAT=eventData(i).latitude;
    LON=eventData(i).longitude;
    DEP=eventData(i).depth;
    Mag=sumMag(i);
    EH=eventData(i).EH; 
    EZ=eventData(i).EZ;
    RMSS=eventData(i).RMS;
    IDmatrixx=eventData(i).orid{1}; 
    
    if length(str2num(IDmatrixx))==0;
        countNa=countNa+1;
        IDmatrixx=num2str(countNa);
    end;
    sumEZ=[sumEZ; EZ];
   
    fprintf(fileID,'%s %4d %4d %4d %5d %5d %5.2f %7.4f %7.4f %5.2f %3.2f %3.2f %3.2f %6.4f %s \r\n','#',str2num(YR),str2num(MO),str2num(DY),str2num(HR),str2num(MN),str2num(SC),LAT,LON,DEP,Mag,EH,EZ,RMSS,IDmatrixx);
    %finish organzing event info, now start to write the phase info
    
    
    STA=pickData(i).station;
    TT=pickData(i).time;
    WGHT=repmat(1,length(pickData(i).time),1); %initilize weights for P and S arrival records
    for m=1:length(pickData(i).time);
        if pickData(i).iphase{m}=='S';
            WGHT(m)=0.7;                       %customize
        end;
    end;
     
    PHA=pickData(i).iphase; 
    for k=1:length(STA);
    fprintf(fileID,'%s %10.4f %6.2f %s \r\n',STA{k},TT(k),WGHT(k),PHA{k});
    end
    
     
end
fclose(fileID);

ToDD_station_Spain;
