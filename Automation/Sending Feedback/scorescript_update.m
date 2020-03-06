%% libs
% https://www.mathworks.com/matlabcentral/fileexchange/28573-nested-sort-of-structure-arrays


%% read file
clear all
f = uigetfile({'*.xls';'*.xlsx'},'File Selector'); 
[num1,txt1] = xlsread(f,'B:H');
system('taskkill /F /IM EXCEL.EXE');

%% creating struct
lentot = length(txt1(1:end,1));
%Create struct with all data.
pnames = txt1(2:lentot,2);
jnames = txt1(2:lentot,3);
pnumber= num1(1:end,1);
sc1= num1(1:end,4);
sc2= num1(1:end,5);
sc3= num1(1:end,6);
sc4= num1(1:end,7);

ss = struct('pnumber',num2cell(pnumber),'jname',jnames,'pname',pnames,...
    'sc1',num2cell(sc1),'sc2',num2cell(sc2),...
    'sc3',num2cell(sc3),'sc4',num2cell(sc4));

ssc = nestedSortStruct(ss,'jname');

%% To see structure data.
% ssin = ssc;
% for id = 1:length(ssin)
%     fprintf('%d\n',id)
%     disp(ssin(id))
% end

%% For each judge, add up scores, find zscores, and output table with each presenter score.
% jnames = txt1(2:lentot,2);
% ujnames = unique(jnames);
% jid = 1;
% zstab = table([0],{'init'},[0],[0],'VariableNames',{'PosterNumber' 'PresenterName' 'Zscore','TotalScore'});
zstab=[];
jscore = [];
pres = {};
posnum=[];
for id=1:numel(ssc)
    if (id>1)&&(id < numel(ssc))
        if strcmp(ssc(id).jname,ssc(id-1).jname)
            scsum = ssc(id).sc1+ssc(id).sc2+ssc(id).sc3+ssc(id).sc4;
            jscore = [jscore;scsum];
            posnum(end+1)=ssc(id).pnumber;
            pres{end+1}=ssc(id).pname;
        else
            zs = zscore(jscore);
            pres = pres';
            zstabnew = table(posnum',pres,zs,jscore,'VariableNames',{'PosterNumber' 'PresenterName' 'Zscore','TotalScore'});
            zstab = [zstab; zstabnew];
            jscore = [];
            pres={};
            posnum=[];
            scsum = ssc(id).sc1+ ssc(id).sc2+ ssc(id).sc3+ ssc(id).sc4;
            jscore = [jscore;scsum];
            posnum(end+1)=ssc(id).pnumber;
            pres{end+1}=ssc(id).pname;
            
        end
    elseif id==numel(ssc)
            scsum = ssc(id).sc1+ ssc(id).sc2+ ssc(id).sc3+ ssc(id).sc4;
            jscore = [jscore;scsum];
            zs = zscore(jscore);
            posnum(end+1)=ssc(id).pnumber;
            pres{end+1}=ssc(id).pname;
            pres = pres';
            zstabnew = table(posnum',pres,zs,jscore,'VariableNames',{'PosterNumber' 'PresenterName' 'Zscore','TotalScore'});
            zstab = [zstab;zstabnew];
            
    else %When i==1
        scsum = ssc(id).sc1+ssc(id).sc2+ssc(id).sc3+ssc(id).sc4;
        jscore = [jscore;scsum];
        posnum(end+1)=ssc(id).pnumber;
        pres{end+1}=ssc(id).pname;
        pres = pres';
        
    end
end
sortedzstab = sortrows(zstab,'PosterNumber');

%Does the sortedzstab has the same length as the original data
if length(table2struct(sortedzstab))~= length(ssc)
    disp('ERROR: Entry Error')


end    

%% For each presenter, average all of these scores and output a table.
allp = sortedzstab{:,1};
unip  = unique(sortedzstab{:,1});
% tabout = table([0],{'init'},[0],[0],'VariableNames',{'PosterNumber' 'PresenterName' 'AvgZS','AvgTS'});
tabout=[];
for i=1:numel(unip)
    idx = find(allp==unip(i));
    posternum=unip(i);
    name = sortedzstab{idx(1),2};
    meanZS = mean(sortedzstab{idx,3});
    meanTS = mean(sortedzstab{idx,4});
    taboutnew = table(posternum,name,meanZS,meanTS,'VariableNames',{'PosterNumber' 'PresenterName' 'AvgZS','AvgTS'});
    tabout = [tabout;taboutnew];
end
structout=table2struct(tabout);

%% Calculating Ranks
r=1:length([structout(:).AvgZS]);
AvgZS=[structout(:).AvgZS];
[~,p_ZS]=sort(AvgZS,'descend');
r(p_ZS)=r;
C_ZS=num2cell(r);
[structout(:).rank_ZS]=deal(C_ZS{:});

r=1:length([structout(:).AvgZS]);
AvgTS=[structout(:).AvgTS];
[~,p_ts]=sort(AvgTS,'descend');
r(p_ts)=r;
C_TS=num2cell(r);
[structout(:).rank_TS]=deal(C_TS{:});

%Add up the ranks
for j=1:length(structout)
    structout(j).rank_sum=structout(j).rank_ZS+structout(j).rank_TS;     
end
[~,I]=sort([structout(:).rank_sum],'ascend');

fprintf('The winner is %s. \n',structout(I(1)).PresenterName);
fprintf('The runnner up is %s. \n',structout(I(2)).PresenterName);

%Organize in terms of min sum of ranks
structout_rank=nestedSortStruct(structout,'rank_sum');

tabout=struct2table(structout_rank);

%% Write the final table to an excel file.
%This is the Compiled Data
writetable(tabout,'ScoreTable.xls');

system('taskkill /F /IM EXCEL.EXE');
