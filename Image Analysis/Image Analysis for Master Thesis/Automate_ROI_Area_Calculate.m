clc
clear all
original_dir=pwd;
A=dir;
%Find the sheet name

excel_name=input('Enter name of the compiled excel here');

%counter for compiling data in excel
tab_name='nothing';
% a=6;
for a=3:length(A)
    if ~(A(a).isdir)
        continue
    end
    pos_d=strfind(A(a).name,'-');
    sample_name=A(a).name;
    old_tab_name=tab_name;
    tab_name=sample_name(1:(pos_d-1));
    if ~(strcmp(old_tab_name,tab_name))
     counter=2; %for excel location
    end
    
    %for excel location
    cd(strcat(original_dir,'\',A(a).name));
    B=dir;
    con_folder=pwd;
    %Find the tab name

  for b=3:length(B)
            if~(B(b).isdir)
                continue
            end
                   
        cd(strcat(con_folder,'\',B(b).name));
        C=dir;
        position_folder=pwd;
          for c=3:length(C)
            if~(strcmp(C(c).name,'ROI'))
                continue
            end
                cd(strcat(position_folder,'\',C(c).name));
                D=dir;
                D_pwd=pwd;
                
                for d=3:length(D)
                    if isempty(strfind(D(d).name,'.tif'))
                    continue
                    end
                cd(strcat(position_folder,'\',C(c).name));    
                Image=imread(D(d).name);
                Area=nnz(Image);
                [X,Y]=size(Image);
                Area_fraction=Area/(X*Y);
                find_3=strfind(D(d).name,'.');
                position_name= D(d).name(1:(find_3(1)-1));
                    cd(original_dir);
                    if counter==2
                    xlswrite(excel_name,cellstr('Sample Name'),tab_name,strcat('A',num2str(counter-1)));
                    xlswrite(excel_name,cellstr('Position'),tab_name,strcat('B',num2str(counter-1)));
                    xlswrite(excel_name,cellstr('ROI Area in Pixel'),tab_name,strcat('C',num2str(counter-1)));   
                    xlswrite(excel_name,cellstr('Area Fraction'),tab_name,strcat('D',num2str(counter-1)));   
                    end
                    
                    xlswrite(excel_name,{sample_name},tab_name,strcat('A',num2str(counter)));
                    xlswrite(excel_name,{position_name},tab_name,strcat('B',num2str(counter)));
                    xlswrite(excel_name,Area,tab_name,strcat('C',num2str(counter)));
                    xlswrite(excel_name,Area_fraction,tab_name,strcat('D',num2str(counter)));
                    counter=counter+1;
                end
                end
                end
           end
        




