function [PY2,PY1,PX2,PX1]=caitu_tiqu(I,I_bai)
[y,x,z]=size(I);
myI=double(I);
Y_threshlow=5;%这个数值很重要。决定了提取的彩图的质量
X_firrectify=5;%ganrao transaction
%====================== Y 方向============================
Blue_y=zeros(y,1);
for i=1:y
    for j=1:x
        %  if (myI(i,j,1)<=48)&&(myI(i,j,2)>=40)&&(myI(i,j,2)<=90)&&(myI(i,j,3)<=220)&&(myI(i,j,3)>=80)    
        %  if((myI(i,j,1)<=48)&&((myI(i,j,2)<=100)&&(myI(i,j,2)>=40))&&((myI(i,j,3)<=200)&&(myI(i,j,3)>=80)))  
           if ((myI(i,j,1)<=0.7)&&(myI(i,j,1)>=0.6)&&((myI(i,j,2)<=1.8)&&(myI(i,j,2)>=0.6))&&((myI(i,j,3)<=1.7)&&(myI(i,j,3)>=0.4)))
           Blue_y(i,1)= Blue_y(i,1)+1;     % 蓝色象素点统计                    
        end  
    end       
end
baisebili=0;changkuanbi=0;
k=0;
while(~((baisebili>=0.12)&&(baisebili<=0.5)&&(changkuanbi>=0.20)&&(changkuanbi<=0.6)))%gai shan qingxie
    if  (k==0)%第一次进来
        [temp MaxY]=max(Blue_y);% Y方向车牌区域确定 temp(最多点数):所有行中，最多的累积像素点 MaxY（最多点所在行）:该行中蓝点最多
        if temp<=20%2048*1536  照相
           msgbox('车牌定位出错','warning');
           wavplay(wavread('车牌定位出错.wav'),22000);
           pause;
        end
        
        PY1=MaxY;%有最多蓝点的行付给PY1
        while ((Blue_y(PY1,1)>=Y_threshlow)&&(PY1>1))%找到图片上边界
            PY1=PY1-1;
        end 
       
        %PY1：存储车牌上边界值
        PY2=MaxY;
        while ((Blue_y(PY2,1)>=Y_threshlow)&&(PY2<y))%阈值为5
             PY2=PY2+1;
        end
        PY1, PY2
 
%==============X 方向===============================
        X_threshhigh=(PY2-PY1)/11;%这个数值很重要。决定了提取的彩图的质量,适当提高可抗干扰，但是小图会照成剪裁太多
        Blue_x=zeros(1,x);             % 进一步确定X方向的车牌区域
        for j=1:x
            for i=PY1:PY2
              %  if((myI(i,j,1)<=48)&&((myI(i,j,2)<=90)&&(myI(i,j,2)>=30))&&((myI(i,j,3)<=160)&&(myI(i,j,3)>=80)))      
              %  if((myI(i,j,1)<=65)&&((myI(i,j,2)<=100)&&(myI(i,j,2)>=40))&&((myI(i,j,3)<=160)&&(myI(i,j,3)>=90)))%这里由82修改成90.因为图片20090504809   
                 if ((myI(i,j,1)<=0.7)&&(myI(i,j,1)>=0.6)&&((myI(i,j,2)<=1.8)&&(myI(i,j,2)>=0.6))&&((myI(i,j,3)<=1.7)&&(myI(i,j,3)>=0.4)))
                 Blue_x(1,j)= Blue_x(1,j)+1;               
                end  
            end       
        end
        [temp MaxX]=max(Blue_x);
        PX1=MaxX-6*(PY2-PY1);
        if  PX1<=1
            PX1=1;
        end
        while ((Blue_x(1,PX1)<=X_threshhigh)&&(PX1<x))%阈值
              PX1=PX1+1;
        end %确定出X方向车牌起点   
        PX2=MaxX+6*(PY2-PY1);
        if  PX2>=x
            PX2=x;
        end
        while ((Blue_x(1,PX2)<=X_threshhigh)&&(PX2>PX1))%阈值
               PX2=PX2-1;
        end%确定出X方向车牌终点
        
%         PX1=1;
%         while ((Blue_x(1,PX1)<=X_threshhigh)&&(PX1<x))%阈值
%              PX1=PX1+1;
%         end %确定出X方向车牌起点   
%         PX2=x;
%         while ((Blue_x(1,PX2)<X_threshhigh)&&(PX2>PX1))%阈值
%             PX2=PX2-1;
%        end%确定出X方向车牌终点
        PX1 ,PX2

