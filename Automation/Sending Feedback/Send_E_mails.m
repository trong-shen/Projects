clear all
cd(input('directory of the word docs'))
disp('find the excel_file containing the e-mail and comments')
path_result_comments= uigetfile({'*.xls';'*.xlsx'},'File Selector')
[num1,txt1] = xlsread(path_result_comments,'Form responses 1','A:D');
lentot = length(txt1(1:end,1));
pnames = txt1(1:lentot,1);
jnames = txt1(1:lentot,2);
email= txt1(1:lentot,3);
comments= txt1(1:lentot,4);

D=dir;
E_mail_Setup
for d=3:length(D)
    space=strfind((D(d).name),'_');
    presentorname=D(d).name(1:end-5);
    presentorname(space)=' ';   
    idx=find(strcmp(presentorname,pnames)==1);
    p_e_mail=email(idx(1));
    
        sendmail(p_e_mail,'Feedback from iARC Poster Judges', ...
        [char(strcat('Hi',{' '},presentorname,',')) 10 ' ' 10 'This is the iARC IT Committee.' ...
        10 'We have compiled a list of feedback on your poster presentation from the judges.'...
        10 'Please find the attached word doc for the feedback.'...
        10 'If the word doc contains only name of the judges and nothing else, then this means they did not leave any feedbacks on their evaluation form.'...
        10 'I hope you find the feedback useful.'...
        10 'Thank you so much for signing up for iARC.'...
        10 'We look foward to more of your particpiation in the near future.'...
        10 ' ' 10 'Sincerely,'...
        10 'iARC IT Committee'],{D(d).name});
    
end