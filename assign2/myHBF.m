input=imread('racing-blur.png');


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

Do = 200;
n = 10;

for row = 1:P
    for col = 1:Q
        D = sqrt((row - P / 2).^2 + (col - Q / 2).^2);
        H(row, col) = 1 / (1 + (D / Do).^(2.*n));
    end
end

k = 20;
G = zeros(P, Q);

for row = 1:P
    for col = 1:Q
        G(row, col) = (1 + k.*(1 - H(row, col))).*F(row, col);
    end
end

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