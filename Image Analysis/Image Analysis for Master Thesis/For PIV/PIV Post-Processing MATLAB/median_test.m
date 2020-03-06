function [Processed_Matrix A]=median_test (filename)
%Implementing a Normalized Median Test
Thres=3;
noise=0.2;
A=importdata(filename,' ');
%Median of the Magnitiude 5th Column 

%Convert to Matrix
[MagMatrix,x,y,dx,dy]=ConvertMag(A);

%Do the thingggg Normalized Median Test from https://link.springer.com/article/10.1007%2Fs00348-005-0016-6

[J,I]=size(MagMatrix);

Mediansres=zeros(J,I);
Normfluct=zeros(J,I,2);
b=1;
eps=0.2;

for i=1+b:I-b
    for j=1+b:J-b
    Neigh=MagMatrix(j-b:j+b,i-b:i+b);
    NeighCol=Neigh(:);
    NeighCol2=[NeighCol(1:(2*b+1)*b+b); NeighCol((2*b+1)*b+b+2:end)];
    Median=median(NeighCol2);
    Fluct=MagMatrix(j,i)-Median;
    Res=NeighCol2-Median;
    MedianRes=median(abs(Res));
    NormFluct=abs(Fluct/(MedianRes+eps));
    test_result=abs(NormFluct)>Thres;

    
    %Replace with median
    if test_result>0
    Vxi=median(median(dx(j-b:j+b,i-b:i+b)));
    Vyi=median(median(dy(j-b:j+b,i-b:i+b)));
    Magxy=sqrt(Vxi^2+Vyi^2);
    
    %Replace the current value
    dx(j,i)=Vxi;
    dy(j,i)=Vyi;
    MagMatrix(j,i)=Magxy;
    
    end
    
end
end
C_MagMatrix=InvConvertMag(MagMatrix);
C_dx=InvConvertMag(dx);
C_dy=InvConvertMag(dy);

A(:,3)=C_dx;
A(:,4)=C_dy;
A(:,5)=C_MagMatrix;
Processed_Matrix=A;
dash=strfind(filename,'-');
savefilename=strcat(filename(1:(dash(2)-1)),'-Median-test','.txt');
dlmwrite(savefilename,Processed_Matrix,' ');
end
    
    
    
