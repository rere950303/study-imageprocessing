input=imread('cat-halftone.png');

figure,imshow(input);
title('Input Image');

% Get size
dimX = size(input,1);
dimY = size(input,2);

% Convert pixel type to float
[f, revertclass] = tofloat(input);

% Determine good padding for Fourier transform
PQ = paddedsize(size(input));

% Fourier tranform of padded input image
F = fft2(f,PQ(1),PQ(2));
F = fftshift(F);
figure,imshow(log(1+abs((F))), []);

% -------------------------------------------------------------------------

%
% Creating Frequency filter and apply - High pass filter
%

%
% ToDo
%
P = PQ(1);
Q = PQ(2);
H = zeros(P, Q);
MaxNumExtrema = 4;

TF_row = islocalmax(abs(F), 2, "MaxNumExtrema", MaxNumExtrema);
TF_col = islocalmax(abs(F), 1, "MaxNumExtrema", MaxNumExtrema);
spot = zeros(8, 2);
count = 1;
dok = 100;
n = 10;

 for row = 1:P
     for col = 1:Q
         if (TF_row(row, col) == 1 && TF_col(row, col) == 1)
%              if (count ~= 1 && abs(spot(count - 1, 1) - row) < 5 && abs(spot(count - 1, 2) - col) < 5)
%                  continue
%              end
 
             spot(count, 1) = row;
             spot(count, 2) = col;
             count = count + 1;
         end
     end
 end
 
 for row = 1:P
     for col = 1:Q
         tmp = 1;
         for time = 1:(count - 1)
             dk1 = sqrt((row - P / 2 - spot(time, 1)).^2 + (col - Q / 2 - spot(time, 2)).^2);
             dik1 = sqrt((row - P / 2 + spot(time, 1)).^2 + (col - Q / 2 + spot(time, 2)).^2);
 
             dk2 = 1 + (dok / dk1).^(2.*n);
             dik2 = 1 + (dok / dik1).^(2.*n);
 
             tmp = tmp.*(1 / dk2).*(1 / dik2);
         end
         H(row, col) = tmp;
     end
 end

% BW = imregionalmax(abs(F));
% 
% for row = 1:P
%     for col = 1:Q
%         tmp = 1;
%         for i = 1:P
%             for j = 1:Q
%                 if (BW(i, j) == 1)
%                     dk1 = sqrt((row - P / 2 - i).^2 + (col - Q / 2 - j).^2);
%                     dik1 = sqrt((row - P / 2 + i).^2 + (col - Q / 2 + j).^2);
%                     dk2 = 1 + (dok / dk1).^(2.*n);
%                     dik2 = 1 + (dok / dik1).^(2.*n);
%                     tmp = tmp.*(1 / dk2).*(1 / dik2);
%                 end
%             end
%         end 
%         H(row, col) = tmp;
%     end
% end

G = H.*F;

% -------------------------------------------------------------------------

% Inverse Fourier Transform
G = ifftshift(G);
g = ifft2(G);

% Revert back to input pixel type
g = revertclass(g);

% Crop the image to undo padding
g = g(1:dimX, 1:dimY);

figure,imshow(g, []);
title('Result Image');