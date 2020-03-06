function [I_g_find_edge,Percent_wrinkles,I_collect]=Read_Tiff_Stack(info,fname,tpf)

    for j=1:numel(info)
        I_indiv=imread(fname ,j,'info',info);

        if info(j).BitDepth==24     
        I_g=rgb2gray(I_indiv);
        else
           I_g=I_indiv;
        end
        I_g=imadjust(I_g);
        I_g_find_edge=edge(I_g,'Sobel','nothinning');
        Percent_wrinkles(1,j)=(j-1)*tpf;
        Percent_wrinkles(2,j)=sum(sum(I_g_find_edge(:,:)))/numel(I_g_find_edge(:,:));
        I_collect(:,:,j)=I_g_find_edge;
    end

end