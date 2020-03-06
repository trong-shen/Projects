clear all
disp('select the excel with comments and e-mail addresses')
path_result_comments= uigetfile({'*.xls';'*.xlsx'},'File Selector');
[num1,txt1] = xlsread(path_result_comments,'Form responses 1','A:D');
% E_mail_Setup
lentot = length(txt1(1:end,1));
pnames = txt1(1:lentot,1);
jnames = txt1(1:lentot,2);
email= txt1(1:lentot,3);
comments= txt1(1:lentot,4);

cd(input('Path of New Directory of the Word Docs'))
path=pwd;
%% Write Word Docs
for j=1:lentot
    if j==1
    counter_begin=j;
    msoEncodingUTF8 = int32(hex2dec('0000FDE9'));         % MsoEncoding
wdOpenFormatUnicodeText = int32(hex2dec('00000005')); % WdOpenFormat
wdFormatDocumentDefault = int32(hex2dec('00000010')); % WdSaveFormat
wdDoNotSaveChanges = int32(hex2dec('00000000'));  
    word = actxserver('Word.Application');      %start Word
    word.Visible =1;                            %make Word Visible
    document=word.Documents.Add;                %create new Document
    selection=word.Selection;                   %set Cursor
    selection.Font.Name='Courier New';          %set Font
    selection.Font.Size=12;                      %set Size

    elseif ~strcmp(email(j),email(j-1))
        for k=counter_begin:(j-1)
            selection.TypeText(char(jnames(k)))
            selection.TypeParagraph;   
            selection.TypeText(char(comments(k)))
            selection.TypeParagraph;   
        end
    space=strfind(pnames(j-1),' ');
    presentorname=char(pnames(j-1));
    presentorname(space{:})='_';    
    doc_name=strcat(presentorname,'.docx');
    document.SaveAs2(strcat(pwd,'\',doc_name));         %save Document
    word.Quit();                                  %close Word  
    counter_begin=j;
    word = actxserver('Word.Application');      %start Word
    word.Visible =1;                            %make Word Visible
    document=word.Documents.Add;                %create new Document
    selection=word.Selection;                   %set Cursor
    selection.Font.Name='Courier New';          %set Font
    selection.Font.Size=12;                      %set Size
    elseif j==lentot
        for k=counter_begin:(j-1)
            selection.TypeText(char(jnames(k)))
            selection.TypeParagraph;   
            selection.TypeText(char(comments(k)))
            selection.TypeParagraph;   
        end
        
    space=strfind(pnames(j-1),' ');
    presentorname=char(pnames(j-1));
    presentorname(space{:})='_';
        
    doc_name=strcat(presentorname,'.docx');
    document.SaveAs2(strcat(pwd,'\',doc_name));         %save Document
    word.Quit();        
    end
  end


% 
% for j=1:lentot
%     if j==1
%     counter_begin=j;
%     elseif ~strcmp(email(j),email(j-1))
%         for k=counter_begin:(j-1)
%         
%         end
%     end
%     sendmail(
%     
%     
% end

