function [PY2,PY1,PX2,PX1,threshold]=SEC_xiuzheng(PY2,PY1,PX2,PX1)
 
S=(PY2-PY1)*(PX2-PX1)
if       S<=25000
    threshold=50;
    Y_secrectify=3;
    X_secrectify=3;
elseif S>25000&&S<=45000  
    threshold=100;
    Y_secrectify=-3;
    X_secrectify=3;
elseif S>45000&&S<=80000
    threshold=200;
    Y_secrectify=-3;
    X_secrectify=3;
elseif S>80000&&S<=150000
    threshold=300;
    Y_secrectify=-10;
    X_secrectify=-10;
elseif S>150000&&S<=400000
    threshold=600;
    Y_secrectify=-10;
    X_secrectify=-10;
else
    threshold=1800;
    Y_secrectify=-10;
    X_secrectify=-10;
end
PY1=PY1-Y_secrectify;%对车牌区域的进一步修正
PY2=PY2+Y_secrectify;%对车牌区域的进一步修正
PX1=PX1;%-X_secrectify;%对车牌区域的进一步修正
PX2=PX2;%+X_secrectify;%对车牌区域的进一步修正