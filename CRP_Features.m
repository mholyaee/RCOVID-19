function temp=CRP_Features(seri,m,tou,EPS)
flag=0;
nFeature=9;
temp=zeros(1,nFeature);
if m==-1
    temp(1,:)=-1;
else
    temp=crqa(seri,m,tou,EPS);%EPS=1
    if isempty(temp)    
        temp=ones(1,nFeature)*(-1);
    else
        if flag==1
            RP=crp(seri,m,tou,EPS,'euclidean');
            crp(seri,m,tou,EPS,'euclidean');
        end
       Selected=[temp(1:8),temp(12)];
       temp=Selected;
    end

end
end