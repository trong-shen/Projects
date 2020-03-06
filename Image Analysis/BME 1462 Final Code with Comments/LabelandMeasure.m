%This script creates a binary image and then label and measured

%% Create Binary Image for labelling
%Making a Binary Image where inside the cells are 1s and cell-bounadries are 0s
%Confluet image
if confluency>95 
binary=logical(ones(size(Image_Gray)))'; %same size as input image
%non-confluent image
else 
binary=logical(~outImage)'; %invert the denuded image to obtain cell area
end

%Enforce the watershed lines to be zero for labelling.
binary(seg1)=0;

% Label the Objects and measure the critical cell output
L=label(binary,1);

%Measure with the measure function
msr = measure(L, Image_Gray, ({'size', 'perimeter','P2A','Feret'}),[], 1);
