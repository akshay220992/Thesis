close all;
clc;

% Image File Read.
ImageData=imread('11_MG_2735HDR.jpg');


% No. of pixel calculation.
NoOfPixel=size(ImageData,1)*size(ImageData,2);

% Histogram image implementation.
HistogramImage=uint8(zeros(size(ImageData,1),size(ImageData,2)));

Frequency=zeros(256,1);

ProbabilityFrequency=zeros(256,1);

ProbabilityC=zeros(256,1);

Cumulative=zeros(256,1);

OutputZeros=zeros(256,1);


% Cumulative histogram for each and every pixel og image.
for a=1:size(ImageData,1)
    
    for b=1:size(ImageData,2)        
        FinalValue=ImageData(a,b);
        
        Frequency(FinalValue+1)=Frequency(FinalValue+1)+1;
        
        ProbabilityFrequency(FinalValue+1)=Frequency(FinalValue+1)/NoOfPixel;
    end
    
end

FinalSum=0;

NumberofBin=255;


% Distributation probability for each and every pixel.
for a=1:size(ProbabilityFrequency)    
   FinalSum=FinalSum+Frequency(a);
   
   Cumulative(a)=FinalSum;
   
   ProbabilityC(a)=Cumulative(a)/NoOfPixel;
   
   OutputZeros(a)=round(ProbabilityC(a)*NumberofBin);
end


% Final calculation.
for a=1:size(ImageData,1)
    
    for b=1:size(ImageData,2)        
            HistogramImage(a,b)=OutputZeros(ImageData(a,b)+1);
    end
    
end


figure,imshow(ImageData);title(' Original Image: ');
figure,imshow(HistogramImage);title(' Final Image after Histogram Equalization: ');
%imshowpair(ImageData,HistogramImage,"falsecolor");
imwrite(HistogramImage,'matlab/OutputImages/Histogram.jpg');