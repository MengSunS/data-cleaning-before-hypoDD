%Function: data cleaning. Covert the initial local network recorded file into the 
%          compatible format of double difference relocation program. In this file,
%          we use Spanish local network records as an example. Users may modify
%          this file for other networks.

%Input: one initial catalog file (in this file, we use 'IGNcatalogAlboran97_17_phases.txt' as an example)
%Output: two files () that will be used as inputs for the double difference relocation program


clear;     

catfid=fopen('IGNcatalogAlboran97_17_phases.txt','r'); %open the initial catalog file
sumC=[];
sumMag=[];
while ~feof(catfid); %read through all the lines in the catalog file
    txtline = fgetl(catfid);
    if length(txtline)==136 && txtline(1)~=' ' %a line with the event info
        txtFmt='%10s %11s%7.2f%6.2f%9.4f%10.4f%6.1f%6.1f%4d%6.1f%6.1f%5d%5d%4d%7.2f%7.2f%1s %1s %2s %7s %s';
        C=textscan(txtline,txtFmt,'TreatAsEmpty','f');
        sumC=[sumC; C];
        eIDc=C{21}; %this is a cell with a string in it
        eventID=eIDc{1}; %string
        nPicks=C{12}; %a number

       %now skip lines until the one that starts with "Magnitude" (pick headers)
        flag=true;
        while flag 
            dummy=fgetl(catfid);
            flag=~(length(dummy)>35 && (strcmp(dummy(1:9),'Magnitude')) ); %the length is for it to avoid an error if the line doesn't have at least 3 characters and thus it can't address (1:3)
        end
        txtline = fgetl(catfid);
        Mag=txtline(8:10);
        sumMag=[sumMag; Mag];
       %%%%%%%
        %now skip lines until the one that starts with "Sta" (pick headers)
        flag=true;
        while flag 
            dummy=fgetl(catfid);
            flag=~(length(dummy)>4 && (strcmp(dummy(1:3),'Sta')) ); %the length is for it to avoid an error if the line doesn't have at least 3 characters and thus it can't address (1:3)
        end
        
        %open a new text file and sump nPicks lines into it
        
        pickFname=[eventID '.txt'];
        wid=fopen(pickFname, 'w');
        
        for k=1:nPicks
            txtline = fgetl(catfid);
            if isempty(txtline); break; end % sometimes there are fewer picks than nPicks says there are
            fprintf(wid, '%s\r\n', txtline);
        end
        fclose(wid);

        
    end
end
%finish spliting event info and traces info

sumMag=str2num(sumMag);

readAllData; 
       
            