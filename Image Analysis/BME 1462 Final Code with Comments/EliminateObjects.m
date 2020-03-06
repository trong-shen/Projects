%This script eliminates objects based on zscore of size and diameter to reduce errors

%% Caculate the z score
%Only using the z-score of the major axis
z_FeretMax=zscore(msr.Feret(1,:));
%z-score of the pixel area sizes
px_size=zscore(msr.size(:));

%% Elimate the z_scores that are out of scope
% zscore Smaller than -2 and larger than 2
[i2]=find(z_FeretMax<=-1.8|z_FeretMax>=2);
[i3]=find(px_size<=-1|px_size>=2);

%Eliminate entries in the original label matrix
%Eliminate based on with undesirable length of major axis
for j2=1:length(i2)
 L(find(L==i2(j2)))=0;
     
end
%Elimnate the entries with undesirable pixel size
for j3=1:length(i3)
    L(find(L==i3(j3)))=0;

end

%Display new label matrix
L_show=dipshow(L,'labels');
%% Measure again after eliminate of undesirbale extra objects.
msr = measure(L, Image_Gray, ({'size', 'perimeter','P2A','Feret'}),[], 1);