function [BW_ROI A]=TFM_ROI (filename)
% Delete everything out of region of interest
A=importdata(filename,' ');
%Median of the Magnitiude 5th Column 

%Convert to Matrix
[MagMatrix,x,y,dx,dy]=ConvertMag(A);
%Perform Linear Optimization for Displaying
MagMatrix_disp=linear_optimization(MagMatrix);
BW_ROI=roipoly(MagMatrix_disp);
[A]=InvConvertMag(MagMatrix.*BW_ROI);

