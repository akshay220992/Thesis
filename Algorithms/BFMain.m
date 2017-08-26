close all;
clc;

InputImage=double(imread('tire.pnm'));
InputImage=InputImage/255;
w=5; sig_s=8; sig_r=0.2;

% Pre-compute Gaussian domain weights.
[A,B] = meshgrid(-w:w,-w:w);
Domain_filter = exp(-(A.^2+B.^2)/(2*sig_s^2));

% Apply bilateral filter.
d = size(InputImage);
Z = zeros(d);
for x = 1:d(1)
   for y = 1:d(2)
      
         % Extract local region.
         x_Min = max(x-w,1);
         x_Max = min(x+w,d(1));
         y_Min = max(y-w,1);
         y_Max = min(y+w,d(2));
         I = InputImage(x_Min:x_Max,y_Min:y_Max,:);
      
         % Compute Gaussian range weights.
         dL = I(:,:,1)-InputImage(x,y,1); 
         da = I(:,:,2)-InputImage(x,y,2); 
         db = I(:,:,3)-InputImage(x,y,3); 
         Range_filter = exp(-(dL.^2+da.^2+db.^2)/(2*sig_r^2));
      
         % Calculate bilateral filter response.
         BF = Range_filter.*Domain_filter((x_Min:x_Max)-x+w+1,(y_Min:y_Max)-y+w+1);
         norm_BF = sum(BF(:));
         Z(x,y,1) = sum(sum(BF.*I(:,:,1)))/norm_BF;
         Z(x,y,2) = sum(sum(BF.*I(:,:,2)))/norm_BF;
         Z(x,y,3) = sum(sum(BF.*I(:,:,3)))/norm_BF;
                
   end
end
figure,imshow(InputImage);title('Original Image');
figure,imshow(Z);title('Final Image after Bilateral Filtering');
NoOfPixelBF=size(Z,1)*size(Z,2);
imwrite(Z,'matlab/OutputImages/BilateralFilter.jpg');