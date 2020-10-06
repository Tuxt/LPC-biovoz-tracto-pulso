function varargout = gui(varargin)
% GUI MATLAB code for gui.fig
% See also: GUIDE, GUIDATA, GUIHANDLES
% Last Modified by GUIDE v2.5 20-Jun-2019 04:11:46
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
% Choose default command line output for gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles) 
% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Acción de botón de búsqueda de archivo 1
function button_file1_Callback(hObject, eventdata, handles)
% Borra seleccion de lista
handles.choose_file1.Value = 1;
% Busca archivo
[file1,path1] = uigetfile({'*.wav';'WAV Files'});
if file1 ~= 0
    [x1,fs1] = audioread([path1,'\',file1]);
    handles.text_file1.String = [file1, newline, 'fs = ',int2str(fs1)];
    setappdata(handles.text_file1, 'x1', x1);
    setappdata(handles.text_file1, 'fs1', fs1);
    plotter(handles.plot_file1,x1,fs1);
    
    % Comprueba si hay que habilitar el boton RUN
    if getappdata(handles.text_file2, 'fs2') == fs1
        handles.button_run.Enable = 'on';
        handles.input_coef.String = string(floor(0.001*fs1));
    else
        handles.button_run.Enable = 'off';
    end
else
    handles.text_file1.String = 'Choose file';
    handles.button_run.Enable = 'off';
end


% --- Acción de botón de búsqueda de archivo 2
function button_file2_Callback(hObject, eventdata, handles)
% Borra seleccion de lista
handles.choose_file2.Value = 1;
% Busca archivo
[file2,path2] = uigetfile({'*.wav';'WAV Files'});
if file2 ~= 0
    [x2,fs2] = audioread([path2,'\',file2]);
    handles.text_file2.String = [file2,newline,'fs = ',int2str(fs2)];
    setappdata(handles.text_file2, 'x2', x2);
    setappdata(handles.text_file2, 'fs2', fs2);
    plotter(handles.plot_file2,x2,fs2);
    size(x2)
    
    % Comprueba si hay que habilitar el boton RUN
    if getappdata(handles.text_file1, 'fs1') == fs2
        handles.button_run.Enable = 'on';
        handles.input_coef.String = string(floor(0.001*fs2));
    else
        handles.button_run.Enable = 'off';
    end
else
    handles.text_file2.String = 'Choose file';
        handles.button_run.Enable = 'off';
end


% --- Acción de selección de archivo en lista de archivo 1
function choose_file1_Callback(hObject, eventdata, handles)
if hObject.Value > 1    % Archivo válido
    % Lee el archivo
    file1 = hObject.String{hObject.Value};
    [x1,fs1] = audioread(['wav/', file1]);
    handles.text_file1.String = [file1, newline, 'fs = ', int2str(fs1)];
    setappdata(handles.text_file1, 'x1', x1);
    setappdata(handles.text_file1, 'fs1', fs1);
    plotter(handles.plot_file1,x1,fs1);
    
    % Comprueba si hay que habilitar el boton RUN
    if getappdata(handles.text_file2, 'fs2') == fs1
        handles.button_run.Enable = 'on';
        handles.input_coef.String = string(floor(0.001*fs1));
    else
        handles.button_run.Enable = 'off';
    end
else
    handles.text_file1.String = 'Choose file';
    handles.button_run.Enable = 'off';
end

% --- Creación de lista de archivos: lista archivo 1
function choose_file1_CreateFcn(hObject, eventdata, handles)
% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Crea la lista 1 de archivos WAV
dir_files = dir('wav/*.wav');
files = {'--Select file--'};
for i=1:size(dir_files,1)
	files{1,i+1} = dir_files(i).name;
end
hObject.String = files;


% --- Acción de selección de archivo en lista de archivo 2
function choose_file2_Callback(hObject, eventdata, handles)
% Si se ha seleccionado un archivo válido lo lee
if hObject.Value > 1
    file2 = hObject.String{hObject.Value};
    [x2,fs2] = audioread(['wav/', file2]);
    handles.text_file2.String = [file2, newline,'fs = ', int2str(fs2)];
    setappdata(handles.text_file2,'x2',x2);
    setappdata(handles.text_file2,'fs2',fs2);
    plotter(handles.plot_file2,x2,fs2);
    
    % Comprueba si hay que habilitar el boton RUN
    if getappdata(handles.text_file1, 'fs1') == fs2
        handles.button_run.Enable = 'on';
        handles.input_coef.String = string(floor(0.001*fs2));
    else
        handles.button_run.Enable = 'off';
    end
else
    handles.text_file2.String = 'Choose file';
        handles.button_run.Enable = 'off';
end

% --- Creación de lista de archivos: lista archivo 2
function choose_file2_CreateFcn(hObject, eventdata, handles)
% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Crea la lista 2 de archivos WAV
dir_files = dir('wav/*.wav');
files = {'--Select file--'};
for i=1:size(dir_files,1)
	files{1,i+1} = dir_files(i).name;
end
hObject.String = files;

% --- Comprobacion de datos introducidos en el campo de polo
function input_preemphasis_pole_Callback(hObject, eventdata, handles)
check_numeric_value(hObject);
% --- Executes during object creation, after setting all properties.
function input_preemphasis_pole_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Comprobacion de datos introducidos en el campo de polo
function input_deemphasis_pole_Callback(hObject, eventdata, handles)
check_numeric_value(hObject);
% --- Executes during object creation, after setting all properties.
function input_deemphasis_pole_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Comprobacion de datos introducidos en el campo de coeficientes
function input_coef_Callback(hObject, eventdata, handles)
check_integer_value(hObject);
% --- Executes during object creation, after setting all properties.
function input_coef_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Comprobacion de datos introducidos en el campo de ventana
function input_windowsize_Callback(hObject, eventdata, handles)
check_integer_value(hObject);
% --- Executes during object creation, after setting all properties.
function input_windowsize_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Comprobacion de datos introducidos en el campo de solapamiento
function input_overlap_Callback(hObject, eventdata, handles)
check_numeric_value(hObject);
% --- Executes during object creation, after setting all properties.
function input_overlap_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Ejecución de separación y recomposicion
function button_run_Callback(hObject, eventdata, handles)
% Obtencion de datos de audio
x1 = getappdata(handles.text_file1, 'x1');
fs1 = getappdata(handles.text_file1, 'fs1');
x2 = getappdata(handles.text_file2, 'x2');
fs2 = getappdata(handles.text_file2, 'fs2');

% Obtencion de numero de coeficientes
n_coef = get_ncoef(handles);

% Obtencion del polo de preenfasis
pre_pole = get_prepole(handles);

% Obtencion del polo de deenfasis
de_pole = get_depole(handles);

% Obtencion de tamaño de ventana
l_v = get_window_size(handles);

% Obtencion del solapamiento/desplazamiento
slide = get_slide(handles);

% Procesamiento de datos: Separacion
[x1_fil, A1, P1] = separa(x1, n_coef, pre_pole, l_v, slide);
[x2_fil, A2, P2] = separa(x2, n_coef, pre_pole, l_v, slide);

% Procesamiento de datos: Union
t1p1 = junta(A1, P1, de_pole);
t1p2 = junta(A1, P2, de_pole);
t2p1 = junta(A2, P1, de_pole);
t2p2 = junta(A2, P2, de_pole);

% Guarda datos de reproducción en botones de repreoducción
setappdata(handles.button_t1p1, 't1p1', t1p1);
setappdata(handles.button_t1p1, 'fs', fs1);
setappdata(handles.button_t1p2, 't1p2', t1p2);
setappdata(handles.button_t1p2, 'fs', fs1);
setappdata(handles.button_t2p1, 't2p1', t2p1);
setappdata(handles.button_t2p1, 'fs', fs1);
setappdata(handles.button_t2p2, 't2p2', t2p2);
setappdata(handles.button_t2p2, 'fs', fs1);

% Guarda datos de gráficas A's y P's en este mismo objeto
setappdata(hObject, 'A1', A1);
setappdata(hObject, 'A2', A2);
setappdata(hObject, 'P1', P1);
setappdata(hObject, 'P2', P2);
% Los datos anteriores tambien, ya que pueden haberse leido nuevos archivos
% siento estos los correspondientes a la ultima ejecucion (RUN)
% Además, las graficas de formantes usan x filtrada
setappdata(hObject, 'fs1', fs1);
setappdata(hObject, 'fs2', fs2);
setappdata(hObject, 'x1_fil', x1_fil);
setappdata(hObject, 'x2_fil', x2_fil);


% ---------- Botones de reproducción ----------
% --- Reproduce t1p1
function button_t1p1_Callback(hObject, eventdata, handles)
t1p1 = getappdata(hObject, 't1p1');
fs = getappdata(hObject, 'fs');
if ~isempty(t1p1) && ~isempty(fs)
    sound(t1p1,fs);
end
    
% --- Reproduce t1p2
function button_t1p2_Callback(hObject, eventdata, handles)
t1p2 = getappdata(hObject, 't1p2');
fs = getappdata(hObject, 'fs');
if ~isempty(t1p2) && ~isempty(fs)
    sound(t1p2,fs);
end

% --- Reproduce t2p1
function button_t2p1_Callback(hObject, eventdata, handles)
t2p1 = getappdata(hObject, 't2p1');
fs = getappdata(hObject, 'fs');
if ~isempty(t2p1) && ~isempty(fs)
    sound(t2p1,fs);
end

% --- Reproduce t2p2
function button_t2p2_Callback(hObject, eventdata, handles)
t2p2 = getappdata(hObject, 't2p2');
fs = getappdata(hObject, 'fs');
if ~isempty(t2p2) && ~isempty(fs)
    sound(t2p2,fs);
end

% --- Detiene la reproducción de audio
function button_stop_Callback(hObject, eventdata, handles)
clear sound;


% --- Comprobacion de datos introducidos en el campo de trama de formantes
function input_trama_Callback(hObject, eventdata, handles)
check_integer_value(hObject);
% --- Executes during object creation, after setting all properties.
function input_trama_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% ----------- Botones de gráficas ----------
% --- Creación de gráficas de tracto 1
function button_plot_tract1_Callback(hObject, eventdata, handles)
l_v = get_window_size(handles);
slide = l_v * get_slide(handles);
A1 = getappdata(handles.button_run, 'A1');
fs1 = getappdata(handles.button_run, 'fs1');
graficas_tracto(1, l_v, slide, A1, fs1);


% --- Creación de gráficas de formantes 1
function button_plot_formants1_Callback(hObject, eventdata, handles)
x1_fil = getappdata(handles.button_run, 'x1_fil');
trama = get_trama(handles);
l_v = get_window_size(handles);
fs1 = getappdata(handles.button_run, 'fs1');
A1 = getappdata(handles.button_run, 'A1');
graficas_formantes(1, x1_fil, trama, l_v, fs1, A1);


% --- Creación de gráficas de pulso 1
function button_plot_pulse1_Callback(hObject, eventdata, handles)
P1 = getappdata(handles.button_run, 'P1');
l_v = get_window_size(handles);
fs1 = getappdata(handles.button_run, 'fs1');
graficas_pulso(1,P1,l_v,fs1);


% --- Creación de gráficas de tracto 2
function button_plot_tract2_Callback(hObject, eventdata, handles)
l_v = get_window_size(handles);
slide = l_v * get_slide(handles);
A2 = getappdata(handles.button_run, 'A2');
fs2 = getappdata(handles.button_run, 'fs2');
graficas_tracto(2, l_v, slide, A2, fs2);


% --- Creación de gráficas de formantes 2
function button_plot_formants2_Callback(hObject, eventdata, handles)
x2_fil = getappdata(handles.button_run, 'x2_fil');
trama = get_trama(handles);
l_v = get_window_size(handles);
fs2 = getappdata(handles.button_run, 'fs2');
A2 = getappdata(handles.button_run, 'A2');
graficas_formantes(2, x2_fil, trama, l_v, fs2, A2);


% --- Creación de gráficas de pulso 2
function button_plot_pulse2_Callback(hObject, eventdata, handles)
P2 = getappdata(handles.button_run, 'P2');
l_v = get_window_size(handles);
fs2 = getappdata(handles.button_run, 'fs2');
graficas_pulso(2,P2,l_v,fs2);




% ---------- Aux functs ----------
% Comprueba si hObject (input text) es numerico, vacia el texto si no
function isnum = check_numeric_value(hObject)
val = hObject.String;
if isempty(str2double(val))
    hObject.String = '';
    isnum = false;
else
    isnum = true;
end

% Comprueba si hObject (input text) es entero, vacia el texto si no
function isint = check_integer_value(hObject)
val = hObject.String;
val = str2double(val);
if ~isempty(val) && mod(val,1)==0
    isint = true;
else
    isint = false;
    hObject.String = '';
end

% Crea gráfica sonido en la GUI (al leer archivo)
function plotter(guiObject, x, fs)
axes(guiObject);
t = 1:length(x);
t = t/fs;
plot(t,x);

function n_coef = get_ncoef(handles)
if check_integer_value(handles.input_coef)
    n_coef = str2double(handles.input_coef.String);
else
    n_coef = floor(0.001*fs1);
end

function pre_pole = get_prepole(handles)
pre_pole_selection = handles.group_preemphasis.SelectedObject;
if pre_pole_selection == handles.radio_preemphasis_no || ~check_numeric_value(handles.input_preemphasis_pole)
    pre_pole = 0;
else
    pre_pole = str2double(handles.input_preemphasis_pole.String);
end

function de_pole = get_depole(handles)
de_pole_selection = handles.group_deemphasis.SelectedObject;
if de_pole_selection == handles.radio_deemphasis_no || ~check_numeric_value(handles.input_deemphasis_pole)
    de_pole = 0;
else
    de_pole = str2double(handles.input_deemphasis_pole.String);
end

function trama = get_trama(handles)
% Obtencion del numero de trama
if check_integer_value(handles.input_trama)
    trama = str2double(handles.input_trama.String);
else
    trama = 10; % Default value
end

function l_v = get_window_size(handles)
% Obtencion de tamaño de ventana
if check_integer_value(handles.input_windowsize)
    l_v = str2double(handles.input_windowsize.String);
else
    l_v = 512;  % Default value
end

function slide = get_slide(handles)
overlap_selection = handles.group_window.SelectedObject;
% Seleccion de solapamiento custom
if overlap_selection == handles.radio_overlap_custom
    overlap_custom = handles.input_overlap;
    if check_numeric_value(overlap_custom)
        slide = 1 - str2double(overlap_custom.String);
        if slide <= 0
            slide = 0.05;
        end
    else
        slide = 0.5;    % Default value
    end
% Seleccion de solapamiento predefinida    
else
    slide = overlap_selection.UserData;  % UserData contiene el desplazamiento ya calculado
end
