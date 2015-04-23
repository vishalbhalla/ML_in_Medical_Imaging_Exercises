function[Ii] = integral_image(I)
% From an image I of size n X p, we can define the integral image ˜I of size (n+1) X(p+1)
% ˜ I(i,1) = 0 for i = {f1, ... ,n+1}
% ˜ I(1, j) = 0 for j = {f1, ... ,p+1}
% I(i', j') for i > 1 and j > 1
% Implement a function integral_image.m taking as 
% Input parameter an image I and returning
%  its integral image ˜ I. 
% Use the following identity (valid for i > 1 and j > 1)
% ˜I(i, j) = I(i-1, j-1)+ ˜I(i-1, j)+ ˜I(i, j-1) - ˜I(i-1, j-1)

Ii = {};

end