function fenge = shuzifenge(imfenge,qingxiejiao)
[y,x]=size(imfenge);
%===============�ú����趨�ָ���ֵ========================
SS=x*y
if     SS<=20000
    shedingyuzhi=4; %�趨��ֵ
    
elseif SS>20000&&SS<=30000
    shedingyuzhi=4;
elseif SS>30000&&SS<=50000
    shedingyuzhi=4;
    
elseif SS>50000&&SS<=80000
    shedingyuzhi=4;
    
else
    shedingyuzhi=4;
    
end
ganrao=SS/100;  %�趨������ֵ
%=========================================================
%��������histogram�洢��ֱ����ĺڵ���
histogram=sum(~imfenge);
%=================���ַָ�=============================
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
k=k-1;%ȥ���������һ��Kֵ
if  k<10
    msgbox('��ȡ����','����');
    wavplay(wavread('��ȡ����.wav'),22000);
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
    msgbox('��ȡ����','����');
    wavplay(wavread('��ȡ����.wav'),22000);
    pause;
end
fenge=fenge(1,1:14);
