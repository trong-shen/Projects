function [ confluency, outImage ] = ...
DetermineConfluencywithDIP( inImage, ...
bigWindow, smallWindow, Threshold )
%Inputs in order, image wish to be segmented in grayscale,
%the big window size in pixels,
%the small window size in pixels
%the threshold standard deviation value in which
%above is considered cell-covered area.

%% Rescale the intensity values to between 0 and 1.
image_stretched=stretch(inImage,0,100,0,1);

%% Applying Small Window Standard Deviation Kernel
%Need to convert back to MATLAB to use stdfilt from image processing
%toolbox
smallStd = stdfilt(im2mat(image_stretched), ...
ones(smallWindow,smallWindow)); 
%Threshold the obtained std results with the input threshold.
smallThresh_dip = ~threshold(mat2im(smallStd), 'fixed',Threshold);

%% Applying Big Window Standard Deviation Kernel
%Need to convert back to MATLAB to use stdfilt from image processing
%toolbox
bigStd = stdfilt(im2mat(image_stretched), ...
ones(bigWindow,bigWindow));
%Threshold the obtained std results with the input threshold.
bigThresh_dip = ~threshold(mat2im(bigStd), 'fixed',Threshold);
%Dilation of the big window to make the foreground closer in including cell
%boundary 
%Big Size divided by 2 was recommended from the paper.
bigDilation = dilation(bigThresh_dip,bigWindow/2,'rectangular');

%% Intersection and Post-Processing
%Intersecting the obtained results from the big window and small window.
intersectImage = mat2im(im2mat(bigDilation) .* im2mat(smallThresh_dip));
%Perform morphological close and opening to better obtain the denuded area
closeImage = closing(intersectImage, ...
smallWindow, 'rectangular');
outImage = opening(closeImage, ...
smallWindow, 'rectangular');
%Morpholigcally open and close to remove unwanted specs and holes
closing_img=closing(outImage,50,'elliptic');
outImage=opening(closing_img,50,'elliptic');
%Ensure it is binary
outImage=logical(outImage)';

%% Calculate confluency
confluency = 100*(1-mean(outImage(:)));
end