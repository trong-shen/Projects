%% Writing the sorted results table and add e-mails into a new excel sheet
clear all
disp('Select the comments containing excel')
path_results = uigetfile({'*.xls';'*.xlsx'},'File Selector'); 
[num1,txt1] = xlsread(path_results,'Form responses 1','C:J');
system('taskkill /F /IM EXCEL.EXE');
lentot = length(txt1(1:end,1));

pnames = txt1(2:lentot,1);
jnames = txt1(2:lentot,2);
comments=txt1(2:lentot,8);
%Order based on presentor name
results = struct('pname',pnames,'jname',jnames,...
    'comment',comments);
s_results = nestedSortStruct(results,'pname');

disp('Select the e-mail containing excel')
path_e_mail = uigetfile({'*.xls';'*.xlsx'},'File Selector'); 
[num_e,txt_e] = xlsread(path_e_mail,'B:D');
system('taskkill /F /IM EXCEL.EXE');
lentot_e = length(txt_e(1:end,1));
firstnames = txt_e(2:lentot_e,1);
lastnames = txt_e(2:lentot_e,2);
e_mail=txt_e(2:lentot_e,3);

c_e = struct('firstnames',firstnames,'lastnames',lastnames,...
    'e_mail',e_mail);
tabout=[];
for i=1:length(s_results(:,1))
    pname=s_results(i).pname;
    jname=s_results(i).jname;
    find_space=strfind(name,' ');
    if ~isempty(find_space)
    first_name=name(1:find_space(end)-1);
    last_name=name(find_space(end)+1:end);
    
    last_compare=strcmp(last_name,{c_e.lastnames});
    first_compare=strcmp(first_name,{c_e.firstnames});
    index=intersect(find(first_compare==1),find(first_compare==last_compare));
    end
    if length(index)==1
    taboutnew = table(cellstr(pname),cellstr(jname),cellstr(c_e(index).e_mail),cellstr(s_results(i).comment),'VariableNames',{'PresenterName' 'JudgeName','E_mail','Comments'});
    tabout = [tabout;taboutnew]; 
    elseif isempty(index)
       if sum(sum(first_compare))==1
       index=find(first_compare==1); 
         taboutnew = table(cellstr(pname),cellstr(jname),cellstr(c_e(index).e_mail),cellstr(s_results(i).comment),'VariableNames',{'PresenterName' 'JudgeName','E_mail','Comments'});
    tabout = [tabout;taboutnew]; 
       elseif sum(sum(last_compare))==1
    taboutnew = table(cellstr(pname),cellstr(jname),cellstr(c_e(index).e_mail),cellstr(s_results(i).comment),'VariableNames',{'PresenterName' 'JudgeName','E_mail','Comments'});
    tabout = [tabout;taboutnew]; 
       end
    end
end
writetable(tabout,'E-mail_Feedback_Compilation.xls');
system('taskkill /F /IM EXCEL.EXE');
