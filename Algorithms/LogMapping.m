close all;
clc;


% Image File Read.
ImageData=imread('wom2.jpg');
imwrite(ImageData,'matlab/InputImages/test_01.jpg');

% Define scaling constant.
Constant=0.3;
d=double(ImageData);
            

% Image Matrix.
[X,Y]=size(ImageData);

        for a = 1:X
            
            for b = 1:Y
                m=d(a,b);
                OutputImage(a,b)=Constant.*log10(1+m);
                
            end
            
        end
        
figure,imshow(ImageData);title(' Original Image: ');       
figure, imshow(OutputImage);title(' Log Mapping Output Image: ');
imwrite(OutputImage,'matlab/OutputImages/LogMap.jpg');
