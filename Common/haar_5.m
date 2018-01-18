% function x=haar_5(n,m,J,rnd,n_new,m_new)
function x=haar_5(n,m,J,rnd)
N=round(n/20);
M=round (m/20);
% n_new=15;
% m_new=10;
% white=round(m_new/2);
% black=mnew-white;
parfor i=1:length(rnd)
%   [startingRow, startingColumn, endingRow, endingColumn]
    n_new=fix(N*rnd(i,3));
    m_new=fix(M*rnd(i,4));
    sR=fix(1+(n-2*n_new)*rnd(i,1));
    sC=fix(1+(m-2*m_new)*rnd(i,2));
    eR=sR+n_new;
    eC=sC+m_new;
    whiteSum1 = J(eR+1,eC+1) - J(eR+1,sC) - J(sR,eC+1) + J(sR,sC);    
    sC=eC;
    sR=fix(1+(n-2*n_new)*rnd(i,1));
    eC=sC+fix(m_new/2);
    eR=sR+n_new;
    blackSum1 = J(eR+1,eC+1) - J(eR+1,sC) - J(sR,eC+1) + J(sR,sC);
    sR=eR;
    iR=sR;
    sC=fix(1+(m-2*m_new)*rnd(i,2));
    eR=sR+n_new;
    eC=sC+m_new;
    whiteSum2 = J(eR+1,eC+1) - J(eR+1,sC) - J(sR,eC+1) + J(sR,sC);    
    sC=eC;
    sR=iR;
    eC=sC+fix(m_new/2);
    eR=sR+n_new;
    blackSum2 = J(eR+1,eC+1) - J(eR+1,sC) - J(sR,eC+1) + J(sR,sC);
    x(i)=whiteSum1+whiteSum2-blackSum1-blackSum2;
end