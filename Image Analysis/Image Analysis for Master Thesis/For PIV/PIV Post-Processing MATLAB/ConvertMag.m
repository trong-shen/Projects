%%Convert Mag Vector into Mag Matrix
%%Assume a set length of Matrix of 5063X16 with the third interrogation
%%Window

function [MagMatrix x y dx dy]=ConvertMag(A)
row_counter=1;
for i=83:83:5063
MagMatrix(row_counter,1:83)=A((i-83+1):(i),5)';
x(row_counter,1:83)=A((i-83+1):(i),1)';
y(row_counter,1:83)=A((i-83+1):(i),2)';
dx(row_counter,1:83)=A((i-83+1):(i),3)';
dy(row_counter,1:83)=A((i-83+1):(i),4)';  
row_counter=row_counter+1;

end  
end