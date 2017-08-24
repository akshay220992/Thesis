close all;
clc;

%Image File Read
A=double(imread('grayscale-image.jpg'));
A=A/255;
w=5; sigma_d=4; sigma_r=1;

% Pre-compute Gaussian domain weights.
[X,Y] = meshgrid(-w:w,-w:w);
Domain_fil = exp(-(X.^2+Y.^2)/(2*sigma_d^2));

% Apply bilateral filter.
dim = size(A);
B = zeros(dim);
for i = 1:dim(1)
   for j = 1:dim(2)
      
         % Extract local region.
         iMin = max(i-w,1);
         iMax = min(i+w,dim(1));
         jMin = max(j-w,1);
         jMax = min(j+w,dim(2));
         I = A(iMin:iMax,jMin:jMax,:);
      
         % Compute Gaussian range weights.
         dL = I(:,:,1)-A(i,j,1); 
         da = I(:,:,2)-A(i,j,2); 
         db = I(:,:,3)-A(i,j,3); 
         Range_fil = exp(-(dL.^2+da.^2+db.^2)/(2*sigma_r^2));
      
         % Calculate bilateral filter response.
         F = Range_fil.*Domain_fil((iMin:iMax)-i+w+1,(jMin:jMax)-j+w+1);
         norm_F = sum(F(:));
         B(i,j,1) = sum(sum(F.*I(:,:,1)))/norm_F;
         B(i,j,2) = sum(sum(F.*I(:,:,2)))/norm_F;
         B(i,j,3) = sum(sum(F.*I(:,:,3)))/norm_F;
                
   end
end
figure,imshow(A);title(' Original Image: ');
figure,imshow(B);title('Output Image after Bilateral Filtering');
imwrite(B,'matlab/OutputImages/BilateralFilter.jpg');