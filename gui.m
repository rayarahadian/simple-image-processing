function varargout = gui(varargin)
% GUI MATLAB code for gui.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui

% Last Modified by GUIDE v2.5 28-Feb-2018 12:24:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_OutputFcn, ...
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


% --- Executes just before gui is made visible.
function gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui (see VARARGIN)

% Choose default command line output for gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in browseImage.
function browseImage_Callback(hObject, eventdata, handles)
% hObject    handle to browseImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img;
global original_img;
[filename, pathname] = uigetfile({'*.*';},'File Selector');
img = imread([pathname filename]);
original_img = imread([pathname filename]);
axes(handles.axes2);
imshow(img);
%% 


% --- Executes on button press in grayscale.
function grayscale_Callback(hObject, eventdata, handles)
% hObject    handle to grayscale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global gray;
global img;
R = img(:, :, 1);
G = img(:, :, 2);
B = img(:, :, 3);
gray = zeros(size(img,1), size(img,2), 'uint8');
for x=1:size(img,1)
    for y=1:size(img,2)
        rata = ((R(x,y)*0.3)+(G(x,y)*0.3)+(B(x,y)*0.4));
        gray(x,y) = rata;
    end
end
axes(handles.axes2);
imshow(gray);
        
        

% --- Executes on button press in zoomIn.
function zoomIn_Callback(hObject, eventdata, handles)
% hObject    handle to zoomIn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img;
global zoomIn;
R = img(:, :, 1);
G = img(:, :, 2);
B = img(:, :, 3);
x = size(img,1)-200;
y = size(img,2)-200;
zoomIn = zeros(x, y, 'uint8');
for x=1:size(zoomIn,1)
    for y=1:size(zoomIn,2)
        zoomIn(x,y,1) = R(x+100,y+100);
        zoomIn(x,y,2) = G(x+100,y+100);
        zoomIn(x,y,3) = B(x+100,y+100);
    end
end
img = zoomIn;
axes(handles.axes2);
imshow(zoomIn);


% --- Executes on button press in zoomOut.
function zoomOut_Callback(hObject, eventdata, handles)
% hObject    handle to zoomOut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img;
global zoomOut;
R = img(:, :, 1);
G = img(:, :, 2);
B = img(:, :, 3);
x = size(img,1)+200;
y = size(img,2)+200;
zoomOut = zeros(x, y, 'uint8');
for x=1:size(img,1)
    for y=1:size(img,2)
        zoomOut(x+100,y+100,1) = R(x,y);
        zoomOut(x+100,y+100,2) = G(x,y);
        zoomOut(x+100,y+100,3) = B(x,y);
    end
end
img = zoomOut;
axes(handles.axes2);
imshow(zoomOut);

