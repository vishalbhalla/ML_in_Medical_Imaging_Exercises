
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
filters = {'straight derivatives', 'diagonal derivatives', 'mean'};

% Generate a random number between 1 to 10
p = randi(10);

% The size a of patches or kernels must always be an odd number a = 2p+1.
% The centre of the patch/kernel is then clearly defined as the pixel (r+1;r+1).
side = 2*p +1; 

% Randomly generate value for sigma.
sigma = randi(5)/4;

%[X] = standard_filters(I, filters, side, sigma);


%% =========== Part 2: Features based on integral images =============
%  Integral images are an elegant and fast way to compute the sum (or the mean) of intensities over a rectangle.
%  This section is dedicated to the computation of features based on this principle.


% =========== Part 2 a: Integral Image =============
% Call the function integral_image
Ii = integral_image(I);

% Displaying the Integral Image.
imshow(Ii);

% =========== Part 2 b: Mean Patch =============
% Call the function mean_patch
%X2b = mean_patch(Ii, side);


% =========== Part 2 c: Mean Features =============
% Call the function mean_features
X2c = mean_features(Ii, side);


% =========== Part 2 d: Local Binary Patterns =============
% Call the function lbp
X2d = lbp(Ii, side);


% =========== Part 2 e: Long Range Features =============
% We propose to compute now the same kind of features but on longer range.

% (i) Call the function long_range_offset
% Offset vector
w = [2,3];

X2e1 = long_range_offset(Ii, side, w);

% (ii) Call the function long_range_two_offsets
% First offset vector
w1 = [2,3];

% Second offset vector
w2 = [4,6];

X2e2 = long_range_two_offsets(Ii, side, w1, w2);



