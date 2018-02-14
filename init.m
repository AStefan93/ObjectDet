clc
clear all

path = cd;
cd ..\..;
addpath(genpath('ObjectDet'));
cd(path);

%start parallel pool with default settings
mypool = gcp('nocreate'); % If no pool, do not create new one.
if isempty(mypool)
    mypool = parpool();
end
%DataBase Folder
imgFolderPoz = 'D:\DSUsers\uidg6179\Faces\colorferet\dvd2\gray_feret_cd1\data\images';
imgFolderNeg = 'D:\DSUsers\uidg6179\Faces\TestFolder\Negatives';
%imgFolderPoz = 'D:\DSUsers\uidg6179\Faces\negatives\101_ObjRec\bonsai\';
%imgFolderNeg = 'D:\DSUsers\uidg6179\Faces\negatives\101_ObjRec\other\';
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
global rnd1 rnd2 rnd3 rnd4 rnd5;
global rnd_all_struct;
rnd1=rand(nr_features_haar,4);
rnd2=rand(nr_features_haar,4);
rnd3=rand(nr_features_haar,4);
rnd4=rand(nr_features_haar,4);
rnd5=rand(nr_features_haar,4);

rnd1_struct(1:nr_features_total/5) = struct('type','X1','value',0);
rnd2_struct(1:nr_features_total/5) = struct('type','X2','value',0);
rnd3_struct(1:nr_features_total/5) = struct('type','X3','value',0);
rnd4_struct(1:nr_features_total/5) = struct('type','X4','value',0);
rnd5_struct(1:nr_features_total/5) = struct('type','X5','value',0);

for i= 1:(nr_features_total/5)
    rnd1_struct(i).value = rnd1(i,:);
    rnd2_struct(i).value = rnd2(i,:);
    rnd3_struct(i).value = rnd3(i,:);
    rnd4_struct(i).value = rnd4(i,:);
    rnd5_struct(i).value = rnd5(i,:);
end

rnd_all_struct = [rnd1_struct rnd2_struct rnd3_struct rnd4_struct rnd5_struct];

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

global W_im T;
%number of iterations (T)
T = 6000;
%initialize weights of images
W_im(1:nr_im_total) = 1/nr_im_total;


%size of images
n = 384/10;
m = 256/10;