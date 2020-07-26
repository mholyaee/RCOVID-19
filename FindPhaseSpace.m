function [m,tou,lens]=FindPhaseSpace(seri)
Length_THRS=10;
Type_TAU='mi';
Type_m='fnn';
tou_min=1;
tou_max=20;
Mmax=12; 
if length(seri)>=Length_THRS
    if strcmp(Type_TAU,'mi')
        tou=mi(seri,10,100);
        tou = squeeze(tou(1,1,:));
        tou=find(diff(tou) > 0, 1);
        check=1;
        if tou>5 && length(seri)<100
            tou=tou_min;
            check=2;
        end
    else
        tou=Select_Delay_time(seri);check=6;
    end
    if tou>tou_max
        tou=tou_max;
    end
    lens=length(seri);
    dr=(Mmax-1)*tou;    
    while dr>lens
        Mmax=Mmax-1;  dr=(Mmax-1)*tou;  end
    if strcmp(Type_m,'fnn')              %Type of embedding dimension method
        out=fnn(seri,Mmax,tou);
        %Determine m
        if isnan(out)                     %If fnn had error we set m=-1
            m=-1
        else
            error=0.001;
            m=find(out<=error,1);
            [c1,~]=size(m);
            itr=1;
            while c1==0 && itr<=10
                error=error+0.001; m=find(out<=error, 1);[c1,~]=size(m);
                itr=itr+1;
            end
            if itr>10
                m=-1;
            end
        end
    else
        m=embedding_dimension(seri,tou);
    end
else
    m=-1;
end

