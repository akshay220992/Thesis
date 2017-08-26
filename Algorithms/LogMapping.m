close all;
clc;

InputImage=imread('wom2.jpg');
imwrite(InputImage,'matlab/InputImages/test_01.jpg');


Constant=0.3;%scaling constant
d_Image=double(InputImage);
            

% Matrix of Image pixels.
[A,B]=size(InputImage);

        for x = 1:A
            
            for y = 1:B
                z=d_Image(x,y);
                L(x,y)=Constant.*log10(1+z);
                
            end
            
        end
        
figure,imshow(InputImage);title(' Original Image: ');       
figure, imshow(OutputImage);title(' Log Mapping Output Image: ');
imwrite(OutputImage,'matlab/OutputImages/LogMap.jpg');
