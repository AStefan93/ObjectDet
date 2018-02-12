% function x=haar_4(n,m,J,rnd,n_new,m_new)
function x=haar_41(n,m,J,rnd,ls,cs)
N=round(n/20);
M=round (m/20);
% n_new=15;
% m_new=10;
% white=round(m_new/2);
% black=mnew-white;
i=1;
    % [startingRow, startingColumn, endingRow, endingColumn]
    n_new=fix(N*rnd(1,3));
    m_new=fix(M*rnd(1,4));
%     sR=fix(1+(n-2*n_new)*rnd(1,1));
%     sC=fix(1+(m-2*m_new)*rnd(1,2));
    sR=1+fix(ls+n*rnd(1,1));
    sC=1+fix(cs+m*rnd(1,2));
    eR=sR+(fix(2*n_new/3));
    eC=sC+m_new;
    whiteSum1 = J(eR+1,eC+1) - J(eR+1,sC) - J(sR,eC+1) + J(sR,sC);
    sR=eR;
    eR=sR+(fix(2*n_new/3));
    blackSum = J(eR+1,eC+1) - J(eR+1,sC) - J(sR,eC+1) + J(sR,sC);
    sR=eR;
    eR=sR+fix(2*n_new/3);
    whiteSum2 = J(eR+1,eC+1) - J(eR+1,sC) - J(sR,eC+1) + J(sR,sC);
    
    x(1)=whiteSum1+whiteSum2-blackSum;
