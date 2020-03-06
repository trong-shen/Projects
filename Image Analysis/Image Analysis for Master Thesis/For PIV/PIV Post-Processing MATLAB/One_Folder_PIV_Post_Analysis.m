%%This should iterate through one folder
%6 Per 1-> 10-> Tiff Couple->1-F->PIV 
path=uigetdir;
cd(path);
D=dir;
D_p=pwd;


            cd(strcat(D_p,'\','PIV'));
            E=dir;
            E_p=pwd;
            mkdir PIV-Post_Analysis;
                for e=3:length(E)
                idx=strfind(E(e).name,'.txt');
                cd(E_p);
                
                if length(idx)==2 && ~isempty(strfind(E(e).name,'PIV3')) %Only find PIV3 positive
                    filename=E(e).name;
                    Post_PIV_Analysis(filename);
                    disp(filename);
                else
                    continue
                end
                
                end
              

