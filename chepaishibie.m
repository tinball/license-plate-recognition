function varargout = chepaishibie(varargin)
% CHEPAISHIBIE MATLAB code for chepaishibie.fig
%      CHEPAISHIBIE, by itself, creates a new CHEPAISHIBIE or raises the existing
%      singleton*.
%
%      H = CHEPAISHIBIE returns the handle to a new CHEPAISHIBIE or the handle to
%      the existing singleton*.
%
%      CHEPAISHIBIE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CHEPAISHIBIE.M with the given input arguments.
%
%      CHEPAISHIBIE('Property','Value',...) creates a new CHEPAISHIBIE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before chepaishibie_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to chepaishibie_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help chepaishibie

% Last Modified by GUIDE v2.5 20-Jun-2018 10:43:16

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @chepaishibie_OpeningFcn, ...
                   'gui_OutputFcn',  @chepaishibie_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before chepaishibie is made visible.
function chepaishibie_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to chepaishibie (see VARARGIN)

% Choose default command line output for chepaishibie
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes chepaishibie wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = chepaishibie_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[fn,pn,fi]=uigetfile('*.jpg','选择图片');
I=imread([pn fn]);
handles.I=I;
guidata(hObject, handles);
axes(handles.axes1);
image(I);
axis off;

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I=handles.I;
I_bai=I;
[PY2,PY1,PX2,PX1]=caitu_fenge(I);
%===============车牌区域根据面积二次修正======================
[PY2,PY1,PX2,PX1,threshold]=SEC_xiuzheng(PY2,PY1,PX2,PX1);
%==============更新图片=============================
Plate=I_bai(PY1:PY2,PX1:PX2,:);%使用caitu_tiqu
%==============考虑用腐蚀解决蓝色车问题=============
bw=Plate;
fid=figure('Name','车牌区域','menubar','none');
set(fid,'outerposition',[252 763 429 249]),imshow(bw);

handles.bw=bw;
handles.threshold=threshold;
guidata(hObject, handles);


% --- Executes on button press in pushbutton2.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
bw=handles.bw;
bw=rgb2gray(bw);%灰度图像

%================车牌校正======================
qingxiejiao=rando_bianhuan(bw)%计算倾斜角
bw=imrotate(bw,qingxiejiao,'bilinear','crop');
fid=figure('Name','车牌矫正','menubar','none');
set(fid,'outerposition',[252 510 429 249]),imshow(bw);%hsv彩图提取图像
%==============================================
handles.bw=bw;
handles.qingxiejiao=qingxiejiao;
guidata(hObject, handles);


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
bw=handles.bw;

bw=im2bw(bw,graythresh(bw));%graythresh(bw)使用最大类间方差法找到图片的一个合适的阈值，在使用im2bw函数将灰度图像转换为二值图像时，需要设定一个阈值
fid=figure('Name','二值化车牌','menubar','none');
set(fid,'outerposition',[252 250 429 249]),imshow(bw);%hsv彩图提取图像

handles.bw=bw;
guidata(hObject, handles);


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
bw=handles.bw;
threshold=handles.threshold;
%二值图像应用形态学操作
bw=bwmorph(bw,'hbreak',inf);%移除连通的像素
bw=bwmorph(bw,'spur',inf);%移除刺激（孤立）像素
bw=bwmorph(bw,'open',5);%先腐蚀后膨胀 figure,imshow(bw);title('闭合运算');
bw = bwareaopen(bw, threshold);%擦除小于阈值的对象

bw=~bw;%擦除反色 
%=============对图像进一步裁剪，保证边框贴近字体===========
bw=touying(bw);%Y方向处理
bw=~bw;
bw = bwareaopen(bw, threshold);
bw=~bw;%figure,imshow(bw);title('二次擦除');
fid=figure('Name','二值化图像处理','menubar','none');
set(fid,'outerposition',[252 0 429 249]),imshow(bw);

handles.bw=bw;
guidata(hObject, handles);


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
bw=handles.bw;
qingxiejiao=handles.qingxiejiao;

[y,x]=size(bw);%对长宽重新赋值
%=================文字分割=================================
fenge=shuzifenge(bw,qingxiejiao)
[m,k]=size(fenge);
%=================显示分割图像结果========================= 
fid=figure('Name','二值化图像处理','menubar','none');
set(fid,'outerposition',[680 150 429 249]),imshow(bw);%hsv彩图提取图像
for s=1:2:k-1
    subplot(1,k/2,(s+1)/2);imshow(bw( 1:y,fenge(s):fenge(s+1)));
