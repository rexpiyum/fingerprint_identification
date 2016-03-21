function varargout = UI(varargin)
% UI MATLAB code for UI.fig
%      UI, by itself, creates a new UI or raises the existing
%      singleton*.
%
%      H = UI returns the handle to a new UI or the handle to
%      the existing singleton*.
%
%      UI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UI.M with the given input arguments.
%
%      UI('Property','Value',...) creates a new UI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before UI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to UI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help UI

% Last Modified by GUIDE v2.5 28-Aug-2012 23:51:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @UI_OpeningFcn, ...
    'gui_OutputFcn',  @UI_OutputFcn, ...
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


% --- Executes just before UI is made visible.
function UI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to UI (see VARARGIN)

% Choose default command line output for UI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes UI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = UI_OutputFcn(hObject, eventdata, handles)
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



load('imgRGB'); % get the original images
load('K'); % skelatonized image
load('I5');
load('I1');
load('CentroidTermR');
load('CentroidBifR');

handles.K = K;
handles.I1 = I1;
handles.imgRGB = imgRGB;
handles.TR = CentroidTermR;
handles.BR = CentroidBifR;


D1 = str2num(get(handles.disTB,'String'));
D2 = str2num(get(handles.disBB,'String'));
D3 = str2num(get(handles.disTT,'String'));
D4 = str2num(get(handles.disTTA,'String'));
b = str2num(get(handles.bor,'String'));
w = str2num(get(handles.win,'String'));
angle = str2num(get(handles.ang,'String'));
gradientsigma = 1 %str2num(get(handles.gradSigma,'String'));
blocksigma = 10 %str2num(get(handles.bSize,'String'));


H = fspecial('disk',50);
blurred = imfilter(I5,H,'replicate');
I5B = ~(blurred<0.62)+~K;
K1 = bwlabel(I5B);
%%

%% Mark minutie
fun=@minutia;
L = nlfilter(K,[3 3],fun);
%%

%% Extract minutia points
% Terminations
[i,j] = find(L==1);
Termination = [j,i];
% Bifurcation
[i,j] = find(L==3);
Bifurcation = [j,i];

handles.T0 = Termination;
handles.B0 = Bifurcation;

%%

%% Remove terminations & bifurications found in the border of the image
% K, b, Termination, Bifurcation

s = size(Termination);
imsize = size(K);
h = waitbar(0,'Remove terminations found in the border');
for k = 1:s(1)
    waitbar(k/s(1));
    if (Termination(k,1)<(b+1))||(Termination(k,2)<(b+1))||(Termination(k,2)>imsize(1)-(b+1))||(Termination(k,1)>imsize(2)-(b+1))
        Termination(k,:) = 0;
    end
end
close(h);

s = size(Bifurcation);
h = waitbar(0,'Remove bifurcation found in the border');
for k = 1:s(1)
    waitbar(k/s(1));
    if (Bifurcation(k,1)<(b+1))||(Bifurcation(k,2)<(b+1))||(Bifurcation(k,2)>imsize(1)-(b+1))||(Bifurcation(k,1)>imsize(2)-(b+1))
        Bifurcation(k,:) = 0;
    end
end
close(h);

[i,j] = find(Termination == 0);
Termination(i,:) = [];
[i,j] = find(Bifurcation == 0);
Bifurcation(i,:) = [];





%%

%% Calculate the gradinat of every point
% Termination(k,3) - Angle
% Termination(k,4) - Line number
% Termination(k,5) - number of pixels
%

f = fspecial('gaussian',3, 1);
[fx,fy] = gradient(f);

% s = size(Termination);
% for k = 1:s(1)
%     Termination(k,3) = K1(Termination(k,2),Termination(k,1));
%     Gx = filter2(fx, K1==Termination(k,4));
%     Gy = filter2(fy, K1==Termination(k,4));
%     Grad = atan2(Gy,Gx);
%     Termination(k,4) = Grad(Termination(k,2),Termination(k,1));
% end

h = waitbar(0,'Calculate angles of terminations');
s = size(Termination);
for k = 1:s(1)
    waitbar(k/s(1));
    W = K1(Termination(k,2)-w:Termination(k,2)+w,Termination(k,1)-w:Termination(k,1)+w);
    Termination(k,3) = K1(Termination(k,2),Termination(k,1));
    Termination(k,4) = atan2(length(find(sum(W==K1(Termination(k,2),Termination(k,1)),2))),length(find(sum(W==K1(Termination(k,2),Termination(k,1)),1))));
    Termination(k,5) = sum(sum(K1 == (Termination(k,3))));
