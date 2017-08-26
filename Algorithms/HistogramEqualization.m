close all;
clc;

InputImage=imread('11_MG_2735HDR.jpg');


% No. of pixel calculation.
Pixels=size(InputImage,1)*size(InputImage,2);

% Histogram image implementation.
HistImage=uint8(zeros(size(InputImage,1),size(InputImage,2)));

Freq=zeros(256,1);

ProbabilityFreq=zeros(256,1);

ProbabilityC=zeros(256,1);

Cumulative=zeros(256,1);

OpZeros=zeros(256,1);


% Cumulative histogram for each and every pixel og image.
for x=1:size(InputImage,1)
    
    for y=1:size(InputImage,2)        
        Value=InputImage(x,y);
        
        Freq(Value+1)=Freq(Value+1)+1;
        
        ProbabilityFreq(Value+1)=Freq(Value+1)/Pixels;
    end
    
end

Final_Sum=0;

No_bin=255;


% Distributation probability for each and every pixel.
for x=1:size(ProbabilityFreq)    
   Final_Sum=Final_Sum+Freq(x);
   
   Cumulative(x)=Final_Sum;
   
   ProbabilityC(x)=Cumulative(x)/Pixels;
   
   OpZeros(x)=round(ProbabilityC(x)*No_bin);
end


% Final calculation.
for x=1:size(InputImage,1)
    
    for y=1:size(InputImage,2)        
            HistImage(x,y)=OpZeros(InputImage(x,y)+1);
    end
    
end


figure,imshow(InputImage);title(' Original Image: ');
figure,imshow(HistImage);title(' Final Image after Histogram Equalization: ');
%imshowpair(ImageData,HistogramImage,"falsecolor");
imwrite(HistImage,'matlab/OutputImages/Histogram.jpg');