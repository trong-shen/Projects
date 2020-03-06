function [ seg1,img_seed1] = Seg_non_confluent_func(denuded,Image_Gray)
%Input denuded image and original image
%Output segementation and detected seeds

%% Histogram equlization
Image_Gray=hist_equalize(Image_Gray);

%% Seed Detection
% Remove speckles with median filter
img_med = medif(Image_Gray, 6, 'elliptic'); 
%Gaussian Filter for blurring
img_gauss = gaussf(img_med,15,'iir');
%Find seeds using local minimums
img_seed1 = minima(img_gauss,1,true);
%Detect the seeds
img_seed1 = dilation(img_seed1,5,'elliptic');
%Eliminate seeds found in the denuded area.
img_seed1(logical(denuded)')=0;

%% Watershed with Seeds
%Segmenting the cell-cell border of non-conlfuent image after having
%segemneted the denuded area.

%Preprocess the image with Guaissian filter
img_filt = gaussf(Image_Gray,5,'iir'); 
% Apply watershed w/ seeds
seg1 = waterseed(img_seed1,img_filt,1);
%Ensure the data type is a binary image
seg1=logical(seg1);
end
