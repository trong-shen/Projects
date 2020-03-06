%This script outputs final data
close all
%Output confluency
confluency
%Display denuded area
dipshow(outImage')
%Display input image
dipshow(inImage)
%Display segemented cell boundary
dipshow(seg1)
%Count number of cells
num_objects=length(msr)
%Ask for micron/pixel ratio 
mic_pix=input('Micron/pixel ratio.Put 1 if it is unknown');
%Output mean average cell size in microns
avg_size=mean(msr.size(:))*mic_pix^2
%Output histogram of cell orientation
histogram(msr.Feret(4,:))
%Display the labelled matrix
L_show=dipshow(L,'labels')
