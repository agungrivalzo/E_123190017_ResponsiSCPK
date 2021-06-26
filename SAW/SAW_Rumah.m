function varargout = SAW_Rumah(varargin)
% SAW_RUMAH MATLAB code for SAW_Rumah.fig
%      SAW_RUMAH, by itself, creates a new SAW_RUMAH or raises the existing
%      singleton*.
%
%      H = SAW_RUMAH returns the handle to a new SAW_RUMAH or the handle to
%      the existing singleton*.
%
%      SAW_RUMAH('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SAW_RUMAH.M with the given input arguments.
%
%      SAW_RUMAH('Property','Value',...) creates a new SAW_RUMAH or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SAW_Rumah_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SAW_Rumah_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SAW_Rumah

% Last Modified by GUIDE v2.5 25-Jun-2021 21:56:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SAW_Rumah_OpeningFcn, ...
                   'gui_OutputFcn',  @SAW_Rumah_OutputFcn, ...
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


% --- Executes just before SAW_Rumah is made visible.
function SAW_Rumah_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SAW_Rumah (see VARARGIN)

% Choose default command line output for SAW_Rumah
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SAW_Rumah wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SAW_Rumah_OutputFcn(hObject, eventdata, handles) 
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
opts = detectImportOptions('DATA Rumah.xlsx');
opts.SelectedVariableNames = (1);
data1 = readmatrix('DATA Rumah.xlsx',opts);

opts = detectImportOptions('DATA Rumah.xlsx');
opts.SelectedVariableNames = (3:8);
data2 = readmatrix('DATA Rumah.xlsx',opts);
%data dimaksukan ke tabel 1
data = [data1 data2];
set(handles.uitable1,'data',data);
opts = detectImportOptions('DATA Rumah.xlsx');
opts.SelectedVariableNames = (3:8);

x = readmatrix('DATA Rumah.xlsx',opts);
k=[0,1,1,1,1,1];%nilai atribut, 0(cost) dan 1(benefit)
w=[0.30,0.20,0.23,0.10,0.07,0.10];%bobot

[m,n]=size (x); 
R=zeros (m,n);
for j=1:n
    if k(j)==1
        %menghitung normalisasi kriteria jenis keuntungan
        R(:,j)=x(:,j)./max(x(:,j));
    else
        %menghitung normalisasi kriteria jenis biaya
        R(:,j)=min(x(:,j))./x(:,j);
    end
end
%perhitungan hasil perankingan
for i=1:m
 V(i)= sum(w.*R(i,:));
end
%menampilkan hasil perhitungan rumah
Vtranspose=V.'; 
Vtranspose=num2cell(Vtranspose);
opts = detectImportOptions('DATA Rumah.xlsx');
opts.SelectedVariableNames = (2);
x2= readtable('DATA Rumah.xlsx',opts);
x2 = table2cell(x2);
x2=[x2 Vtranspose];
x2=sortrows(x2,-2);
x2 = x2(1:20,1:2);
%data perhitungan dimasukan ke tabel 2
set(handles.uitable2, 'data', x2, 'visible','on');