%=========================================================       
        a=PY2-PY1+1;b=PX2-PX1+1;
        White=0;
        for i=PY1:PY2
            for j=PX1:PX2
            if   (std([I_bai(i,j,1) I_bai(i,j,2) I_bai(i,j,3)],1,2)<=22)&&(I_bai(i,j,1)>=90)&&(I_bai(i,j,1)<=255)
                 White= White+1;    % 白色象素点统计                    
                end  
            end       
        end
        baisebili=White/(a*b)
        changkuanbi=a/b
        k=k+1
%===========================蓝色区域不是车牌区域=================
    elseif (k~=0)
        Blue_y(PY1:PY2,1)=0;
        
        [temp MaxY]=max(Blue_y);
        if temp<=20%2048*1536  照相
           msgbox('车牌定位出错','warning');
           wavplay(wavread('车牌定位出错.wav'),22000);
           pause;
        end
        PY1=MaxY;
        while ((Blue_y(PY1,1)>=Y_threshlow)&&(PY1>1))%找到图片上边界  %阈值为5
             PY1=PY1-1;
        end   
        %PY1：存储车牌上边界值
        PY2=MaxY;
        while ((Blue_y(PY2,1)>=Y_threshlow)&&(PY2<y))%阈值为5
        PY2=PY2+1;
        end
        PY1, PY2
%==============2次寻找X方向===============================
        X_threshhigh=(PY2-PY1)/15;%这个数值很重要。决定了提取的彩图的质量,适当提高可抗干扰，但是小图会照成剪裁太多,ganrao
        Blue_x=zeros(1,x);             % 进一步确定X方向的车牌区域
        for j=1:x
            for i=PY1:PY2
                %if((myI(i,j,1)<=45)&&((myI(i,j,2)<=90)&&(myI(i,j,2)>=20))&&((myI(i,j,3)<=160)&&(myI(i,j,3)>=80)))      
                if ((myI(i,j,1)<=0.7)&&(myI(i,j,1)>=0.6)&&((myI(i,j,2)<=1.8)&&(myI(i,j,2)>=0.6))&&((myI(i,j,3)<=1.7)&&(myI(i,j,3)>=0.4)))   
                Blue_x(1,j)= Blue_x(1,j)+1;               
                end  
            end       
        end
%这里修改成了从中间向两边扩展,这个方法不好。因车牌中间某些位置可能出现断层。
%采用增强型两边往中间收缩。
          [temp MaxX]=max(Blue_x);
          PX1=MaxX-6*(PY2-PY1);
          if  PX1<=1
              PX1=1;
          end          
          while ((Blue_x(1,PX1)<=X_threshhigh)&&(PX1<x))%阈值
                PX1=PX1+1;
          end %确定出X方向车牌起点   
          PX2=MaxX+6*(PY2-PY1);
          if  PX2>=x
              PX2=x;
          end
          while ((Blue_x(1,PX2)<=X_threshhigh)&&(PX2>PX1))%阈值
                PX2=PX2-1;
          end%确定出X方向车牌终点
%           PX1=1;
%           while ((Blue_x(1,PX1)<=X_threshhigh)&&(PX1<x))%阈值
%               PX1=PX1+1;
%           end
%           PX2=x;
%           while ((Blue_x(1,PX2)<X_threshhigh)&&(PX2>PX1))%阈值
%               PX2=PX2-1;
%           end
          PX1 ,PX2
%=========================================================       
        a=PY2-PY1+1;b=PX2-PX1+1;
        White=0;
        for i=PY1:PY2
            for j=PX1:PX2
                if   (std([I_bai(i,j,1) I_bai(i,j,2) I_bai(i,j,3)],1,2)<=16)&&(I_bai(i,j,1)>=90)&&(I_bai(i,j,1)<=255)
                    White= White+1;    % 白色象素点统计                    
                end  
            end       
        end        
        baisebili=White/(a*b)
        changkuanbi=a/b
        k=k+1        
    end
end

%========================================================
Y_firrectify=fix((PY2-PY1)/5);%适当扩大这个值可以正确旋转
PY1=PY1-Y_firrectify;%对车牌区域的修正,向上
PY2=PY2+Y_firrectify;%对车牌区域的修正,向下
% IY=I(PY1:PY2,:,:);%在Y方向对图片截取
PX1=PX1-X_firrectify;% 对车牌区域的修正
PX2=PX2+X_firrectify;% 对车牌区域的修正，