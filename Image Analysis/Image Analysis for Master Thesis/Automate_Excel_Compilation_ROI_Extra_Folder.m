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
    first_folder=pwd;
    %Find the tab name
for z=3:length(B)
            if~(B(z).isdir) || ~isempty((strfind(B(z).name,'2018-11-02')))
                continue
            end
       cd(strcat(first_folder,'\',B(z).name));
        J=dir;    
       con_folder=pwd;
       z=strfind(con_folder,'\');
       con_folder_name=con_folder((z(end)+1):end);
       
  for b=3:length(J)
            if~(J(b).isdir) || ~isempty((strfind(J(b).name,'2018-11-02')))
                continue
            end
                   
        cd(strcat(con_folder,'\',J(b).name));
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
                    if ~(D(d).isdir) || ~isempty((strfind(D(d).name,'2018-11-02')))
                        continue
                    end
                    cd(strcat(D_pwd,'\',D(d).name));
                    E=dir;
                    E_pwd=pwd;
                    
                find_3=strfind(D(d).name,'_');
                position_name= D(d).name(1:(find_3(1)-1));
               excel_loc=[];
                        for e=3:length(E)
                            if isempty(strfind(E(e).name,'xlsx'))
                            else 
                            excel_loc=[excel_loc e];
                            end
                        end
                     x=excel_loc;    
                       
                    Freq=xlsread(E(x).name,'Collection','B2');
                    if isempty(Freq)
                       Freq=0; 
                    end
                    Amp=xlsread(E(x).name,'Collection','C2');
                      if isempty(Amp)
                       Amp=0; 
                    end
                    Avg_Period=xlsread(E(x).name,'Collection','D2');
                     if isempty(Avg_Period)
                       Avg_Period=0; 
                    end
                    Avg_Pk_diff=xlsread(E(x).name,'Collection','E2');
                    if isempty(Avg_Pk_diff)
                       Avg_Pk_diff=0; 
                    end
                    cd(original_dir);
                    if counter==2
                    xlswrite(excel_name,cellstr('Sample Name'),tab_name,strcat('A',num2str(counter-1)));
                    xlswrite(excel_name,cellstr('Position'),tab_name,strcat('B',num2str(counter-1)));
                    xlswrite(excel_name,cellstr('Beating Frequency'),tab_name,strcat('C',num2str(counter-1)));
                    xlswrite (excel_name,cellstr('Beating Amplitude'),tab_name,strcat('D',num2str(counter-1))); 
                    xlswrite (excel_name,cellstr('Average Period'),tab_name,strcat('E',num2str(counter-1)));
                    xlswrite (excel_name,cellstr('Average Pk Difference'),tab_name,strcat('F',num2str(counter-1)));     
                    end
                    xlswrite(excel_name,{strcat(sample_name,'-',con_folder_name)},tab_name,strcat('A',num2str(counter)));
                    xlswrite(excel_name,{position_name},tab_name,strcat('B',num2str(counter)));
                    xlswrite(excel_name,Freq,tab_name,strcat('C',num2str(counter)));
                    xlswrite (excel_name,Amp,tab_name,strcat('D',num2str(counter)));
                    xlswrite (excel_name,Avg_Period,tab_name,strcat('E',num2str(counter)));
                    xlswrite (excel_name,Avg_Pk_diff,tab_name,strcat('F',num2str(counter)));     
                    counter=counter+1;
                end
                end
                end
end
end
        




