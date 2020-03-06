%Still odeveloping 2019-03-14
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
            cd(strcat(D_p,'\',D(d).name,'\','PIV'));
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
              
            end
        end
    end
end