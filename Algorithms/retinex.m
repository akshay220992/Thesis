

close all;
clc; 
InputImage = imread('grayscale-image.jpg');
AR=InputImage(:,:,1); 
AG=InputImage(:,:,2); 
AB=InputImage(:,:,3); 

G = 192; 
b = -30; 
alpha = 125; 
beta = 46; 
AR_double=double(AR); 

sigma=65;    

[x,y]=meshgrid((-(size(AR,2)-1)/2):(size(AR,2)/2),(-(size(AR,1)-1)/2):(size(AR,1)/2));   
gauss=exp(-(x.^2+y.^2)/(2*sigma*sigma));   
Gauss=gauss/sum(gauss(:));   
 
%R% 
AR_log=log(AR_double+1);  
F_Ar=fft2(AR_double);  

F_Gauss=fft2(Gauss,size(AR,1),size(AR,2)); 
F_Gauss=fftshift(F_Gauss);   
Fr=ifft2(F_Gauss.*F_Ar);   
Min_1=min(min(Fr)); 
Fr_log= log(Fr - Min_1+1); 
Fr1=AR_log-Fr_log;  

SSR_1=Fr1;
%SSR:
Min_1 = min(min(SSR_1)); 
Max_1 = max(max(SSR_1)); 
SSR_1 = uint8(255*(SSR_1-Min_1)/(Max_1-Min_1)); 

%G% 
AG_double=double(AG); 
AG_log=log(AG_double+1);  
F_Ag=fft2(AG_double);  

F_Gauss=fft2(Gauss,size(AG,1),size(AG,2)); 
F_Gauss=fftshift(F_Gauss);  
Fg= ifft2(F_Gauss.*F_Ag);  
Min_2=min(min(Fg)); 
Fg_log= log(Fg-Min_2+1); 
Fg1=AG_log-Fg_log;  

SSR_2=Fg1;
%SSR:
Min_2 = min(min(SSR_2)); 
Max_1 = max(max(SSR_2)); 
SSR_2 = uint8(255*(SSR_2-Min_2)/(Max_1-Min_2)); 

 
%B% 
AB_double=double(AB); 
AB_log=log(AB_double+1); 
F_Ab=fft2(AB_double); 

F_Gauss=fft2(Gauss,size(AB,1),size(AB,2)); 
F_Gauss=fftshift(F_Gauss); 
Fb= ifft2(F_Gauss.*F_Ab); 
Min_3=min(min(Fb)); 
Fb_log= log(Fb-Min_3+1); 
Fb1=AB_log-Fb_log; 

SSR_3 = Fb1;
%SSR:
Min_3 = min(min(SSR_3)); 
Max_3 = max(max(SSR_3)); 
SSR_3 = uint8(255*(SSR_3-Min_3)/(Max_3-Min_3));


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
SSR = cat(3,SSR_1,SSR_2,SSR_3);
figure,imshow(InputImage);title('Original Image')  
figure,imshow(SSR);title('SSR Output Image')
imwrite(SSR,'matlab/OutputImages/Retinex.jpg');