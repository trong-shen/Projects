%Linear Normalization of an Image
function Imageout=linear_optimization(Imagein)
[r,c]=size(Imagein);
max_I=max(max(Imagein));
min_I=min(min(Imagein));
max_I_mat=max_I*ones(r,c);
min_I_mat=min_I*ones(r,c);
Imageout=(Imagein-min_I_mat)*(2^8)/(max_I_mat-min_I);
Imageout=uint8(Imageout);