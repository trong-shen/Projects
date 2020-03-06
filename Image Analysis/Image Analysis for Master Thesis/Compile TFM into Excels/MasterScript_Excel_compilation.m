%Comnpile into individual excelsheet in each PIV-Post_Analysis Folder
clear all;
clc;
path=uigetdir;
cd(path);
A=dir;
A_p=pwd;
for a=3:length(A)
    if A(a).isdir==0
        continue
    end
    cd(strcat(A_p,'/',A(a).name));
    B_p=pwd;
    B=dir;
     for b=3:length(B)
        if B(b).isdir==0||isempty(B(b).name)
            continue
        end
        cd(strcat(B_p,'/',B(b).name));
        C=dir;
        C_p=pwd;
        for c=3:length(C)
            if C(c).isdir==0||isempty(C(c).name)
                continue
            end
            P_D=strcat(C_p,'\','Tiff Couple');
            cd(P_D);
            D=dir;
            D_p=pwd;
            for d=3:length(D)
            if D(d).isdir==0||isempty(D(d).name)
                continue
            end
            cd(strcat(D_p,'\',D(d).name,'\','PIV','\','PIV-Post_Analysis'));
            E=dir;
            E_p=pwd;
            counter=1;
                for e=3:length(E)
                idx=strfind(E(e).name,'.txt');
                cd(E_p);
               if length(idx)==1 && ~isempty(strfind(E(e).name,'Traction')) %Only find PIV3 positive
                    filename=E(e).name;
                    Data=importdata(filename,' ');
                    disp(filename);
                    force_mag=sum(Data(5,:));
                    %Figure out the filename
                    excel_sheet_name=strcat(B(b).name,'_',D(d).name);
                    
                    %Write it into an excelsheet
                    %Find where the _ is for frame_name
                    i_=strfind(filename,'_');
                    %Find where the P is for naming of the column
                    i_P=strfind(filename,'P');
                    current_frame=filename(i_+1:i_P-1);
                                        
                    if counter==1
                    xlswrite(excel_sheet_name,{'Frame_Comparison'},'Compilation','A1');
                    xlswrite(excel_sheet_name,{'Summed Force Magnitude'},'Compilation','B1');
                    end
                    xlswrite(excel_sheet_name,{current_frame},'Compilation',strcat('A',num2str(counter+1)));
                    xlswrite(excel_sheet_name,force_mag,'Compilation',strcat('B',num2str(counter+1)));
                    
                    counter=counter+1;
               else
                    continue
               end
                
                end
              
            end
        end
    end
end