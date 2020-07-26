function GetCRP()
%Select  fasta file
[FileNamex,PathNamex] = uigetfile('*.*','Select the file(*.fasta)');
fn=strcat(PathNamex,FileNamex);
fp = fopen(fn);
path=strcat(PathNamex,FileNamex(1:length(FileNamex)-6),'CGR','\');
mkdir(path);                                    % Saving Path
filename=strcat(path,'GenomesInfo.xlsx');       % The Output files
filenameRQA=strcat(path,'Genomes_RQA.xlsx');
co=1;
LocusName=1;
Source=1;
SequenceLength=1;
Sequence='';
StrainName=1;
EPS=2.8; % Treshold for Recurrence plot (Rp) neighbourhood
Row=1;
while ~feof(fp)
    tline=fgetl(fp);
    k=strfind(tline,'>gb:');
    if ~isempty(k) 
        fprintf('\nRow:%d',Row);
        SequenceLength=length(Sequence);
        A = {LocusName,Source,StrainName,SequenceLength,Sequence};
        xlRange = ['A',num2str(Row)];
        sheet=1;
        xlswrite(filename,A,sheet,xlRange);
        %_________________________________
        if length(Sequence)>10
        [tsx,tsy,pic]=CGR_Genome(Sequence);
        % The CGR picture is saved in the defiend path with JPEG format
        saveas(pic,[path,LocusName],'jpg');
        ts=[tsx;tsy]';
        dlmwrite([path,LocusName,'.txt'],ts);
        % It is Possible to define a treshold for Length of the time series
        %by changing ThrL
        ThrL=length(tsx);
        if length(tsx)>ThrL
            tsx=tsx(1:ThrL);
            tsy=tsy(1:ThrL);
        end
        [m,tou,~]=FindPhaseSpace(tsx);
        tempx=CRP_Features(tsx,m,tou,EPS);
        [m,tou,~]=FindPhaseSpace(tsy);
        tempy=CRP_Features(tsy,m,tou,EPS);
        RQAFeatures=[tempx,tempy];
        xlRange = ['A',num2str(Row)];
        xlswrite(filenameRQA,RQAFeatures,sheet,xlRange);
        end
        %_________________________________
        words=strsplit(tline,{'|',':'});
        LocusName=char(words(2));
        Source=char(words(4));
        StrainName=char(words(6));
        Sequence='';
        Row=Row+1;
    else
        Sequence=[Sequence,tline];
    end
        
end
% Saving the last sequence
if ~isempty(Sequence)
        fprintf('\nRow:%d',Row);
        SequenceLength=length(Sequence);
        A = {LocusName,Source,StrainName,SequenceLength,Sequence};
        xlRange = ['A',num2str(Row)];
        sheet=1;
        xlswrite(filename,A,sheet,xlRange);
        %_________________________________
        if length(Sequence)>10
        [tsx,tsy,pic]=CGR_Genome(Sequence);
        % The CGR picture is saved in the defiend path with JPEG format
        saveas(pic,[path,LocusName],'jpg');
        ts=[tsx;tsy]';
        dlmwrite([path,LocusName,'.txt'],ts);
        % It is Possible to define a treshold for Length of the time series
        %by changing ThrL
        ThrL=length(tsx);
        if length(tsx)>ThrL
            tsx=tsx(1:ThrL);
            tsy=tsy(1:ThrL);
        end
        [m,tou,~]=FindPhaseSpace(tsx);
        tempx=CRP_Features(tsx,m,tou,EPS);
        [m,tou,~]=FindPhaseSpace(tsy);
        tempy=CRP_Features(tsy,m,tou,EPS);
        RQAFeatures=[tempx,tempy];
        xlRange = ['A',num2str(Row)];
        xlswrite(filenameRQA,RQAFeatures,sheet,xlRange);
        end
        %_________________________________
%         words=strsplit(tline,{'|',':'});
%         LocusName=char(words(2));
%         Source=char(words(4));
%         StrainName=char(words(6));
%         Sequence='';
%         Row=Row+1;
%     else
%         Sequence=[Sequence,tline];
end
% end
fclose(fp);
end