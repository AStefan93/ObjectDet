function x=haar_11(n,m,J,rnd,ls,cs)
%n - linii
%m - coloane
%J - imaginea integrala
%N,M noile dimensiuni ale mastii
N=round(n/20)-1;
M=round(m/20)-1;
% white=round(m_new/2);
% black=mnew-white;
%i=1;
    % [startingRow, startingColumn, endingRow, endingColumn]
    n_new=fix(N*rnd(1,3));
    m_new=fix(M*rnd(1,4));
%     if(n_new == 0)
%         n_new = 1;
%     end
%     if(m_new == 0)
%         m_new = 1;
%     end
    sR=fix(ls+(n-2*n_new)*rnd(1,1));
    sC=fix(cs+(m-2*m_new)*rnd(1,2));
    if((sR + 2*n_new < (ls + n)) && (sC + 2*m_new < (cs + m)))
        eR=sR+2*n_new;
        eC=sC+m_new;
        whiteSum = J(eR+1,eC+1) - J(eR+1,sC) - J(sR,eC+1) + J(sR,sC);
        sC=eC;
        eC=sC+m_new ;
        blackSum = J(eR+1,eC+1) - J(eR+1,sC) - J(sR,eC+1) + J(sR,sC);
        x(1)=whiteSum-blackSum;
    else
        x(1) = 0;
    end
