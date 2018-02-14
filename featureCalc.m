function [X1,X2,X3,X4,X5] = featureCalc(n,m,imgSetVector)
%n - vertical resolution of image
%m - vertical resolution of image
%imgSetVector - image set vector returned by imageSet function
global rnd1 rnd2 rnd3 rnd4 rnd5;

X1=[];
X2=[];
X3=[];
X4=[];
X5=[];

for i=1:length(imgSetVector)
    
    %Print percentage of dataset complete
    percentage_load = 100 * i/length(imgSetVector)
    imgVectorLocation = imgSetVector(i).ImageLocation;
    
    parfor j = 1:imgSetVector(i).Count
        im = imread(char(imgVectorLocation(j)));
        [~, ~, numberOfColorChannels] = size(im);
        if numberOfColorChannels > 1
            % It's a true color RGB image.  We need to convert to gray scale.
            im = rgb2gray(im);
        end
        %workaround for error
        %[n,m] = size(im);
        img=imresize(im,[n,m]);
        %
        %Compute integral Image
        II=integralImage(img);
        %Compute values from Haar Features
        X=haar_1(n,m,II,rnd1);
        X1=[X1;X];
        X=haar_2(n,m,II,rnd2);
        X2=[X2;X];
        X=haar_3(n,m,II,rnd3);
        X3=[X3;X];
        X=haar_4(n,m,II,rnd4);
        X4=[X4;X];
        X=haar_5(n,m,II,rnd5);
        X5=[X5;X];
    end
end