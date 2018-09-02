function varargout = anpr_gui(varargin)
clc;
% ANPR_GUI MATLAB code for anpr_gui.fig
%      ANPR_GUI, by itself, creates a new ANPR_GUI or raises the existing
%      singleton*.
%
%      H = ANPR_GUI returns the handle to a new ANPR_GUI or the handle to
%      the existing singleton*.
%
%      ANPR_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ANPR_GUI.M with the given input arguments.
%
%      ANPR_GUI('Property','Value',...) creates a new ANPR_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before anpr_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to anpr_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help anpr_gui


% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @anpr_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @anpr_gui_OutputFcn, ...
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


% --- Executes just before anpr_gui is made visible.
function anpr_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to anpr_gui (see VARARGIN)

% Choose default command line output for anpr_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes anpr_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = anpr_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;





% --- Executes on button press in opening.
function opening_Callback(hObject, eventdata, handles)
% hObject    handle to opening (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uifile=uigetfile('.jpg');
setappdata(handles.opening,'data',uifile);
axes(handles.axes1);
imshow(uifile);
% --- Executes on button press in prediction.
function prediction_Callback(hObject, eventdata, handles)
% hObject    handle to prediction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%clc;
%clear all;
%close all;
%pkg load image
%training();
%f=imread('sam1.jpg');
%imshow(f);
load('weights.mat');
axes(handles.axes2)
readValue= getappdata(handles.opening,'data'); 
f=imread(readValue);
[u,im]=anpr(f);
predicted=prediction(u,Theta1,Theta2);
keys={'1','2','3','4','5','6','7','8','9','10','11','12','13'};
values={'1','2','3','4','5','6','7','8','9','0','A','H','P'};
mapobj=containers.Map(keys,values);
s=size(predicted);
for t=1:s(2)   
number_plate(t)=mapobj(num2str(predicted(t)));
end

imshow(im);
set(handles.plate,'String',number_plate)





function plate_Callback(hObject, eventdata, handles)
% hObject    handle to plate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of plate as text
%        str2double(get(hObject,'String')) returns contents of plate as a double


% --- Executes during object creation, after setting all properties.
function plate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to plate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
