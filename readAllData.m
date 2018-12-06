date={sumC{:,1}};
%HourMS={sumC{:,2}};
time={sumC{:,2}};
err={sumC{:,3}};
RMS={sumC{:,4}};
latitude={sumC{:,5}};
longitude={sumC{:,6}};
Smaj={sumC{:,7}};
Smin={sumC{:,8}};
Az={sumC{:,9}};
Depth={sumC{:,10}};
dErr={sumC{:,11}};
Ndef={sumC{:,12}};
Nsta={sumC{:,13}};
Gap={sumC{:,14}};
mdist={sumC{:,15}};
Mdist={sumC{:,16}};
Qual1={sumC{:,17}};
Qual2={sumC{:,18}};
Qual3={sumC{:,19}};
Author={sumC{:,20}};
OrigID={sumC{:,21}};

%loop throug all events, build eventData structure
for k=1:length({sumC{:,1}})
    eventData(k).latitude=latitude{k};
    eventData(k).longitude=longitude{k};
    eventData(k).depth=Depth{k};
    eventData(k).time=datenum(time{k},'HH:MM:SS.FFF');
    eventData(k).hms=time{k};
    eventData(k).date=date{k};
    eventData(k).orid=OrigID{k};
    eventData(k).mag=sumMag(k);
    eventData(k).EH=err{k};
    eventData(k).EZ=dErr{k};
    eventData(k).RMS=RMS{k};
end

for j=1:length(eventData);
    if isnan(eventData(j).EZ);
        eventData(j).EZ=0;
        eventData(j).EH=0;
    end;  
end;

%for each event
for k=1:length(eventData)
    disp(k)
    %read the corresponding pick file
    pickData(k)=readIGNPicks(eventData(k));
end
for j=1:length(pickData);
nanj=isnan(pickData(j).time); 
pickData(j).iphase(nanj)=[];
pickData(j).time(nanj)=[];
pickData(j).station(nanj)=[];
pickData(j).delta(nanj)=[];
end;

 for k=1:length(pickData);
     
     inversekx1=strcmp('P', pickData(k).iphase);
     inversekx2=strcmp('S', pickData(k).iphase);
     mergeinversekx=or(inversekx1,inversekx2);
     kx=~mergeinversekx;
     
     
     pickData(k).iphase(kx)=[];
     pickData(k).time(kx)=[];
     pickData(k).station(kx)=[];
     pickData(k).delta(kx)=[];
 end;

save SpaiNetToR_eventData eventData
save SpaiNetToR_pickData pickData 
