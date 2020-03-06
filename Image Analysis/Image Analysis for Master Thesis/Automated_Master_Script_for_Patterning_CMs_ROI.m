close all
clear all
clc
z=input('What is the prominence criteria for peaks and valleys selection? Enter "1" for 30% max pks/vs, "2" for 50% max pks/vs"3" for avg_pks/avg_vs');

D=dir;
skip=[];
original_dir=pwd;
fps=input('frame per second');%frames per second
tpf=1/fps;%time per frame
                                                                                                                                                                                                      
for k=3:length(D)
    if ~(D(k).isdir)
        continue
    end
        cd(strcat(original_dir,'\',D(k).name));
    A=dir;
    well_folder=pwd;
for i=3:length(A)

if A(i).isdir
cd(strcat(well_folder,'\',A(i).name));
B_pwd=pwd;
B=dir;
else 
    continue
end
for b=3:length(B)
    if ~strcmp(B(b).name,'ROI')
        continue
    end
    cd(strcat(B_pwd,'\',B(b).name));
    J=dir;
    J_pwd=pwd;
for j=3:length(J)
    cd(J_pwd);
if ~isempty(strfind(J(j).name,'4X'))||isempty(strfind(J(j).name,'.tif'))
  continue  
end
fname=J(j).name;
info=imfinfo(fname);

[I_g_find_edge,Percent_wrinkles,I_collect]=Read_Tiff_Stack(info,fname,tpf);
if ~isempty(strfind(fname(1:end-4),'.'))
    i=strfind(fname(1:end-4),'.');
    fname(i)='_';

end
[I_g_find_edge,Percent_wrinkles,I_collect]=Read_Tiff_Stack(info,fname,tpf);
pos2=strfind(fname,'.');
analysis_data_name=fname(1:(pos2(1)-1));


mkdir(strcat(analysis_data_name,'_','MATLAB'))
cd(strcat(analysis_data_name,'_','MATLAB'))

data_length=length(Percent_wrinkles(1,:));
xlswrite(('MATLAB.xlsx'),Percent_wrinkles(1,:)','Original Data',strcat('A2:A',num2str(data_length+2-1)));
xlswrite(('MATLAB.xlsx'),Percent_wrinkles(2,:)','Original Data',strcat('B2:B',num2str(data_length+2-1)));
time=Percent_wrinkles(1,1:end); %To cut off end irregularirties
data=Percent_wrinkles(2,1:end);
Data_Adjust_on_Splits
figurename=strcat(analysis_data_name,'_processed');
saveas(gcf,figurename);
saveas(gcf,strcat(figurename,'.tif'));

close all
plot(Percent_wrinkles(1,:),Percent_wrinkles(2,:)*100);
saveas(gcf,strcat(analysis_data_name,'_Original_Data','.tiff'));
saveas(gcf,strcat(analysis_data_name,'_Original_Data','.fig'));

xlswrite(('MATLAB.xlsx'),cellstr('Average Frequency'),'Collection','B1');
xlswrite(('MATLAB.xlsx'),cellstr('Average Amplitude'),'Collection','C1');
xlswrite(('MATLAB.xlsx'),cellstr('Average Period'),'Collection','D1');
xlswrite(('MATLAB.xlsx'),cellstr('Peak Diff'),'Collection','E1');

if isempty (pks)
xlswrite(('MATLAB.xlsx'),0,'Collection','B2');
xlswrite(('MATLAB.xlsx'),0,'Collection','C2');
xlswrite(('MATLAB.xlsx'),0,'Collection','D2');
xlswrite(('MATLAB.xlsx'),0,'Collection','E2');    
    
else
xlswrite(('MATLAB.xlsx'),frequency','Collection','B2');
xlswrite(('MATLAB.xlsx'),avgamp','Collection','C2');
xlswrite(('MATLAB.xlsx'),avg_period','Collection','D2');
xlswrite(('MATLAB.xlsx'),avg_peak_diff','Collection','E2');
end
%Outputing Peaks

if isempty(pks)
xlswrite(('MATLAB.xlsx'),0,'Collection','B6');
xlswrite(('MATLAB.xlsx'),0,'Collection','C6');    
    
else
len_pks=length(pks);
cell_range_B=strcat('B6:','B',num2str(2+len_pks));
cell_range_C=strcat('C6:','C',num2str(2+len_pks));
xlswrite(('MATLAB.xlsx'),pks','Collection',cell_range_B);
xlswrite(('MATLAB.xlsx'),pks_time','Collection',cell_range_C);
end
clear time data Percent_wrinkles
end
end
end
end

 