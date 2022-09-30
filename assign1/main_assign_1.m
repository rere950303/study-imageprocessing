
%
% Assignment 1: Histogram Processing
%
% 2022. 9. 18 Won-Ki Jeong
%

%
% Loading input image
%
input=imread('washed_out_pollen.tif');

% Show Histogram, CDF plot, and Input Image
cdf_in = myCDF(input);
figure,plot(0:255, cdf_in)
title('CDF of Input Image');

figure,imhist(input, 256)
ylim('auto')
title('Histogram of Input Image');

figure,imshow(input);
title('Input Image');


%
% Global histogram equalization
%

% Run Histogram Equalization
Out_HE = myHE(input);

% Show Histogram, CDF plot, and Histogram Equalized Image
cdf_HE = myCDF(Out_HE);
figure,plot(0:255, cdf_HE)
title('CDF of Histogram Equalization Result');

figure,imhist(Out_HE, 256)
ylim('auto')
title('Histogram of Histogram Equalization Result');

figure,imshow(Out_HE);
title('Histogram equalization');


%
% Adaptive histogram equalization
%

nBlockX = 10;
nBlockY = 10;

% Run Adaptive Histogram Equalization
Out_AHE = myAHE(input, [nBlockX nBlockY]);

% Show Histogram, CDF plot, and Adaptive Histogram Equalized Image
cdf_AHE = myCDF(Out_AHE);
figure,plot(0:255, cdf_AHE)
title('CDF of Adaptive Histogram Equalization Result');

figure,imhist(Out_AHE, 256)
ylim('auto')
title('Histogram of Adaptive Histogram Equalization Result');

figure,imshow(Out_AHE);
title('Adaptive Hstogram Equalization');
