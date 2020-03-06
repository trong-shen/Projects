%% libs
% https://www.mathworks.com/matlabcentral/fileexchange/28573-nested-sort-of-structure-arrays


%% read file
clear all
f = uigetfile({'*.xls';'*.xlsx'},'File Selector'); 
[num1,txt1] = xlsread(f,'C:H');
system('taskkill /F /IM EXCEL.EXE');

%% creating struct
lentot = length(txt1(1:end,1));
%Create struct with all data.
pnames = txt1(2:lentot,1);
jnames = txt1(2:lentot,2);

% ss.s1 = num1(1:end,1); 
% ss.s2 = num1(1:end,2);
% ss.s3 = num1(1:end,3);
% ss.s4 = num1(1:end,4);
ss = struct('jname',txt1(2:lentot,2),'pname',txt1(2:lentot,1),...
    'sc1',num2cell(num1(1:end,1)),'sc2',num2cell(num1(1:end,2)),...
    'sc3',num2cell(num1(1:end,3)),'sc4',num2cell(num1(1:end,4)));

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
zstab = table({'init'},[0],[0],'VariableNames',{'PresenterName' 'Zscore','TotalScore'});
for id=1:numel(ssc)
    if id>1
        if strcmp(ssc(id).jname,ssc(id-1).jname)
            scsum = ssc(id).sc1+ssc(id).sc2+ssc(id).sc3+ssc(id).sc4;
            jscore = [jscore;scsum];
            pres{end+1}=ssc(id).pname;
        else
            zs = zscore(jscore);
            pres = pres';
            zstabnew = table(pres,zs,jscore,'VariableNames',{'PresenterName' 'Zscore','TotalScore'});
            zstab = [zstab;zstabnew];
            jscore = [];
            pres={};
            scsum = ssc(id).sc1+ ssc(id).sc2+ ssc(id).sc3+ ssc(id).sc4;
            jscore = [jscore;scsum];
            pres{end+1}=ssc(id).pname;
        end
    else
        jscore = [];
        pres = {};
        scsum = ssc(id).sc1+ssc(id).sc2+ssc(id).sc3+ssc(id).sc4;
        jscore = [jscore;scsum];
        pres{end+1}=ssc(id).pname;
    end
end

sortedzstab = sortrows(zstab,'PresenterName');

%% For each presenter, average all of these scores and output a table.
allp = sortedzstab{:,1};
unip  = unique(sortedzstab{:,1});
tabout = table({'init'},[0],[0],'VariableNames',{'PresenterName' 'AvgZS','AvgTS'});
for i=1:numel(unip)
    idx = find(strcmp(allp,unip{i}));
    name = {unip{i}};
    meanZS = mean(sortedzstab{idx,2});
    meanTS = mean(sortedzstab{idx,3});
    taboutnew = table(name,meanZS,meanTS,'VariableNames',{'PresenterName' 'AvgZS','AvgTS'});
    tabout = [tabout;taboutnew];
end

%% Write the final table to an excel file.
writetable(sortrows(tabout,'PresenterName'),'ScoreTable.xls');
system('taskkill /F /IM EXCEL.EXE');