end
handles.fenge=fenge;
guidata(hObject, handles);


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
bw=handles.bw;
[y,x]=size(bw);%对长宽重新赋值
fenge=handles.fenge;
%================ 给七张图片定位===============桂AV6388
han_zi  =bw( 1:y,fenge(1):fenge(2));
zi_mu   =bw( 1:y,fenge(3):fenge(4));
zm_sz_1 =bw( 1:y,fenge(5):fenge(6));
zm_sz_2 =bw( 1:y,fenge(7):fenge(8));  
shuzi_1 =bw( 1:y,fenge(9):fenge(10)); 
shuzi_2 =bw( 1:y,fenge(11):fenge(12)); 
shuzi_3 =bw( 1:y,fenge(13):fenge(14)); 
%==========================识别====================================
%======================把修正数据读入==============================
xiuzhenghanzi =   imresize(han_zi, [110 55],'bilinear');
xiuzhengzimu  =   imresize(zi_mu,  [110 55],'bilinear');
xiuzhengzm_sz_1=  imresize(zm_sz_1,[110 55],'bilinear');
xiuzhengzm_sz_2 = imresize(zm_sz_2,[110 55],'bilinear');
xiuzhengshuzi_1 = imresize(shuzi_1,[110 55],'bilinear');
xiuzhengshuzi_2 = imresize(shuzi_2,[110 55],'bilinear');
xiuzhengshuzi_3 = imresize(shuzi_3,[110 55],'bilinear');
%============ 把0-9 , A-Z以及省份简称的数据存储方便访问====================
hanzishengfen=duquhanzi(imread('cpgui.bmp'),imread('cpguizhou.bmp'),imread('cpjing.bmp'),imread('cpsu.bmp'),imread('cpyue.bmp'));
%因数字和字母比例不同。这里要修改
shuzizimu=duquszzm(imread('0.bmp'),imread('1.bmp'),imread('2.bmp'),imread('3.bmp'),imread('4.bmp'),...
                   imread('5.bmp'),imread('6.bmp'),imread('7.bmp'),imread('8.bmp'),imread('9.bmp'),...
                   imread('10.bmp'),imread('11.bmp'),imread('12.bmp'),imread('13.bmp'),imread('14.bmp'),...
                   imread('15.bmp'),imread('16.bmp'),imread('17.bmp'),imread('18.bmp'),imread('19.bmp'),...
                   imread('20.bmp'),imread('21.bmp'),imread('22.bmp'),imread('23.bmp'),imread('24.bmp'),...
                   imread('25.bmp'),imread('26.bmp'),imread('27.bmp'),imread('28.bmp'),imread('29.bmp'),...
                   imread('30.bmp'),imread('31.bmp'),imread('32.bmp'),imread('33.bmp'));
zimu  = duquzimu(imread('10.bmp'),imread('11.bmp'),imread('12.bmp'),imread('13.bmp'),imread('14.bmp'),...
                 imread('15.bmp'),imread('16.bmp'),imread('17.bmp'),imread('18.bmp'),imread('19.bmp'),...
                 imread('20.bmp'),imread('21.bmp'),imread('22.bmp'),imread('23.bmp'),imread('24.bmp'),...
                 imread('25.bmp'),imread('26.bmp'),imread('27.bmp'),imread('28.bmp'),imread('29.bmp'),...
                 imread('30.bmp'),imread('31.bmp'),imread('32.bmp'),imread('33.bmp'));
shuzi = duqushuzi(imread('0.bmp'),imread('1.bmp'),imread('2.bmp'),imread('3.bmp'),imread('4.bmp'),...
                 imread('5.bmp'),imread('6.bmp'),imread('7.bmp'),imread('8.bmp'),imread('9.bmp')); 
