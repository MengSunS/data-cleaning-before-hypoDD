
catID=fopen('IGNdataless_Station.site', 'r');
wID=fopen('SpainNet_station.dat', 'w');
while ~feof(catID);
txtline=fgetl(catID);
stationName=txtline(1:5);
stationLat=str2num(txtline(28:34));
stationLon=str2num(txtline(37:46));
fprintf(wID, '%5s %8.6f %8.6f\r\n',stationName,stationLat,stationLon);
end;

fclose(catID);
fclose(wID);

