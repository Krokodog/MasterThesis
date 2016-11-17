function varargout = GUI(varargin)
% GUI MATLAB code for GUI.fig
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
%      applied to the GUI before GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI

% Last Modified by GUIDE v2.5 17-Nov-2016 19:45:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
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


% --- Executes just before GUI is made visible.
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI (see VARARGIN)

% Choose default command line output for GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

psoIteration = 0;
assignin('base','psoIteration',psoIteration)
psoSwarmSize = 0;
assignin('base','psoSwarmSize',psoSwarmSize)
ac1 = 0;
assignin('base','ac1',ac1)
iw1 = 0;
assignin('base','iw1',iw1)

swarmInfo = 0;
assignin('base','swarmInfo',swarmInfo)

epIteration = 0;
assignin('base','epIteration',epIteration)
epSwarmSize = 0;
assignin('base','epSwarmSize',epSwarmSize)
ac2 = 0;
assignin('base','ac2',ac2)
iw2 = 0;

assignin('base','iw2',iw2)
showIterationSteps = 0;
assignin('base','showIterationSteps',showIterationSteps)
showSolution = 0;
assignin('base','showSolution',showSolution)
showExploredArea = 0;
assignin('base','showExploredArea',showExploredArea)
% UIWAIT makes GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in startSimulation.
function startSimulation_Callback(hObject, eventdata, handles)
% hObject    handle to startSimulation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
run main.m


function nSimulation_Callback(hObject, eventdata, handles)
% hObject    handle to nSimulation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nSimulation as text
%        str2double(get(hObject,'String')) returns contents of nSimulation as a double


% --- Executes during object creation, after setting all properties.
function nSimulation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nSimulation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in saveData.
function saveData_Callback(hObject, eventdata, handles)
% hObject    handle to saveData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of saveData
value = get(hObject, 'Value')

% --- Executes on button press in sIterationsteps.
function sIterationsteps_Callback(hObject, eventdata, handles)
% hObject    handle to sIterationsteps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of sIterationsteps
showIterationSteps = get(hObject, 'Value');
assignin('base','showIterationSteps',showIterationSteps)

% --- Executes on button press in sExploreArea.
function sExploreArea_Callback(hObject, eventdata, handles)
% hObject    handle to sExploreArea (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of sExploreArea
showExploredArea = get(hObject, 'Value');
assignin('base','showExploredArea',showExploredArea)

% --- Executes on button press in sSolution.
function sSolution_Callback(hObject, eventdata, handles)
% hObject    handle to sSolution (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of sSolution
showSolution = get(hObject, 'Value');
assignin('base','showSolution',showSolution)


function epIteration_Callback(hObject, eventdata, handles)
% hObject    handle to epIteration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of epIteration as text
%        str2double(get(hObject,'String')) returns contents of epIteration as a double
 epIteration = str2double(get(hObject,'String'));
 assignin('base','epIteration',epIteration)

% --- Executes during object creation, after setting all properties.
function epIteration_CreateFcn(hObject, eventdata, handles)
% hObject    handle to epIteration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function epSwarmsize_Callback(hObject, eventdata, handles)
% hObject    handle to epSwarmsize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of epSwarmsize as text
%        str2double(get(hObject,'String')) returns contents of epSwarmsize as a double
epSwarmSize =str2double(get(hObject,'String'))
assignin('base','epSwarmSize',epSwarmSize)

% --- Executes during object creation, after setting all properties.
function epSwarmsize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to epSwarmsize (see GCBO)
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


% --- Executes on slider movement.
function epIwSlider_Callback(hObject, eventdata, handles)
% hObject    handle to epIwSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
 iw2 = get(hObject,'Value');
 set(handles.ac1,'String',num2str(iw2));
 assignin('base','iw2',iw2)

% --- Executes during object creation, after setting all properties.
function epIwSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to epIwSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function PSOiwSlider_Callback(hObject, eventdata, handles)
% hObject    handle to PSOiwSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
 iw1 = get(hObject,'Value');
 set(handles.iw1,'String',num2str(iw1));
 assignin('base','iw1',iw1)

% --- Executes during object creation, after setting all properties.
function PSOiwSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PSOiwSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
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



function PSOSwarmsize_Callback(hObject, eventdata, handles)
% hObject    handle to PSOSwarmsize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of PSOSwarmsize as text
%        str2double(get(hObject,'String')) returns contents of PSOSwarmsize as a double
 psoSwarmSize = str2double(get(hObject,'String'));
 assignin('base','psoSwarmSize',psoSwarmSize)

% --- Executes during object creation, after setting all properties.
function PSOSwarmsize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PSOSwarmsize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function PSOiteration_Callback(hObject, eventdata, handles)
% hObject    handle to PSOiteration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of PSOiteration as text
%        str2double(get(hObject,'String')) returns contents of PSOiteration as a double
 psoIteration = str2double(get(hObject,'String'));
 assignin('base','psoIteration',psoIteration)


% --- Executes during object creation, after setting all properties.
function PSOiteration_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PSOiteration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Information.
function Information_Callback(hObject, eventdata, handles)
% hObject    handle to Information (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Information contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Information
 contents = cellstr(get(hObject,'String'));
 swarmInfo = contents{get(hObject,'Value')};
 assignin('base','swarmInfo',swarmInfo)

% --- Executes during object creation, after setting all properties.
function Information_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Information (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function epAcSlider_Callback(hObject, eventdata, handles)
% hObject    handle to epAcSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
 ac2 = get(hObject,'Value');
 set(handles.ac2,'String',num2str(ac2));
 assignin('base','ac2',ac2)

% --- Executes during object creation, after setting all properties.
function epAcSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to epAcSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function PSOacSlider_Callback(hObject, eventdata, handles)
% hObject    handle to PSOacSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

 ac1 = get(hObject,'Value');
 set(handles.ac1,'String',num2str(ac1));
 assignin('base','ac1',ac1)

% --- Executes during object creation, after setting all properties.
function PSOacSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PSOacSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