%============================识别结果================================  
i=1;%shibiezm_sz该函数识别数字有问题
jieguohanzi  = shibiehanzi(hanzishengfen,xiuzhenghanzi);shibiejieguo(1,i) =jieguohanzi;  i=i+1;
jieguozimu   = shibiezimu(zimu,xiuzhengzimu);           shibiejieguo(1,i) =jieguozimu;   i=i+1;
jieguozm_sz_1= shibiezm_sz(shuzizimu,xiuzhengzm_sz_1);  shibiejieguo(1,i) =jieguozm_sz_1;i=i+1;
jieguozm_sz_2= shibiezm_sz(shuzizimu,xiuzhengzm_sz_2);  shibiejieguo(1,i) =jieguozm_sz_2;i=i+1;
jieguoshuzi_1= shibieshuzi(shuzi,xiuzhengshuzi_1);      shibiejieguo(1,i) =jieguoshuzi_1;i=i+1;
jieguoshuzi_2= shibieshuzi(shuzi,xiuzhengshuzi_2);      shibiejieguo(1,i) =jieguoshuzi_2;i=i+1;
jieguoshuzi_3= shibieshuzi(shuzi,xiuzhengshuzi_3);      shibiejieguo(1,i) =jieguoshuzi_3;i=i+1;
%==========================对话框显示识别结果=============================================
h=msgbox(shibiejieguo,'识别结果');  
% 修改字体  
ah = get( h, 'CurrentAxes' );  
ch = get( ah, 'Children' );  
set( ch, 'FontSize', 60 );  
set(h,'Position',[900 150 300 100]);% 使用这个语句可以修改msgbox的位置和大小 



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I=handles.I;
I_bai=I;
[PY2,PY1,PX2,PX1]=caitu_fenge(I);
%===============车牌区域根据面积二次修正======================
[PY2,PY1,PX2,PX1,threshold]=SEC_xiuzheng(PY2,PY1,PX2,PX1);
%==============更新图片=============================
Plate=I_bai(PY1:PY2,PX1:PX2,:);%使用caitu_tiqu
%==============考虑用腐蚀解决蓝色车问题=============
bw=Plate;
axes(handles.axes2);image(bw);axis off;%车牌区域

bw=rgb2gray(bw);%灰度图像
%================倾斜校正======================
qingxiejiao=rando_bianhuan(bw)
bw=imrotate(bw,qingxiejiao,'bilinear','crop');%取值为负值向右旋转
%==============================================
bw=im2bw(bw,graythresh(bw));%figure,imshow(bw);
bw=bwmorph(bw,'hbreak',inf);%figure,imshow(bw);
bw=bwmorph(bw,'spur',inf);%figure,imshow(bw);title('擦除之前');
bw=bwmorph(bw,'open',5);%figure,imshow(bw);title('闭合运算');
bw = bwareaopen(bw, threshold);%擦除

bw=~bw;%擦除反色 
%=============对图像进一步裁剪，保证边框贴近字体===========
bw=touying(bw);%Y方向处理
bw=~bw;
bw = bwareaopen(bw, threshold);
bw=~bw;%figure,imshow(bw);title('二次擦除');
[y,x]=size(bw);%对长宽重新赋值
%=================文字分割=================================
fenge=shuzifenge(bw,qingxiejiao)
[m,k]=size(fenge);
%=================显示分割图像结果========================= 
axes(handles.axes3);imshow(bw( 1:y,fenge(1):fenge(2)));
axes(handles.axes4);imshow(bw( 1:y,fenge(3):fenge(4)));
axes(handles.axes5);imshow(bw( 1:y,fenge(5):fenge(6)));
axes(handles.axes6);imshow(bw( 1:y,fenge(7):fenge(8)));
axes(handles.axes7);imshow(bw( 1:y,fenge(9):fenge(10)));
axes(handles.axes8);imshow(bw( 1:y,fenge(11):fenge(12)));
axes(handles.axes9);imshow(bw( 1:y,fenge(13):fenge(14)));

