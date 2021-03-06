clc
clear all

path = cd;
cd ..\..;
addpath(genpath('ObjectDet'));
cd(path);

% %start parallel pool with default settings
% mypool = gcp('nocreate'); % If no pool, do not create new one.
% if isempty(mypool)
%     mypool = parpool();
% end
%DataBase Folder
imgFolderPoz = 'd:\DSUsers\uidg6179\01_Miscellaneous\10_Matlab\objrec\101_ObjRec\accordion\';
imgFolderNeg = 'd:\DSUsers\uidg6179\01_Miscellaneous\10_Matlab\objrec\101_ObjRec\bonsai\';
%imgFolderPoz = 'd:\DSUsers\uidg6179\01_Miscellaneous\Git\cut_images\';
%imgFolderNeg = 'd:\DSUsers\uidg6179\01_Miscellaneous\10_Matlab\objrec\101_ObjRec\other\';
%imgFolderPoz = 'f:\Poze\Image Database\faces\colorferet\dvd1\data\images\';
%imgFolderNeg = 'f:\Poze\Image Database\faces\negatives';
%Reading all image locations
imgSetVectorPoz = imageSet(imgFolderPoz,'recursive');
imgSetVectorNeg = imageSet(imgFolderNeg,'recursive');

global nr_neg nr_poz nr_im_total;
nr_neg = 0;
nr_poz = 0;

for i=1:length(imgSetVectorPoz)
    
    %Count total number of pozitive images
    nr_poz = nr_poz + imgSetVectorPoz(i).Count;

end

for i=1:length(imgSetVectorNeg)
    
    %Count total number of pozitive images
    nr_neg = nr_neg + imgSetVectorNeg(i).Count;

end

nr_im_total = nr_poz + nr_neg;

global nr_features_total;
nr_features_total = 180000;
nr_features_haar = nr_features_total/5;
global rnd1 rnd2 rnd3 rnd4 rnd5 rnd_all_struct;
rnd1 = rand(nr_features_haar,4);
rnd2 = rand(nr_features_haar,4);
rnd3 = rand(nr_features_haar,4);
rnd4 = rand(nr_features_haar,4);
rnd5 = rand(nr_features_haar,4);
%concatenate random vectors
rnd1_struct(1:nr_features_haar) = struct('type','X1','value',0);
rnd2_struct(1:nr_features_haar) = struct('type','X2','value',0);
rnd3_struct(1:nr_features_haar) = struct('type','X3','value',0);
rnd4_struct(1:nr_features_haar) = struct('type','X4','value',0);
rnd5_struct(1:nr_features_haar) = struct('type','X5','value',0);

for i = 1:nr_features_haar
    %rnd1_struct(i).type = X1;
    rnd1_struct(i).value = rnd1(i,:);
end
for i = 1:nr_features_haar
    %rnd2_struct(i).type = X2;
    rnd2_struct(i).value = rnd2(i,:);
end
for i = 1:nr_features_haar
    %rnd3_struct(i).type = X3;
    rnd3_struct(i).value = rnd3(i,:);
end
for i = 1:nr_features_haar
    %rnd4_struct(i).type = X4;
    rnd4_struct(i).value = rnd4(i,:);
end
for i = 1:nr_features_haar
    %rnd5_struct(i).type = X5;
    rnd5_struct(i).value = rnd5(i,:);
end

rnd_all_struct = [rnd1_struct rnd2_struct rnd3_struct rnd4_struct rnd5_struct];
clear rnd1_struct rnd2_struct rnd3_struct rnd4_struct rnd5_struct;

X1_poz=[];
X2_poz=[];
X3_poz=[];
X4_poz=[];
X5_poz=[];
X1_neg=[];
X2_neg=[];
X3_neg=[];
X4_neg=[];
X5_neg=[];

global W_im T n m;
%number of iterations (T)
T = 10;
%initialize weights of images
W_im(1:nr_im_total) = 1/nr_im_total;

%scale to resize images
scale = 0.1;

%size of images
imgInitLocation = imgSetVectorPoz(1).ImageLocation(1);
img_init = imread(imgInitLocation{1});
[~, ~, numberOfColorChannels] = size(img_init);
if numberOfColorChannels > 1
    % It's a true color RGB image.  We need to convert to gray scale.
    img_init = rgb2gray(img_init);
end
[n,m] = size(img_init);
if( n > 100 && m > 100)
    img_init = imresize(img_init,scale);
    [n,m] = size(img_init);
end