end
close(h);

% Bifurcation(k,3) - Angle
% Bifurcation(k,4) - Line number
% Bifurcation(k,5) - number of pixels

h = waitbar(0,'Calculate angles of bifurcation');
s = size(Bifurcation);
for k = 1:s(1)
    waitbar(k/s(1));
    Bifurcation(k,3) = K1(Bifurcation(k,2),Bifurcation(k,1));
    Gx = filter2(fx, K1==Bifurcation(k,3));
    Gy = filter2(fy, K1==Bifurcation(k,3));
    Grad = atan2(Gy,Gx);
    Bifurcation(k,4) = Grad(Bifurcation(k,2),Bifurcation(k,1));
    Bifurcation(k,5) = sum(sum(K1 == (Bifurcation(k,3))));
end
close(h);
%%

%%
%

s = size(Termination);
m1 = s(1);
m2 = m1;

G = zeros(m1,m2);
G1= zeros(m1,m2);

Distance = distanceCalcB(Termination);
h = waitbar(0,'Remove terminations due to breaked lines');
Termination(:,6) = 1;
for i=1:m1
    waitbar(i/m1);
    for j=1:m2
        if i==j
            G(i,j)=NaN;
        else
            G(i,j)=atan2(abs(Termination(i,2)-Termination(j,2)), abs(Termination(i,1)-Termination(j,1)));
            %if(Termination(i,5)>w/3 && Termination(j,5)>w/3)
            if((((G(i,j)<Termination(i,4)+angle)&&(G(i,j)>Termination(i,4)-angle))||((G(i,j)<Termination(j,4)+angle)&&(G(i,j)>Termination(j,4)-angle)))&&(Distance(i,j)<D4))
                Termination(i,6) = 0;
                Termination(j,6) = 0;
            end
            %end
        end
    end
end
close(h);

[i,j] = find(Termination (:,6) == 0);

Termination(i,:) = [];


handles.T1 = Termination;
handles.B1 = Bifurcation;

%%

%% Remove small noise terminations found in the image
% w = 40;
%%%%%%%%%%%%%%%%%
K1 = bwlabel(K);
s = size(Termination);
h = waitbar(0,'Remove terminations due to noise');
for k = 1:s(1)
    waitbar(k/s(1));
    W = K1(Termination(k,2)-w:Termination(k,2)+w,Termination(k,1)-w:Termination(k,1)+w);
    if (length(find(sum(W==K1(Termination(k,2),Termination(k,1)),1)))<w&&length(find(sum(W==K1(Termination(k,2),Termination(k,1)),2)))<w)
        Termination(k,6) = 0;
        %     else
        %         CentroidTerm(k,3) = atan2(length(find(sum(W==K1(CentroidTerm(k,2),CentroidTerm(k,1)),2))),length(find(sum(W==K1(CentroidTerm(k,2),CentroidTerm(k,1)),1))));
    end
end
close(h);
[i,j] = find(Termination (:,6)== 0);
Termination(i,:) = [];

handles.T2 = Termination;
handles.B2 = Bifurcation;
%%

%% Remove close terminations
% D3 = 25;
%%%%%%%%%%%%%%%%
Distance=distanceCalcT(Termination);
SpuriousMinutae=Distance<D3;
[i,j]=find(SpuriousMinutae);
Termination(i,:)=[];
title1 = ['After removal of adjucent points (ter) (considering distance only) | Distance = ', int2str(D3)];


%%

%% Remove close terminations and bifurcation
% D1 = 30;
Distance=distanceCalcTB(Bifurcation,Termination);
SpuriousMinutae=Distance<D1;
[i,j]=find(SpuriousMinutae);
Bifurcation(i,:)=[];
Termination(j,:)=[];
title1 = ['After removal of adjucent points (bi & ter) (considering distance only) | Distance = ', int2str(D1)];


%%

%% Remove close bifurcation
%D2 = 30;
Distance=distanceCalcB(Bifurcation);
SpuriousMinutae=Distance<D2;
[i,j]=find(SpuriousMinutae);
Bifurcation(i,:)=[];
title1 = ['After removal of adjucent points (bi) (considering distance only) | Distance = ', int2str(D2)];

handles.T3 = Termination;
handles.B3 = Bifurcation;

%% create mask and remove unwanted minutiae

[i,j] = find(blurred<0.62);
A = [j,i];
A(:,3:4) = 0;
Bifurcation = intersect(Bifurcation(:,1:2),A(:,1:2),'rows');
Termination = intersect(Termination(:,1:2),A(:,1:2),'rows');

