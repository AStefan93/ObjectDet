
%initialize variables
init;

%compute features from dataset
%pozitive
message = 'pozitive'
[X1_poz,X2_poz,X3_poz,X4_poz,X5_poz] = featureCalc(n,m,imgSetVectorPoz);
%negative
message = 'negative'
[X1_neg,X2_neg,X3_neg,X4_neg,X5_neg] = featureCalc(n,m,imgSetVectorNeg);

%clear variables to release ram
clear rnd1 rnd2 rnd3 rnd4 rnd5;
global W_im rnd_all T;
global nr_poz nr_neg nr_im_total errorV; %testing purposes
global medieV; %testing purposes
global index; %testing purposes
global minErr; %testing purposes
global featureValue; %plotting purposes

X1 = [X1_poz;X1_neg];
X2 = [X2_poz;X2_neg];
X3 = [X3_poz;X3_neg];
X4 = [X4_poz;X4_neg];
X5 = [X5_poz;X5_neg];
clear X1_poz X2_poz X3_poz X4_poz X5_poz X1_neg X2_neg X3_neg X4_neg X5_neg;
X_all = [X1 X2 X3 X4 X5];
clear X1 X2 X3 X4 X5;
%calculating the feature weights
featureStrong(T)=struct('haarFeature',0,'threshold',0,'weight',0);

featureValue = zeros(T,nr_im_total);

StrongClassifier = 0;
Beta = zeros(1,T);
alpha = zeros(1,T);
for t = 1 : T
    %to show the progress
    t
    %normalizing weights for each iteration
    sW = sum(W_im);
    W_im = W_im/sW;
    [Beta(t),featureStrong(t)] = WeightCalc(rnd_all,X_all);
    
    featureValue(t,:) = X_all(:,index);
    
end

global im;

figure
X_test = featureValue(10,1:nr_poz);
Y_test = 1:nr_poz;
[X, Y] = meshgrid(X_test, Y_test);
Z_poz = W_im(1:nr_poz);
Z_neg = W_im(nr_poz+1:nr_neg);
bar3(X_test, Z_poz);
xlabel('Feature Values');
zlabel('Weight');
colorbar
title('Image weights and threshold')

message_training = 'finished training';
message_training

save('features','featureStrong');