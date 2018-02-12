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
imag=imread('00001_930831_fa_a_test.png');
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
k=0.8;
XX=[];
off=0;
j=1;

%%testing starts here
% imshow(img);
% %II=integralImage(img);
% ls = length(189:533);
% cs = length(300:566);
% imgX=img(189:533,300:566 );
% II=integralImage(imgX);
% imshow (imgX);
% n=ls;
% m=cs;
% for i=1:length(featureStrong)
%     if featureStrong(i).haarFeature.type == 'X1'   
%         XX(i)=haar_11(n,m,II,featureStrong(i).haarFeature.value);
%     end
%     if featureStrong(i).haarFeature.type == 'X2'
% 
%         XX(i)=haar_21(n,m,II,featureStrong(i).haarFeature.value);
%     end
%     if featureStrong(i).haarFeature.type == 'X3'
% 
%         XX(i)=haar_31(n,m,II,featureStrong(i).haarFeature.value);
%     end
%     if featureStrong(i).haarFeature.type == 'X4'
% 
%         XX(i)=haar_41(n,m,II,featureStrong(i).haarFeature.value);
%     end
%     if featureStrong(i).haarFeature.type == 'X5'
% 
%         XX(i)=haar_51(n,m,II,featureStrong(i).haarFeature.value);
%     end
% end
% 
% s_alfah=0;
% s_alfa=0;
% for i=1:length(XX)
%     if XX(i)<featureStrong(i).threshold
%         s_alfah=s_alfah+featureStrong(i).weight;
%     end
%     s_alfa=featureStrong(i).weight+s_alfa;
% end
% 
% if s_alfah > 0.5*s_alfa
%     fprintf('Evrika!\n',j);
%     s_alfah
%     s_alfa/2
% end
%%testing ends here

figure()
imshow (img);
hold on
while k<=1
    ls=1;
    lj=fix(n*k)
    cs=1;
    cdr=fix(m*k)
    
    while off==0
        if flag == 0
            %II=integralImage(img);
            off=1;
        end
        if flag==1
            imgX=img(ls:lj,cs:cdr);
            II=integralImage(img);
%             II(:,948:959)=0;
            n_fereastra=length(ls:lj);
            m_fereastra=length(cs:cdr);
        end
        for i=1:length(featureStrong)
            if featureStrong(i).haarFeature.type == 'X1'
                XX(i)=haar_11(n_fereastra,m_fereastra,II,featureStrong(i).haarFeature.value,ls,cs);
            end
            if featureStrong(i).haarFeature.type == 'X2'
                XX(i)=haar_21(n_fereastra,m_fereastra,II,featureStrong(i).haarFeature.value,ls,cs);
            end
            if featureStrong(i).haarFeature.type == 'X3'
                XX(i)=haar_31(n_fereastra,m_fereastra,II,featureStrong(i).haarFeature.value,ls,cs);
            end
            if featureStrong(i).haarFeature.type == 'X4'
                XX(i)=haar_41(n_fereastra,m_fereastra,II,featureStrong(i).haarFeature.value,ls,cs);
            end
            if featureStrong(i).haarFeature.type == 'X5'
                XX(i)=haar_51(n_fereastra,m_fereastra,II,featureStrong(i).haarFeature.value,ls,cs);
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
            aaa=length(cs:cdr);
            bbb=length(ls:lj);
            
            rectangle ('Position',[cs,ls,aaa,bbb],'EdgeColor','k');
            pause(0.1)
           
%             figure()
%             imshow(imgX)
        end
        if cdr+10 < mm
                cs=cs+10;
                cdr=cdr+10;
            else
                cs=1;
                cdr=fix(m*k)+1;
                if lj+10<nn
                    ls=ls+10;
                    lj=lj+10;
                else
                    off=1;
                end
          
            end
%         n = 346;
%         m = 266;
        j=j+1;

    end
    off=0;
    k=k+0.20
end
% s_test = sum(abs(W1))+ sum(abs(W2)) + sum(abs(W3)) + sum(abs(W4)) + sum(abs(W5));
% 
% incredere
% incredere_perc = 100* incredere/s_test