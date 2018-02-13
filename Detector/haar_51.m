% function x=haar_5(n,m,J,rnd,n_new,m_new)
function x=haar_51(n,m,J,rnd,ls,cs)
N=round(n/20);
M=round (m/20);
% n_new=15;
% m_new=10;
% white=round(m_new/2);
% black=mnew-white;
i=1;
%   [startingRow, startingColumn, endingRow, endingColumn]
    n_new=fix(N*rnd(1,3));
    m_new=fix(M*rnd(1,4));
%     sR=fix(1+(n-2*n_new)*rnd(1,1));
%     sC=fix(1+(m-2*m_new)*rnd(1,2));
    sR=fix(ls+(n-2*n_new)*rnd(1,1));
    sC=fix(cs+(m-2*m_new)*rnd(1,2));
   if((sR + 2*n_new < (ls + n)) && (sC + 2*m_new < (cs + m)))
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
        x(1)=whiteSum1+whiteSum2-blackSum1-blackSum2;
   else
       x(1) = 0;
   end