handles.T4 = Termination;
handles.B4 = Bifurcation;


%%


[C,D]=quadrentGradiant(I1,gradientsigma, blocksigma);
handles.C = C;
handles.D = D;
% figure, imshow(I);figure, imshow(C);figure, imshow(D);
num=2;

[maxD,ridnumD]=maxLength(D,num);
[maxC,ridnumC]=maxLength(C,num);
SP= quadrentSPs(maxD,maxC);
O1=size(find(SP==1));
O2=0;SP1=SP;
O3=0;SP2=SP;
if O1(1)>3
    num=1;
    if(ridnumD(1)==2)
        [maxD1,ridnumD]=maxLength(D,num);
        [SP1,A1]= quadrentSPs(maxD1,maxC);
    end
    O2=size(find(SP1==1));
end


if O1(1)>3
    num=1;
    if(ridnumC(1)==2)
        [maxC1,ridnumC]=maxLength(C,num);
        [SP2,A2]= quadrentSPs(maxD,maxC1);
    end
    O3=size(find(SP1==1));
end


if(O2(1)>=O3(1))
    SP=SP2;
    A=A2;
else
    SP=SP1;
    A=A1;
end
handles.A = A;
%     figure, imshow(A);
[x,y]=find(SP~=0);
handles.Points = [x,y];
%     figure, imshow(I);hold on;
%     for i=1:size(x)
%         plot(y(i),x(i),'ro','LineWidth',3);
%     end

[P,theta,gradAll]=PrimarySP(I1,SP,40)

% handles.theta = theta
% set(handles.oangle, 'String', handles.theta);


plotValues(hObject, eventdata, handles);
guidata(hObject, handles);



function disTB_Callback(hObject, eventdata, handles)
% hObject    handle to disTB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disTB as text
%        str2double(get(hObject,'String')) returns contents of disTB as a double


