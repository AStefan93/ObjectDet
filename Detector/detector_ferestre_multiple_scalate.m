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
load features.mat
% imag = imread('d:\DSUsers\uidg6179\01_Miscellaneous\10_Matlab\objrec\test_bonsai.jpg');
imag=imread('D:\ObjectDet-master\test_img\testg.jpg');
%imag=imread('00001_930831_fa_a.ppm');
%imag=imread('ReadandDisplayImageExample_01.png');
n = 384;
m = 256;
flag=1;
img=rgb2gray(imag);
[nn,mm]=size(img);
if (nn < 384 || mm <256)
    img=imresize(img,[n,m]);
    flag=0;
end
% [n, m]=size(img);
% n=320;
% m=240;
% img=imresize(img,[n,m]);

% imshow(img);
% [n, m]=size(img);

% XX1=[];
% XX2=[];
% XX3=[];
% XX4=[];
% XX5=[];
% XX1=haar_1(n,m,II,rnd1);
% XX2=haar_2(n,m,II,rnd2);
% XX3=haar_3(n,m,II,rnd3);
% XX4=haar_4(n,m,II,rnd4);
% XX5=haar_5(n,m,II,rnd5);
% incredere = 0;
raport=nn/n;
k=0.2;
XX=[];
off=0;
j=1;
while k<raport
    ls=1;
    lj=fix(n*k)
    cs=1;
    cdr=fix(m*k)
    
    while off==0
        if flag == 0
            II=integralImage(img);
            off=1;
        end
        if flag==1
            imgX=img(ls:lj+1,cs:cdr+1);
            II=integralImage(img);  
        end
        for i=1:length(featureStrong)
            if featureStrong(i).haarFeature.type == 'X1'
                n=ls;
                m=cs;
                XX(i)=haar_11(n,m,II,featureStrong(i).haarFeature.value);
            end
            if featureStrong(i).haarFeature.type == 'X2'
                 n=ls;
                m=cs;
                XX(i)=haar_21(n,m,II,featureStrong(i).haarFeature.value);
            end
            if featureStrong(i).haarFeature.type == 'X3'
                 n=ls;
                m=cs;
                XX(i)=haar_31(n,m,II,featureStrong(i).haarFeature.value);
            end
            if featureStrong(i).haarFeature.type == 'X4'
                 n=ls;
                m=cs;
                XX(i)=haar_41(n,m,II,featureStrong(i).haarFeature.value);
            end
            if featureStrong(i).haarFeature.type == 'X5'
                 n=ls;
                m=cs;
                XX(i)=haar_51(n,m,II,featureStrong(i).haarFeature.value);
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
            figure()
            imshow(imgX)
        end
        if cdr+20 < mm
                cs=cs+20;
                cdr=cdr+20;
            else
                cs=1;
                cdr=fix(m*k)+1;
                if lj+20<nn
                    ls=ls+20;
                    lj=lj+20;
                else
                    off=1;
                end
          
            end
        n = 384;
        m = 256;
        j=j+1;

    end
    off=0;
    k=k+0.20
end
% s_test = sum(abs(W1))+ sum(abs(W2)) + sum(abs(W3)) + sum(abs(W4)) + sum(abs(W5));
% 
% incredere
% incredere_perc = 100* incredere/s_test