%This Masterscript asks for image file input and output final 
%segmented cell boundary image as well as numbers of cells, orientation, 
%and cell area.

%Clear data and close all window
close all
clear all

%% Intialize with DIP
addpath('C:\Program Files\DIPimage 2.9\common\dipimage')
dip_initialise

%% Read Image
%Takes user input for the name or the path of the file
ImageName=input('Put the name of your image here'); 
%Read the input image
inImage=readim(ImageName);

%% Convert the image to gray value if it's RGB
%Obtain size of the image.
S=size(im2mat(inImage));
%Number of entries in the size matrix.
S_n=numel(S);

if S_n==2% If it doesn't have three channels for RGB
Image_Gray=stretch(inImage,0,100,0,255);
elseif S(3)==3 %RGB
%Convert to RGB based on the rgb2gary function in Image Processing Toolbox
Image_Gray=0.299 * inImage{1} + 0.587 * inImage{2} + 0.114 * inImage{3};
%Enhance contrast of the gray-scale image
Image_Gray=stretch(Image_Gray,0,100,0,255);
else %Not a gray-scale or RGB
    disp('Error. image needs to be gray-scale or RGB')
end

%% Run Confluency Determination Code
[ confluency, outImage ] = DetermineConfluencywithDIP( Image_Gray, ...
33, 3, 0.03); 
%Inputs: original image, big window pixel size, 
%small window pixel size, and standard deviation threshold
%Output Confluency and Final Denuded image


%% Confluency-Specfic Algorithm 
%For confluent images with higher than 95 confluency 
if confluency>=95 
%Segment confluent     
[seg1]=Seg_confluent_func(Image_Gray);
% Label and Measure the matrix
%and Measure objects
LabelandMeasure
% Output final data
FinalOutput

%For non-confluent image
else 
%Segment non-confluent
[ seg1] = Seg_non_confluent_func(outImage,Image_Gray);
%Label and Measure
LabelandMeasure
%Eliminate extra objects obtained 
EliminateObjects
%Output final data
FinalOutput
end