% --- Executes during object creation, after setting all properties.
function disTB_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disTB (see GCBO)
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



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function win_Callback(hObject, eventdata, handles)
% hObject    handle to win (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of win as text
%        str2double(get(hObject,'String')) returns contents of win as a double


% --- Executes during object creation, after setting all properties.
function win_CreateFcn(hObject, eventdata, handles)
% hObject    handle to win (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function bor_Callback(hObject, eventdata, handles)
% hObject    handle to bor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of bor as text
%        str2double(get(hObject,'String')) returns contents of bor as a double


% --- Executes during object creation, after setting all properties.
function bor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit20_Callback(hObject, eventdata, handles)
% hObject    handle to edit20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit20 as text
%        str2double(get(hObject,'String')) returns contents of edit20 as a double


% --- Executes during object creation, after setting all properties.
function edit20_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function disTTA_Callback(hObject, eventdata, handles)
% hObject    handle to disTTA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disTTA as text
%        str2double(get(hObject,'String')) returns contents of disTTA as a double


% --- Executes during object creation, after setting all properties.
function disTTA_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disTTA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function disTT_Callback(hObject, eventdata, handles)
% hObject    handle to disTT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disTT as text
%        str2double(get(hObject,'String')) returns contents of disTT as a double


% --- Executes during object creation, after setting all properties.
function disTT_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disTT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function disBB_Callback(hObject, eventdata, handles)
% hObject    handle to disBB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disBB as text
%        str2double(get(hObject,'String')) returns contents of disBB as a double


% --- Executes during object creation, after setting all properties.
function disBB_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disBB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit13_Callback(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit13 as text
%        str2double(get(hObject,'String')) returns contents of edit13 as a double


% --- Executes during object creation, after setting all properties.
function edit13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ang_Callback(hObject, eventdata, handles)
% hObject    handle to ang (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ang as text
%        str2double(get(hObject,'String')) returns contents of ang as a double


% --- Executes during object creation, after setting all properties.
function ang_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ang (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

imshow(~handles.K,'parent',handles.axes1);
hold on
plot(handles.T0(:,1),handles.T0(:,2),'bo')
plot(handles.B0(:,1),handles.B0(:,2),'rs')
val = get(handles.realcheckbox,'Value');

if(val == 1)
    plot(handles.TR(:,1),handles.TR(:,2),'go')
    plot(handles.BR(:,1),handles.BR(:,2),'gs')
end
hold off

guidata(hObject, handles);


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
imshow(~handles.K,'parent',handles.axes1);
hold on
plot(handles.T1(:,1),handles.T1(:,2),'bo')
plot(handles.B1(:,1),handles.B1(:,2),'rs')
val = get(handles.realcheckbox,'Value');

if(val == 1)
    plot(handles.TR(:,1),handles.TR(:,2),'go')
    plot(handles.BR(:,1),handles.BR(:,2),'gs')
end
hold off

guidata(hObject, handles);



% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
imshow(~handles.K,'parent',handles.axes1);
hold on
plot(handles.T2(:,1),handles.T2(:,2),'bo')
plot(handles.B2(:,1),handles.B2(:,2),'rs')
val = get(handles.realcheckbox,'Value');

if(val == 1)
    plot(handles.TR(:,1),handles.TR(:,2),'go')
    plot(handles.BR(:,1),handles.BR(:,2),'gs')
end
hold off

guidata(hObject, handles);


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
imshow(~handles.K,'parent',handles.axes1);
hold on
plot(handles.T3(:,1),handles.T3(:,2),'bo')
plot(handles.B3(:,1),handles.B3(:,2),'rs')
val = get(handles.realcheckbox,'Value');

if(val == 1)
    plot(handles.TR(:,1),handles.TR(:,2),'go')
    plot(handles.BR(:,1),handles.BR(:,2),'gs')
end
hold off

guidata(hObject, handles);



% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
imshow(~handles.K,'parent',handles.axes1);
hold on
plot(handles.T4(:,1),handles.T4(:,2),'bo')
plot(handles.B4(:,1),handles.B4(:,2),'rs')
val = get(handles.realcheckbox,'Value');

if(val == 1)
    plot(handles.TR(:,1),handles.TR(:,2),'go')
    plot(handles.BR(:,1),handles.BR(:,2),'gs')
end
hold off

guidata(hObject, handles);


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
imshow(~handles.C,'parent',handles.axes1);
guidata(hObject, handles);



% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
imshow(~handles.D,'parent',handles.axes1);
guidata(hObject, handles);




% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
imshow(~handles.A,'parent',handles.axes1);
guidata(hObject, handles);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
plotValues(hObject, eventdata, handles);
guidata(hObject, handles);



function plotValues(hObject, eventdata, handles)
val2 = get(handles.rgb,'Value');

if(val2 == 1)
    imshow(handles.imgRGB,'parent',handles.axes1);
else
    imshow(~handles.K,'parent',handles.axes1);
end

hold on;
s = size(handles.Points);
for i=1:s(1)
    plot(handles.Points(i,2),handles.Points(i,1),'r*','LineWidth',2);
end
plot(handles.T4(:,1),handles.T4(:,2),'bo')
plot(handles.B4(:,1),handles.B4(:,2),'rs')

val = get(handles.realcheckbox,'Value');

if(val == 1)
    plot(handles.TR(:,1),handles.TR(:,2),'go')
    plot(handles.BR(:,1),handles.BR(:,2),'gs')
end

hold off;
guidata(hObject, handles);



function bSize_Callback(hObject, eventdata, handles)
% hObject    handle to bSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of bSize as text
%        str2double(get(hObject,'String')) returns contents of bSize as a double


% --- Executes during object creation, after setting all properties.
function bSize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function gradSigma_Callback(hObject, eventdata, handles)
% hObject    handle to gradSigma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gradSigma as text
%        str2double(get(hObject,'String')) returns contents of gradSigma as a double


% --- Executes during object creation, after setting all properties.
function gradSigma_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gradSigma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
imshow(~handles.K,'parent',handles.axes1);
hold on;
s = size(handles.Points);
for i=1:s(1)
    plot(handles.Points(i,2),handles.Points(i,1),'r*','LineWidth',2);
end
hold off;
guidata(hObject, handles);


% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
imshow(~handles.K,'parent',handles.axes1);
hold on;
s = size(handles.Points);
for i=1:s(1)
    plot(handles.Points(i,2),handles.Points(i,1),'r*','LineWidth',2);
end
plot(handles.T4(:,1),handles.T4(:,2),'bo')
plot(handles.B4(:,1),handles.B4(:,2),'rs')
val = get(handles.realcheckbox,'Value');

if(val == 1)
    plot(handles.TR(:,1),handles.TR(:,2),'go')
    plot(handles.BR(:,1),handles.BR(:,2),'gs')
end
hold off;
guidata(hObject, handles);


% --- Executes on button press in realcheckbox.
function realcheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to realcheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of realcheckbox


% --- Executes on button press in rgb.
function rgb_Callback(hObject, eventdata, handles)
% hObject    handle to rgb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rgb
