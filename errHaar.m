function [errorV,medieV] = errHaar(X,W_im)

%X - vector of features for each image
%W_im - vector of weights for each image
global nr_poz;
global nr_neg;

errorV=zeros(1,length(X));
mediepoz=mean(X(1:nr_poz,:));
medieneg=mean(X(nr_poz+1:nr_poz+nr_neg,:));
medieV=(mediepoz+medieneg)/2;

%calculate errors of features
for j=1:length(X)
    for i=1:nr_poz
        if X(i,j) >= medieV(j) %misclassification of pozitive
            errorV(j)=errorV(j) + W_im(i);
        end
    end
    for i=nr_poz+1:nr_poz+nr_neg
        if X(i,j) <= medieV(j) %misclassification of negative
            errorV(j)=errorV(j) + W_im(i);
        end
    end
end