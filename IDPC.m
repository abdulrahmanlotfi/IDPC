function Label=IDPC(X,Labeled,peaks,rho,neigh,n,k)
    nPeak=size(peaks,1);
    nL=size(Labeled,1);
    Lab=[];
    Label=Labeled;
    %________________________________________________________________Voting
    for i=1:randsample(n,n);
        if(Label(i,1)==0)
            for j=1:k
                if(rho(i)<rho(neigh(i,j)) && Label(neigh(i,j))~=0)
                    Lab(end+1)=Label(neigh(i,j),1);
                end;
            end;
            if(isempty(Lab))
                Label(i)=0;
            else
                [uv,~,idx] = unique(Lab);
                H = accumarray(Lab(:),1);
                [Z1,vot]=max(H);
                Label(i)=vot;
                Lab=[];
            end;
        end;
    end;
    %_____________________________________________________Assign to Remains
    dis=zeros(1,nPeak);
    for i=1:n
        if(Label(i)==0)
            for j=1:nPeak
                dis(1,j)=pdist2(X(i,:),X(peaks(j),:));
            end;
            [a,b]=min(dis);
            Label(i)=b;
        end;
    end;
end