% --- Executes on button press in invers.
function invers_Callback(hObject, eventdata, handles)
% hObject    handle to invers (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img;
global invers;
R = img(:, :, 1);
G = img(:, :, 2);
B = img(:, :, 3);
invers = zeros(size(img,1), size(img,2), 'uint8');
for x=1:size(img,1)
    for y=1:size(img,2)
        invers(x,y,1) = (255-R(x,y));
        invers(x,y,2) = (255-G(x,y));
        invers(x,y,3) = (255-B(x,y));
    end
end
img = invers;
axes(handles.axes2);
imshow(invers);



% --- Executes on button press in original.
function original_Callback(hObject, eventdata, handles)
% hObject    handle to original (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img;
global original_img;
img = original_img;
axes(handles.axes2);
imshow(img);


% --- Executes on button press in flipHorizontal.
function flipHorizontal_Callback(hObject, eventdata, handles)
% hObject    handle to flipHorizontal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img;
global flip_horizontal;
R = img(:, :, 1);
G = img(:, :, 2);
B = img(:, :, 3);
flip_horizontal = zeros(size(img,1), size(img,2), 'uint8');
for x=1:size(img,1)
    a = size(img,2);
    for y=1:size(img,2)
        flip_horizontal(x, y, 1) = R(x, a);
        flip_horizontal(x, y, 2) = G(x, a);
        flip_horizontal(x, y, 3) = B(x, a);
        a = a - 1;
    end
end
img = flip_horizontal;
axes(handles.axes2);
imshow(flip_horizontal);

% --- Executes on button press in flipVertical.
function flipVertical_Callback(hObject, eventdata, handles)
% hObject    handle to flipVertical (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img;
global flip_vertical;
R = img(:, :, 1);
G = img(:, :, 2);
B = img(:, :, 3);
flip_vertical = zeros(size(img,1), size(img,2), 'uint8');
a = size(img,1);
for x=1:size(img,1)
    for y=1:size(img,2)
        flip_vertical(x, y, 1) = R(a,y);
        flip_vertical(x, y, 2) = G(a,y);
        flip_vertical(x, y, 3) = B(a,y);
    end
    a = a - 1;
end
img = flip_vertical;
axes(handles.axes2);
imshow(flip_vertical);

function x_untuk_penerangan_dan_penggelapan_Callback(hObject, eventdata, handles)
% hObject    handle to x_untuk_penerangan_dan_penggelapan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x_untuk_penerangan_dan_penggelapan as text
%        str2double(get(hObject,'String')) returns contents of x_untuk_penerangan_dan_penggelapan as a double

% --- Executes during object creation, after setting all properties.
function x_untuk_penerangan_dan_penggelapan_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x_untuk_penerangan_dan_penggelapan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in brighter_plus.
function brighter_plus_Callback(hObject, eventdata, handles)
% hObject    handle to brighter_plus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img;
global penerangan_ditambah;
R = img(:, :, 1);
G = img(:, :, 2);
B = img(:, :, 3);
nilai_x = str2double(get(handles.x_untuk_penerangan_dan_penggelapan, 'String'));
if isempty(nilai_x)
    fprintf('Isi nilai x untuk penerangan dan penggelapan\n');
else
    penerangan_ditambah = zeros(size(img,1), size(img,2), 'uint8');
    for x=1:size(img,1)
        for y=1:size(img,2)
            penerangan_ditambah(x,y,1) = (R(x,y)+nilai_x);
            penerangan_ditambah(x,y,2) = (G(x,y)+nilai_x);
            penerangan_ditambah(x,y,3) = (B(x,y)+nilai_x);
        end
    end
    img = penerangan_ditambah;
    axes(handles.axes2);
    imshow(penerangan_ditambah);
end


% --- Executes on button press in brighter_multiply.
function brighter_multiply_Callback(hObject, eventdata, handles)
% hObject    handle to brighter_multiply (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img;
global penerangan_dikali;
R = img(:, :, 1);
G = img(:, :, 2);
B = img(:, :, 3);
nilai_x = str2double(get(handles.x_untuk_penerangan_dan_penggelapan, 'String'));
if isempty(nilai_x)
    fprintf('Isi nilai x untuk penerangan dan penggelapan\n');
else
    penerangan_dikali = zeros(size(img,1), size(img,2), 'uint8');
    for x=1:size(img,1)
        for y=1:size(img,2)
            penerangan_dikali(x,y,1) = R(x,y)*nilai_x;
            penerangan_dikali(x,y,2) = G(x,y)*nilai_x;
            penerangan_dikali(x,y,3) = B(x,y)*nilai_x;
        end
    end
    img = penerangan_dikali;
    axes(handles.axes2);
    imshow(penerangan_dikali);
end


% --- Executes on button press in darker_minus.
function darker_minus_Callback(hObject, eventdata, handles)
% hObject    handle to darker_minus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img;
global penggelapan_dikurang;
R = img(:, :, 1);
G = img(:, :, 2);
B = img(:, :, 3);
nilai_x = str2double(get(handles.x_untuk_penerangan_dan_penggelapan, 'String'));
if isempty(nilai_x)
    fprintf('Isi nilai x untuk penerangan dan penggelapan\n');
else
    penggelapan_dikurang = zeros(size(img,1), size(img,2), 'uint8');
    for x=1:size(img,1)
        for y=1:size(img,2)
            penggelapan_dikurang(x,y,1) = (R(x,y)-nilai_x);
            penggelapan_dikurang(x,y,2) = (G(x,y)-nilai_x);
            penggelapan_dikurang(x,y,3) = (B(x,y)-nilai_x);
        end
    end
    img = penggelapan_dikurang;
    axes(handles.axes2);
    imshow(penggelapan_dikurang);
end

% --- Executes on button press in darker_divided_by.
function darker_divided_by_Callback(hObject, eventdata, handles)
% hObject    handle to darker_divided_by (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img;
global penggelapan_dibagi;
R = img(:, :, 1);
G = img(:, :, 2);
B = img(:, :, 3);
nilai_x = str2double(get(handles.x_untuk_penerangan_dan_penggelapan, 'String'));
if isempty(nilai_x)
    fprintf('Isi nilai x untuk penerangan dan penggelapan\n');
else
    penggelapan_dibagi = zeros(size(img,1), size(img,2), 'uint8');
    for x=1:size(img,1)
        for y=1:size(img,2)
            penggelapan_dibagi(x,y,1) = (R(x,y)/nilai_x);
            penggelapan_dibagi(x,y,2) = (G(x,y)/nilai_x);
            penggelapan_dibagi(x,y,3) = (B(x,y)/nilai_x);
        end
    end
    img = penggelapan_dibagi;
    axes(handles.axes2);
    imshow(penggelapan_dibagi);
end

% --- Executes on button press in crop.
function crop_Callback(hObject, eventdata, handles)
% hObject    handle to crop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img;
global crop;
R = img(:, :, 1);
G = img(:, :, 2);
B = img(:, :, 3);
xmin = str2double(get(handles.crop_xmin, 'String'));
xmax = str2double(get(handles.crop_xmax, 'String'));
ymin = str2double(get(handles.crop_ymin, 'String'));
ymax = str2double(get(handles.crop_ymax, 'String'));
if xmin==0 && ymin==0
    xmin = 1;
    ymin = 1;
end
if isempty(xmin) || isempty(xmax) || isempty(ymin) || isempty(ymax)
    fprintf('Isi nilai xmin,xmax,ymin, dan ymax untuk penerangan dan penggelapan\n');
else
    if xmax>xmin && ymax>ymin
        crop = zeros(xmax-xmin, ymax-ymin, 'uint8');
        for x=1:size(crop,1)
            for y=1:size(crop,2)
                crop(x,y,1) = 255;
                crop(x,y,2) = 255;
                crop(x,y,3) = 255;
            end
        end
        for x=1:size(crop,1)
            for y=1:size(crop,2)
                crop(x,y,1) = R((xmin+x),(ymin+y));
                crop(x,y,2) = G((xmin+x),(ymin+y));
                crop(x,y,3) = B((xmin+x),(ymin+y));
            end
        end
        img = crop;
        axes(handles.axes2);
        imshow(crop); 
    else
        fprintf('Max harus lebih besar dari min\n');
    end
end


function crop_ymin_Callback(hObject, eventdata, handles)
% hObject    handle to crop_ymin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of crop_ymin as text
%        str2double(get(hObject,'String')) returns contents of crop_ymin as a double


% --- Executes during object creation, after setting all properties.
function crop_ymin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to crop_ymin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function crop_ymax_Callback(hObject, eventdata, handles)
% hObject    handle to crop_ymax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of crop_ymax as text
%        str2double(get(hObject,'String')) returns contents of crop_ymax as a double


% --- Executes during object creation, after setting all properties.
function crop_ymax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to crop_ymax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function crop_xmin_Callback(hObject, eventdata, handles)
% hObject    handle to crop_xmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of crop_xmin as text
%        str2double(get(hObject,'String')) returns contents of crop_xmin as a double


% --- Executes during object creation, after setting all properties.
function crop_xmin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to crop_xmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function crop_xmax_Callback(hObject, eventdata, handles)
% hObject    handle to crop_xmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of crop_xmax as text
%        str2double(get(hObject,'String')) returns contents of crop_xmax as a double


% --- Executes during object creation, after setting all properties.
function crop_xmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to crop_xmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in histogram.
function histogram_Callback(hObject, eventdata, handles)
% hObject    handle to histogram (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img;
count_R = zeros(256,1);
count_G = zeros(256,1);
count_B = zeros(256,1);
R = img(:, :, 1);
G = img(:, :, 2);
B = img(:, :, 3);
for a=1:256
    for x=1:size(img,1)
        for y=1:size(img,2)
            if (a-1)==R(x,y)
                count_R(a,1) = count_R(a,1)+1;
            end
            if (a-1)==G(x,y)
                count_G(a,1) = count_R(a,1)+1;
            end
            if (a-1)==G(x,y)
                count_B(a,1) = count_R(a,1)+1;
            end 
        end 
    end
end
axes(handles.axes2);
imshow(img);
figure
subplot(2,2,1);
bar(count_R);
xlim([1 256]);
title('Histogram R');
subplot(2,2,2);
bar(count_G);
xlim([1 256]);
title('Histogram G');
subplot(2,2,3);
bar(count_B);
xlim([1 256]);
title('Histogram B');

% --- Executes on button press in rotate_90.
function rotate_90_Callback(hObject, eventdata, handles)
% hObject    handle to rotate_90 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img;
global rotate_90;
R = img(:, :, 1);
G = img(:, :, 2);
B = img(:, :, 3);
rotate_90 = zeros(size(img,2), size(img,1), 'uint8');
a = size(img,1);
for x=1:size(img,1)
    for y=1:size(img,2)
        rotate_90(y, a, 1) = R(x,y);
        rotate_90(y, a, 2) = G(x,y);
        rotate_90(y, a, 3) = B(x,y);
    end
    a = a - 1;
end
img = rotate_90;
axes(handles.axes2);
imshow(rotate_90);

% --- Executes on button press in rotate_180.
function rotate_180_Callback(hObject, eventdata, handles)
% hObject    handle to rotate_180 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img;
global rotate_180;
R = img(:, :, 1);
G = img(:, :, 2);
B = img(:, :, 3);
rotate_180 = zeros(size(img,1), size(img,2), 'uint8');
a = size(img,1);
for x=1:size(img,1)
    b = size(img, 2);
    for y=1:size(img,2)
        rotate_180(x, y, 1) = R(a,b);
        rotate_180(x, y, 2) = G(a,b);
        rotate_180(x, y, 3) = B(a,b);
        b = b - 1;
    end
    a = a - 1;
end
img = rotate_180;
axes(handles.axes2);
imshow(rotate_180);

% --- Executes on button press in rotate_270.
function rotate_270_Callback(hObject, eventdata, handles)
% hObject    handle to rotate_270 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img;
global rotate_270;
R = img(:, :, 1);
G = img(:, :, 2);
B = img(:, :, 3);
rotate_270 = zeros(size(img,2), size(img,1), 'uint8');
a = size(img,1);
for x=1:size(img,1)
    b = size(img,2);
    for y=1:size(img,2)
        rotate_270(y, x, 1) = R(x,b);
        rotate_270(y, x, 2) = G(x,b);
        rotate_270(y, x, 3) = B(x,b);
        b = b - 1;
    end
    a = a - 1;
end
img = rotate_270;
axes(handles.axes2);
imshow(rotate_270);