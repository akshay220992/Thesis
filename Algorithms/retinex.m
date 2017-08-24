

close all;
clc; 
I = imread('grayscale-image.jpg');
Ir=I(:,:,1); 
Ig=I(:,:,2); 
Ib=I(:,:,3); 

G = 192; 
b = -30; 
alpha = 125; 
beta = 46; 
Ir_double=double(Ir); 

sigma=65;    

[x,y]=meshgrid((-(size(Ir,2)-1)/2):(size(Ir,2)/2),(-(size(Ir,1)-1)/2):(size(Ir,1)/2));   
gauss=exp(-(x.^2+y.^2)/(2*sigma*sigma));   
Gauss=gauss/sum(gauss(:));   
 
%R% 
Ir_log=log(Ir_double+1);  
f_Ir=fft2(Ir_double);  

fgauss=fft2(Gauss,size(Ir,1),size(Ir,2)); 
fgauss=fftshift(fgauss);   
Rr=ifft2(fgauss.*f_Ir);   
min1=min(min(Rr)); 
Rr_log= log(Rr - min1+1); 
Rr1=Ir_log-Rr_log;  

SSR1=Rr1;
%SSR:
min1 = min(min(SSR1)); 
max1 = max(max(SSR1)); 
SSR1 = uint8(255*(SSR1-min1)/(max1-min1)); 

%G% 
Ig_double=double(Ig); 
Ig_log=log(Ig_double+1);  
f_Ig=fft2(Ig_double);  

fgauss=fft2(Gauss,size(Ig,1),size(Ig,2)); 
fgauss=fftshift(fgauss);  
Rg= ifft2(fgauss.*f_Ig);  
min2=min(min(Rg)); 
Rg_log= log(Rg-min2+1); 
Rg1=Ig_log-Rg_log;  

SSR2=Rg1;
%SSR:
min2 = min(min(SSR2)); 
max2 = max(max(SSR2)); 
SSR2 = uint8(255*(SSR2-min2)/(max2-min2)); 

 
%B% 
Ib_double=double(Ib); 
Ib_log=log(Ib_double+1); 
f_Ib=fft2(Ib_double); 

fgauss=fft2(Gauss,size(Ib,1),size(Ib,2)); 
fgauss=fftshift(fgauss); 
Rb= ifft2(fgauss.*f_Ib); 
min3=min(min(Rb)); 
Rb_log= log(Rb-min3+1); 
Rb1=Ib_log-Rb_log; 

SSR3 = Rb1;
%SSR:
min3 = min(min(SSR3)); 
max3 = max(max(SSR3)); 
SSR3 = uint8(255*(SSR3-min3)/(max3-min3));


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ssr = cat(3,SSR1,SSR2,SSR3);
figure,imshow(I);title('Original Image')  
figure,imshow(ssr);title('SSR Output Image')
imwrite(ssr,'matlab/OutputImages/Retinex.jpg');