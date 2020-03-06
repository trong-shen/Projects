function [seg1,img_seed1]=Seg_confluent_func(Image_Gray)
%Input the original greyscale image and output segmentation and detected
%seeds

%% Histogram equlization
Image_Gray=hist_equalize(Image_Gray);

%% Seed Detection
% Remove speckles with median filter
img_med = medif(Image_Gray, 6, 'elliptic'); 
%Gaussian Filter for blurring
img_gauss = gaussf(img_med,12,'iir');
%Detect seeds using local minimums
img_seed1 = minima(img_gauss,2);
%Dilate the seeds
img_seed1 = dilation(img_seed1,5,'elliptic');

%% Watershed with Seeds

%Preprocess the image with Gaussian filter
img_filt = gaussf(img_med,5,'iir');
% Apply watershed w/ seeds
seg1 = waterseed(img_seed1,img_filt,1);

end