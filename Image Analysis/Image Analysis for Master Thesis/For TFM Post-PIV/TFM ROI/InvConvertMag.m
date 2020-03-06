function [A]=InvConvertMag(MagMatrix)
A=[];
[r,c]=size(MagMatrix);
for i=1:r
A=[A MagMatrix(i,:)];
   
end
A=A';
end
