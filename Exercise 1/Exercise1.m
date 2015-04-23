
%% =========== Machine Learning in Medical Imaging - Exercise 1 %% =========== 
% Goal: Extraction of standard features at each pixel from a given image.


%% =========== Part 0: Loading and Displaying Image =============
%  We start this exercise by first loading and visualizing the dataset. 
%  I have taken Lena - the standard image in grayscale as a sample here.
%

I = imread('Lenna.jpg');

% Displaying an Image.
imshow(I);
%imagesc(sampleImage);

%% =========== Part 1: Bank of filters =============
%  Call the function standard_filters.m
%  extraction of features that can be seen as filters over the image.
%  The value of such a feature xk(i, j) is a linear combination of the intensities within the neighbourhood of (i, j).
 
% Extraction of standard features at each pixel from the given sample image.
filters = {'straight derivatives', 'diagonal derivatives'};
side =5;
sigma = 2.5;

[X] = standard_filters(I, filters, side, sigma);


%% =========== Part 2: Features based on integral images =============
%  Integral images are an elegant and fast way to compute the sum (or the mean) of intensities over a rectangle.
%  This section is dedicated to the computation of features based on this principle.


% =========== Part 2 a: Integral Image =============
% Call the function integral_image
Ii = integral_image(I);


% =========== Part 2 b: Mean Patch =============
% Call the function mean_patch
X2b = mean_patch(I, a);


% =========== Part 2 c: Mean Features =============
% Call the function mean_features
X2c = mean_features(I, a);


% =========== Part 2 d: Local Binary Patterns =============
% Call the function lbp
X2d = lbp(I, a);


% =========== Part 2 e: Long Range Features =============
% We propose to compute now the same kind of features but on longer range.

% (i) Call the function long_range_offset
X2e1 = long_range_offset(I, a, w);

% (ii) Call the function long_range_two_offsets
X2e2 = long_range_two_offsets(I, a, w1, w2);