%================ 给七张图片定位===============桂AV6388
han_zi  =bw( 1:y,fenge(1):fenge(2));
zi_mu   =bw( 1:y,fenge(3):fenge(4));
zm_sz_1 =bw( 1:y,fenge(5):fenge(6));
zm_sz_2 =bw( 1:y,fenge(7):fenge(8));  
shuzi_1 =bw( 1:y,fenge(9):fenge(10)); 
shuzi_2 =bw( 1:y,fenge(11):fenge(12)); 
shuzi_3 =bw( 1:y,fenge(13):fenge(14)); 
%==========================识别====================================
%======================把修正数据读入==============================
xiuzhenghanzi =   imresize(han_zi, [110 55],'bilinear');
xiuzhengzimu  =   imresize(zi_mu,  [110 55],'bilinear');
xiuzhengzm_sz_1=  imresize(zm_sz_1,[110 55],'bilinear');
xiuzhengzm_sz_2 = imresize(zm_sz_2,[110 55],'bilinear');
xiuzhengshuzi_1 = imresize(shuzi_1,[110 55],'bilinear');
xiuzhengshuzi_2 = imresize(shuzi_2,[110 55],'bilinear');
xiuzhengshuzi_3 = imresize(shuzi_3,[110 55],'bilinear');
%============ 把0-9 , A-Z以及省份简称的数据存储方便访问====================
hanzishengfen=duquhanzi(imread('cpgui.bmp'),imread('cpguizhou.bmp'),imread('cpjing.bmp'),imread('cpsu.bmp'),imread('cpyue.bmp'));
%因数字和字母比例不同。这里要修改
shuzizimu=duquszzm(imread('0.bmp'),imread('1.bmp'),imread('2.bmp'),imread('3.bmp'),imread('4.bmp'),...
                   imread('5.bmp'),imread('6.bmp'),imread('7.bmp'),imread('8.bmp'),imread('9.bmp'),...
                   imread('10.bmp'),imread('11.bmp'),imread('12.bmp'),imread('13.bmp'),imread('14.bmp'),...
                   imread('15.bmp'),imread('16.bmp'),imread('17.bmp'),imread('18.bmp'),imread('19.bmp'),...
                   imread('20.bmp'),imread('21.bmp'),imread('22.bmp'),imread('23.bmp'),imread('24.bmp'),...
                   imread('25.bmp'),imread('26.bmp'),imread('27.bmp'),imread('28.bmp'),imread('29.bmp'),...
                   imread('30.bmp'),imread('31.bmp'),imread('32.bmp'),imread('33.bmp'));
zimu  = duquzimu(imread('10.bmp'),imread('11.bmp'),imread('12.bmp'),imread('13.bmp'),imread('14.bmp'),...
                 imread('15.bmp'),imread('16.bmp'),imread('17.bmp'),imread('18.bmp'),imread('19.bmp'),...
                 imread('20.bmp'),imread('21.bmp'),imread('22.bmp'),imread('23.bmp'),imread('24.bmp'),...
                 imread('25.bmp'),imread('26.bmp'),imread('27.bmp'),imread('28.bmp'),imread('29.bmp'),...
                 imread('30.bmp'),imread('31.bmp'),imread('32.bmp'),imread('33.bmp'));
shuzi = duqushuzi(imread('0.bmp'),imread('1.bmp'),imread('2.bmp'),imread('3.bmp'),imread('4.bmp'),...
                 imread('5.bmp'),imread('6.bmp'),imread('7.bmp'),imread('8.bmp'),imread('9.bmp')); 
%============================识别结果================================  
i=1;%shibiezm_sz该函数识别数字有问题
jieguohanzi  = shibiehanzi(hanzishengfen,xiuzhenghanzi);shibiejieguo(1,i) =jieguohanzi;  i=i+1;
jieguozimu   = shibiezimu(zimu,xiuzhengzimu);           shibiejieguo(1,i) =jieguozimu;   i=i+1;
jieguozm_sz_1= shibiezm_sz(shuzizimu,xiuzhengzm_sz_1);  shibiejieguo(1,i) =jieguozm_sz_1;i=i+1;
jieguozm_sz_2= shibiezm_sz(shuzizimu,xiuzhengzm_sz_2);  shibiejieguo(1,i) =jieguozm_sz_2;i=i+1;
jieguoshuzi_1= shibieshuzi(shuzi,xiuzhengshuzi_1);      shibiejieguo(1,i) =jieguoshuzi_1;i=i+1;
jieguoshuzi_2= shibieshuzi(shuzi,xiuzhengshuzi_2);      shibiejieguo(1,i) =jieguoshuzi_2;i=i+1;
jieguoshuzi_3= shibieshuzi(shuzi,xiuzhengshuzi_3);      shibiejieguo(1,i) =jieguoshuzi_3;i=i+1;

set(handles.edit1,'string',num2str(shibiejieguo));
duchushengyin(shibiejieguo);
%=====================存储数据==================
fid=fopen('text.txt','a+');
fprintf(fid,'%s\r\n',shibiejieguo,datestr(now));
fclose(fid);
% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
open('text.txt');

% --- Executes during object creation, after setting all properties.
function axes3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes3


% --- Executes when uipanel1 is resized.
function uipanel1_SizeChangedFcn(hObject, eventdata, handles)
% hObject    handle to uipanel1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

