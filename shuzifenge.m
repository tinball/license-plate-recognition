function fenge = shuzifenge(imfenge,qingxiejiao)
[y,x]=size(imfenge);
%===============用函数设定分割阈值========================
SS=x*y
if     SS<=20000
    shedingyuzhi=4; %设定阈值
    
elseif SS>20000&&SS<=30000
    shedingyuzhi=4;
elseif SS>30000&&SS<=50000
    shedingyuzhi=4;
    
elseif SS>50000&&SS<=80000
    shedingyuzhi=4;
    
else
    shedingyuzhi=4;
    
end
ganrao=SS/100;  %设定干扰数值
%=========================================================
%定义数组histogram存储垂直方向的黑点数
histogram=sum(~imfenge);
%=================文字分割=============================
k=1;
for h=1:x-1
    if  ((histogram(1,h)<=shedingyuzhi)&&(histogram(1,h+1)>shedingyuzhi))||((h==1)&&histogram(1,h)>shedingyuzhi)
        fenge(1,k)=h;
        k=k+1;
    elseif ((histogram(1,h)>shedingyuzhi)&&(histogram(1,h+1)<=shedingyuzhi))||((h==x-1)&&histogram(1,h)>shedingyuzhi)
        fenge(1,k)=h+1;
        k=k+1;
    end
end
k=k-1;%去掉多产生的一个K值
if  k<10
    msgbox('提取出错','警告');
    wavplay(wavread('提取出错.wav'),22000);
    pause;
end
%==============================================
if (sum(histogram(1,fenge(1,1):fenge(1,2)))<ganrao)||((fenge(1,2)-fenge(1,1))<(fenge(1,4)-fenge(1,3))/2)
    for i=3:k
        fenge(1,i-2)=fenge(1,i);
    end
end
[m n]=size(fenge);
if  n<14
    msgbox('提取出错','警告');
    wavplay(wavread('提取出错.wav'),22000);
    pause;
end
fenge=fenge(1,1:14);
