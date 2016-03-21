function varargout = piyumGUI(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @piyumGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @piyumGUI_OutputFcn, ...
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


% --- Executes just before piyumGUI is made visible.
function piyumGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% Choose default command line output for piyumGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = piyumGUI_OutputFcn(hObject, eventdata, handles) 
% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in select_button.
function select_button_Callback(hObject, eventdata, handles)

[FileName,PathName] = uigetfile('*.jpg','Select image');
FilePath = [PathName,'/',FileName];
handles.path = FilePath;

imshow(FilePath,'parent',handles.input_axes);
guidata(hObject, handles);


function binwz_text_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function binwz_text_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function smoothwz_text_Callback(hObject, eventdata, handles)
% hObject    handle to smoothwz_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of smoothwz_text as text
%        str2double(get(hObject,'String')) returns contents of smoothwz_text as a double


% --- Executes during object creation, after setting all properties.
function smoothwz_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to smoothwz_text (see GCBO)
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



function smoothtr_text_Callback(hObject, eventdata, handles)
% hObject    handle to smoothtr_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of smoothtr_text as text
%        str2double(get(hObject,'String')) returns contents of smoothtr_text as a double


% --- Executes during object creation, after setting all properties.
function smoothtr_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to smoothtr_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function orims_text_Callback(hObject, eventdata, handles)
% hObject    handle to orims_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of orims_text as text
%        str2double(get(hObject,'String')) returns contents of orims_text as a double


% --- Executes during object creation, after setting all properties.
function orims_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to orims_text (see GCBO)
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



function oritr_text_Callback(hObject, eventdata, handles)
% hObject    handle to oritr_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of oritr_text as text
%        str2double(get(hObject,'String')) returns contents of oritr_text as a double


% --- Executes during object creation, after setting all properties.
function oritr_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to oritr_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function input_axes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input_axes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate input_axes



% --- Executes on button press in bin_go_button.
function bin_go_button_Callback(hObject, eventdata, handles)
% hObject    handle to bin_go_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

s = handles.path;
I = imread(s);
I = rgb2gray(I);

val = get(handles.invert_checkbox,'Value');

if(val == 1)
    I = imcomplement(I);
end

wz = get(handles.binwz_text,'String');
x = str2num(wz)
   
binImage = myFilter(I,x);
handles.binImage = binImage;

guidata(hObject, handles);


% --- Executes on button press in doSkel_button.
function doSkel_button_Callback(hObject, eventdata, handles)

I = handles.enhancedImage;
skelI = skel(~I);
handles.skelImage = skelI;
imshow(~skelI,'parent',handles.output_axes);

guidata(hObject, handles);


% --- Executes on button press in enhance_button.
function enhance_button_Callback(hObject, eventdata, handles)
% hObject    handle to enhance_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

I = handles.enhancedImage;
imshow(~I,'parent',handles.output_axes);

guidata(hObject, handles);


% --- Executes on button press in smoothedSkelbutton.
function smoothedSkelbutton_Callback(hObject, eventdata, handles)
% hObject    handle to smoothedSkelbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I = handles.gradSkelImage;
imshow(~I,'parent',handles.output_axes);

guidata(hObject, handles);


% --- Executes on button press in orientation_button.
function orientation_button_Callback(hObject, eventdata, handles)
% hObject    handle to orientation_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I = handles.oriImage;
imshow(I,'parent',handles.output_axes);

guidata(hObject, handles);


% --- Executes on button press in smooth_button.
function smooth_button_Callback(hObject, eventdata, handles)
% hObject    handle to smooth_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

I = handles.smoothedImage;
imshow(~I,'parent',handles.output_axes);

guidata(hObject, handles);


% --- Executes on button press in process_button.
function process_button_Callback(hObject, eventdata, handles)

s = handles.path;
I = imread(s);
I = rgb2gray(I);

val = get(handles.invert_checkbox,'Value');

if(val == 1)
    I = imcomplement(I);
end


binImage = myFilter(I,400);
handles.binImage = binImage;

I3 = reduce(binImage,5,15);
handles.smoothedImage = I3;

%I3 = binImage;
g = orientation_8dir(I3,40,35,10);
handles.grad = g;

oriImage = oriDraw_8dir(I3,g,10);
handles.oriImage = oriImage;

%I4 = directionalReduce(binImage,45,g,45,30);
I4 = directionalReduce(I3,45,g,45,30);
I4 = reduce(I4,5,15);
%I4 = imfill(I4,'holes');
handles.enhancedImage = I4;


I5 = skel(~I4);
handles.skelImage = I5;

I6 = remove(I5,20);
handles.smoothedSkelImage = I6;

imshow(~I6,'parent',handles.output_axes);

guidata(hObject, handles);


% --- Executes on button press in bin_button.
function bin_button_Callback(hObject, eventdata, handles)

I = handles.binImage;
imshow(~I,'parent',handles.output_axes);

guidata(hObject, handles);



function smoothhole_text_Callback(hObject, eventdata, handles)
% hObject    handle to smoothhole_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of smoothhole_text as text
%        str2double(get(hObject,'String')) returns contents of smoothhole_text as a double


% --- Executes during object creation, after setting all properties.
function smoothhole_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to smoothhole_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in smooth_go_button.
function smooth_go_button_Callback(hObject, eventdata, handles)

wz = str2num(get(handles.smoothwz_text,'String'));
tr = str2num(get(handles.smoothtr_text,'String'));
hole = str2num(get(handles.smoothhole_text,'String'));

bin = handles.binImage;

reducedI = reduce(bin,wz,tr);
smoothedI = fill(reducedI,hole);

imshow(~smoothedI,'parent',handles.output_axes);
handles.smoothedImage = smoothedI;

guidata(hObject, handles);


% --- Executes on button press in ori_go_button.
function ori_go_button_Callback(hObject, eventdata, handles)

mz = str2num(get(handles.orims_text,'String'));
tr = str2num(get(handles.oritr_text,'String'));

smoothedI = handles.smoothedImage;

g = orientation_8dir(smoothedI,mz,tr,10);
handles.grad = g;

oriImage = oriDraw_8dir(smoothedI,g,10);
handles.oriImage = oriImage;
imshow(oriImage,'parent',handles.output_axes);
guidata(hObject, handles);



function compms_text_Callback(hObject, eventdata, handles)
% hObject    handle to compms_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of compms_text as text
%        str2double(get(hObject,'String')) returns contents of compms_text as a double


% --- Executes during object creation, after setting all properties.
function compms_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to compms_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function comptr_text_Callback(hObject, eventdata, handles)
% hObject    handle to comptr_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of comptr_text as text
%        str2double(get(hObject,'String')) returns contents of comptr_text as a double


% --- Executes during object creation, after setting all properties.
function comptr_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to comptr_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in comp_go_button.
function comp_go_button_Callback(hObject, eventdata, handles)

ms = str2num(get(handles.compms_text,'String'));
tr = str2num(get(handles.comptr_text,'String'));

smoothedI = handles.smoothedImage;
g = handles.grad;

I4 = directionalReduce(smoothedI,ms,g,ms,tr);
I4 = reduce(I4,5,15);
%I4 = imfill(I4,'holes');
handles.enhancedImage = I4;
imshow(~I4,'parent',handles.output_axes);
guidata(hObject, handles);


% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in doSkel_button.
function pushbutton17_Callback(hObject, eventdata, handles)
% hObject    handle to doSkel_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function skelminlen_text_Callback(hObject, eventdata, handles)
% hObject    handle to skelminlen_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of skelminlen_text as text
%        str2double(get(hObject,'String')) returns contents of skelminlen_text as a double


% --- Executes during object creation, after setting all properties.
function skelminlen_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to skelminlen_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit17_Callback(hObject, eventdata, handles)
% hObject    handle to edit17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit17 as text
%        str2double(get(hObject,'String')) returns contents of edit17 as a double


% --- Executes during object creation, after setting all properties.
function edit17_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit18_Callback(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit18 as text
%        str2double(get(hObject,'String')) returns contents of edit18 as a double


% --- Executes during object creation, after setting all properties.
function edit18_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in skelclean_go_button.
function skelclean_go_button_Callback(hObject, eventdata, handles)

min = str2num(get(handles.skelminlen_text,'String'));

skelI = handles.skelImage;
removeI = remove(skelI,min);
%I4 = imfill(I4,'holes');
handles.skelCleanedImage = removeI;
imshow(~removeI,'parent',handles.output_axes);

guidata(hObject, handles);






function skelgradlen_text_Callback(hObject, eventdata, handles)
% hObject    handle to skelgradlen_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of skelgradlen_text as text
%        str2double(get(hObject,'String')) returns contents of skelgradlen_text as a double


% --- Executes during object creation, after setting all properties.
function skelgradlen_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to skelgradlen_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit15_Callback(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit15 as text
%        str2double(get(hObject,'String')) returns contents of edit15 as a double


% --- Executes during object creation, after setting all properties.
function edit15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in skelsmooth_go_button.
function skelsmooth_go_button_Callback(hObject, eventdata, handles)

len = str2num(get(handles.skelgradlen_text,'String'));

removeI = handles.skelCleanedImage;
 
[gradI,g] = gradSkel(removeI,40,len,1);
%I4 = imfill(I4,'holes');
handles.gradSkelImage = gradI;
imshow(~gradI,'parent',handles.output_axes);

guidata(hObject, handles);





function congradlen_text_Callback(hObject, eventdata, handles)
% hObject    handle to congradlen_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of congradlen_text as text
%        str2double(get(hObject,'String')) returns contents of congradlen_text as a double


% --- Executes during object creation, after setting all properties.
function congradlen_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to congradlen_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function conextlen_text_Callback(hObject, eventdata, handles)
% hObject    handle to conextlen_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of conextlen_text as text
%        str2double(get(hObject,'String')) returns contents of conextlen_text as a double


% --- Executes during object creation, after setting all properties.
function conextlen_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to conextlen_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in con_go_button.
function con_go_button_Callback(hObject, eventdata, handles)

gradlen = str2num(get(handles.congradlen_text,'String'));
extlen = str2num(get(handles.conextlen_text,'String'));
extwidth = str2num(get(handles.conextwidth_text,'String'));

gradI = handles.gradSkelImage;

[gI,g] = gradSkel(gradI,40,gradlen,0);
[connectI,pointsL,pointsR] = connect(gradI,g,extlen,extwidth);
%I4 = imfill(I4,'holes');
handles.connectedImage = connectI;
handles.connectedPointsL = pointsL;
handles.connectedPointsR = pointsR;
imshow(~connectI,'parent',handles.output_axes);

guidata(hObject, handles);



function conextwidth_text_Callback(hObject, eventdata, handles)
% hObject    handle to conextwidth_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of conextwidth_text as text
%        str2double(get(hObject,'String')) returns contents of conextwidth_text as a double


% --- Executes during object creation, after setting all properties.
function conextwidth_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to conextwidth_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in skel_button.
function skel_button_Callback(hObject, eventdata, handles)
I = handles.skelImage;
imshow(~I,'parent',handles.output_axes);

guidata(hObject, handles);


%method for open button in the tool bar
% --------------------------------------------------------------------
function open_ClickedCallback(hObject, eventdata, handles)
[FileName,PathName] = uigetfile('*.jpg','Select image');
FilePath = [PathName,'/',FileName];
handles.path = FilePath;

imshow(FilePath,'parent',handles.input_axes);
guidata(hObject, handles);





% --- Executes on button press in skel_connected.
function skel_connected_Callback(hObject, eventdata, handles)
I = handles.connectedImage;
imshow(~I,'parent',handles.output_axes);

guidata(hObject, handles);


% --- Executes on button press in skel_cleaned.
function skel_cleaned_Callback(hObject, eventdata, handles)
I = handles.skelCleanedImage;
imshow(~I,'parent',handles.output_axes);

guidata(hObject, handles);


% --- Executes on button press in skel_con_points.
function skel_con_points_Callback(hObject, eventdata, handles)
I = handles.gradSkelImage;
PointsL = handles.connectedPointsL;
PointsR = handles.connectedPointsR;
[x_p,y_p] = find(PointsL);
[x_p1,y_p1] = find(PointsR);
imshow(~I,'parent',handles.output_axes);       
hold on;            
plot(y_p,x_p,'o'); 
plot(y_p1,x_p1,'s');
hold off;


guidata(hObject, handles);
