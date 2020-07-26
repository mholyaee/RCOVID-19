function [serix,seriy,pic]=CGR_Genome(str)
tsShow=0;
l=length(str);
prex=0.5;prey=0.5;
serix=0;seriy=0;str;j=1;
flag=0;
for i=1:l
    ttt=str(i);
    x=-1;counter=0;
    if str(i)=='A' || str(i)=='N'
        if str(i)=='N'
            flag=1;
        end
        x=(prex)/2;
        if prex==0
            prex=0.0001;
        end
        y=(prey/prex)*x;
        serix(j)=x;seriy(j)=y;
        prex=x;prey=y;
        j=j+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    elseif str(i)=='C'
        x=prex/2;
        if prex==0
            prex=0.0001;
        end
        y=1+(prey-1)/(prex)*(x);
        serix(j)=x;seriy(j)=y;
        prex=x;prey=y;
        j=j+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    elseif str(i)=='G'
        x=(prex+1)/2;
        if prex==1
            prex=0.9999;
        end
        y=1+(prey-1)/(prex-1)*(x-1);
        serix(j)=x;seriy(j)=y;
        prex=x;prey=y;
        j=j+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    elseif str(i)=='T'
        x=(prex+1)/2;
        if prex==1
            prex=0.9999;
        end
        y=(prey)/(prex-1)*(x-1);
        serix(j)=x;seriy(j)=y;
        prex=x;prey=y;
        j=j+1;
    end
end
pic=figure('visible','off');plot(serix,seriy,'rs','LineWidth',1,...
    'MarkerEdgeColor','k',...
    'MarkerFaceColor','g',...
    'MarkerSize',1);xlabel('x');ylabel('y');
if tsShow==1
    figure;plot(serix,'-s','LineWidth',1,...
        'MarkerEdgeColor','k',...
        'MarkerFaceColor','g',...
        'MarkerSize',2);xlabel('Position');ylabel('CGRX');xlim([1 1000]);
    figure;plot(seriy,'-s','LineWidth',1,...
        'MarkerEdgeColor','k',...
        'MarkerFaceColor','g',...
        'MarkerSize',2);xlabel('Position');ylabel('CGRY');xlim([1 1000])
end




