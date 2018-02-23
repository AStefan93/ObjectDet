function featureStrong_l = WeightCalc(rnd_all,X_all)
%calculates all the weights of the features from each feature vector
global nr_poz nr_neg errorV;
global medieV; %testing purposes
global index;
global minErr;
global W_im n m;

%calculating errors of each feature
[errorV,medieV] = errHaar(X_all,W_im);

%choose feature with minimum error
[minErr,index] = min(errorV);

%compute beta coefficient for updating weights
Beta_l = minErr/(1-minErr);
alpha = log(1/Beta_l);
featureStrong_l.haarFeature = rnd_all(index,:);
featureStrong_l.threshold = medieV(index);
featureStrong_l.weight = alpha;
featureStrong_l.ratio = [n m];

%update weights
%should lower the weights of the images classified correctly by the best
%feature
for i=1:nr_poz
    if X_all(i,index) < medieV(index)
        W_im(i) = W_im(i) * Beta_l;
    end
end
for i=nr_poz+1:nr_poz+nr_neg
    if X_all(i,index) > medieV(index)
       W_im(i) = W_im(i) * Beta_l;
    end
end


