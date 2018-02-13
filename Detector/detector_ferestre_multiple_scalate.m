clear all
clc

path = cd;
cd ..\..;
addpath(genpath('ObjectDet'));
cd(path);

% load ../fisier_test
% mypool = gcp('nocreate'); % If no pool, do not create new one.
% if isempty(mypool)
%     mypool = parpool();
% end
load ../features.mat
% imag = imread('d:\DSUsers\uidg6179\01_Miscellaneous\10_Matlab\objrec\test_bonsai.jpg');
%imag=imread('d:\DSUsers\uidg6179\01_Miscellaneous\Git\cut_images\00001\00001_930831_fa_a_test.png');

imag=imread('D:\DSUsers\uidg6179\01_Miscellaneous\Git\ObjectDet\dumbass_2.png');
%imag=imread('00001_930831_fa_a.ppm');
%imag=imread('ReadandDisplayImageExample_01.png');
n = 346;
m = 266;
flag=1;
img=rgb2gray(imag);
[nn,mm]=size(img);
if (nn < 346 || mm <266)
    img=imresize(img,[n,m]);
    flag=0;
end
II=integralImage(img);

k=0.8;
shift_step = 20;
XX=[];
off=0;
j=1;
lj = 1;
cdr = 1;
figure()
imshow (img);
hold on
while k<=2
    ls=1;
    lj=fix(n*k)
    cs=1;
    cdr=fix(m*k)
    while off==0
        if flag == 0
            off=1;
        end
    if((ls + lj < nn) && (cs + cdr < mm))  
        for i=1:length(featureStrong)
            if featureStrong(i).haarFeature.type == 'X1'
                XX(i)=haar_11(lj,cdr,II,featureStrong(i).haarFeature.value,ls,cs);
            end
            if featureStrong(i).haarFeature.type == 'X2'
                XX(i)=haar_21(lj,cdr,II,featureStrong(i).haarFeature.value,ls,cs);
            end
            if featureStrong(i).haarFeature.type == 'X3'
                XX(i)=haar_31(lj,cdr,II,featureStrong(i).haarFeature.value,ls,cs);
            end
            if featureStrong(i).haarFeature.type == 'X4'
                XX(i)=haar_41(lj,cdr,II,featureStrong(i).haarFeature.value,ls,cs);
            end
            if featureStrong(i).haarFeature.type == 'X5'
                XX(i)=haar_51(lj,cdr,II,featureStrong(i).haarFeature.value,ls,cs);
            end
        end
        s_alfah=0;
        s_alfa=0;
        for i=1:length(XX)
            if XX(i)<featureStrong(i).threshold
                s_alfah=s_alfah+featureStrong(i).weight;
            end
            s_alfa=featureStrong(i).weight+s_alfa;
        end
        
        if s_alfah > 0.5*s_alfa
            fprintf('Evrika %2.0f!\n',j);
            
            rectangle ('Position',[cs,ls,cdr,lj],'EdgeColor','r');
            pause(0.1)
        end
    end
        if (cs + cdr+shift_step) < mm
            cs=cs+shift_step;
        else
            cs=1;
            if (ls + lj + shift_step) < nn
                ls=ls+shift_step;
            else
                off=1;
            end
        end
        
       rectangle ('Position',[cs,ls,cdr,lj],'EdgeColor','k');
       pause(0.1)
        j=j+1;
    end
    off=0;
    k=k+0.20
  
end