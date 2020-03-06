clc
clear all
C=dir;
skip=[];
original_dir=pwd;
U=uigetdir; %Selects the folder of interest
cd(U)                             

for l=3:(length(C))
    if ~C(l).isdir
    continue
    end  
    cd(strcat(original_dir,'\',C(l).name));
    Z=dir;
    C_folder=pwd;                                                                                                                                                                                                      

for z=3:length(Z)
    if ~Z(z).isdir
    continue
    end  
    cd(strcat(C_folder,'\',Z(z).name));
    D=dir;
    con_folder=pwd;
    
for k=3:length(D)
    if ~D(k).isdir
    continue
    end  
    cd(strcat(con_folder,'\',D(k).name));
    A=dir;
    well_folder=pwd;
for i=3:length(A)
    if ~A(i).isdir
    continue
    end  
cd(strcat(well_folder,'\',A(i).name));
B=dir;  

% if length(B)==4 && B(3).isdir && B(4).isdir
%     cd(strcat(well_folder,'\',A(i).name,'\',B(3).name));
%     L=dir;
%     for p=3:length(L)
%         if isempty(strfind(L(p).name,'.tif'))|| ~isempty(strfind(B(m).name,'FE'))||~isempty(strfind(B(m).name,'._'))
%     
%         else
%             fname=L(p).name
%             info=imfinfo(fname);
%         end
%     end

for m=3:length(B)
        if ~isempty(strfind(B(m).name,'.tif'))&& ~isdir(B(m).name)
            clear fname
            clear info
            fname=B(m).name;
            info=imfinfo(fname);

                 if info(1).BitDepth==24    
                        for j=1:numel(info)
                        I_indiv=imread(fname,j,'info',info);

                        I_g=rgb2gray(I_indiv);
                        I_gray(:,:,j)=I_g;

                        end

                    imwrite(I_gray(:,:,1),fname)
                    for  j=2:numel(info)

                    imwrite(I_gray(:,:,j),fname,'writemode','append')
                    end
                clear I_g I_gray I_indiv 
                end
        else
            continue
        end
    
end
% for j=1:numel(info)
%     I_indiv=imread(fname ,j,'info',info);
%     if info(j).BitDepth==24     
%     I_g=rgb2gray(I_indiv);
%     else
%        I_g=I_indiv;
%     end
%     I_g_find_edge=edge(I_g,'Sobel','nothinning');
%     Percent_wrinkles(1,j)=(j-1)*tpf;
%     Percent_wrinkles(2,j)=sum(sum(I_g_find_edge(:,:)))/numel(I_g_find_edge(:,:));
%     I_collect(:,:,j)=I_g_find_edge;
% end
end
end
end
end

