%Alfredo,Andrés,Juan Pablo,Miguel Alejandro,Yair

%Segmento del código para crear la interfaz(líneas 5-49)
%No se comenta esta sección por falta de relevancia para la materia, pero
%es más amigable para que el usuario pruebe el funcionamiento
%:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
function varargout = proyecto(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @proyecto_dsp_OpeningFcn, ...
                   'gui_OutputFcn',  @proyecto_dsp_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin & isstr(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT
% --- Executes just before proyecto_dsp is made visible.

function proyecto_dsp_OpeningFcn(hObject, eventdata, handles, varargin)
%*-*-*-*-*CONDICIONES INICIALES-*-*-*-*-*-*-*-*-*
%Centrar la interfaz
movegui(hObject,'center')
%*******************
%Deshabilitar botones de mando
set(handles.reproducir,'Enable','off');
set(handles.pausa,'Enable','off');
set(handles.continuar,'Enable','off');
set(handles.parar,'Enable','off');
handles.output = hObject;
find_system('Name','modelo');%Buscar el modelo en el path
open_system('modelo');%Abrir el modelo
%valores iniciales para el modelo
set_param('modelo/volumen','Value','0.4') %inicializar volumen con 0.4
set_param('modelo/selector','Value','2'); %Inicilizar tipo de audio 2
% Valores iniciales de canales L y R
set_param('modelo/L','Gain','0.5'); 
set_param('modelo/R','Gain','0.5');
% Update handles structure
guidata(hObject, handles);
%*-*-*-*-*-FIN DE CONDICIONES INICIALES-*-*-*-*-*-*-

function varargout = proyecto_dsp_OutputFcn(hObject, eventdata, handles)
varargout{1} = handles.output;
%:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::



% *-------------E F E C T O S------------------------------
%Función de llamada para audio original
function tema_original_Callback(hObject, eventdata, handles)
%Reproducir tema original
set_param('modelo/selector','Value','2');% se selecciona la segunda opción del "Multiport Switch" dentro
%del esquematico de simulink  
set(handles.el_efecto,'String','Tema original')%Mostrar en la interfaz tipo de audio, "Tema original" en este caso

%Función de llamada para audio con ecualización
function ecualizador_Callback(hObject, eventdata, handles)
%Acrivar ecualizador
set_param('modelo/selector','Value','1');% se selecciona la primera opción del "Multiport Switch" dentro
set(handles.el_efecto,'String','Ecualizador')%Mostrar en la interfaz tipo de audio, "Ecualizador" en este caso

%**********************ECUALIZADOR--------------------------------
%Función de llamada para la primera banda de frecuencia(60-170Hz)
function freq1_Callback(h, eventdata, handles)
amplitud=get(h,'Value'); %Obtener de la barra de control de la primera banda de frecuencia el valor de la amplitud   
set_param('modelo/ecualizador/Gain','dB',num2str(amplitud));%Establecer la ganancia de la primera banda de frecuencia como la amplitud en el modelo
set(handles.indic_1,'String',round(amplitud));%Mostrar en el indicador correspondiente la amplitud de la  primera banda de frecuencia 

%Función de llamada para la segunda banda de frecuencia(170-310 Hz)
function freq2_Callback(h, eventdata, handles)
amplitud=get(h,'Value');%Obtener de la barra de control de la segunda banda de frecuencia el valor de la amplitud 
set_param('modelo/ecualizador/Gain1','dB',num2str(amplitud));%Establecer la ganancia de la segunda banda de frecuencia como la amplitud en el modelo
set(handles.indic_2,'String',round(amplitud));%Mostrar en el indicador correspondiente la amplitud de la segunda banda de frecuencia 

%Función de llamada para la tercera banda de frecuencia(310-600 Hz)
function freq3_Callback(h, eventdata, handles)
amplitud=get(h,'Value');%Obtener de la barra de control de la tercera banda de frecuencia el valor de la amplitud 
set_param('modelo/ecualizador/Gain2','dB',num2str(amplitud));%Establecer la ganancia de la tercera banda de frecuencia como la amplitud en el modelo
set(handles.indic_3,'String',round(amplitud));%Mostrar en el indicador correspondiente la amplitud de la tercera banda de frecuencia 

%Función de llamada para la cuarta banda de frecuencia(600-1k Hz)
function freq4_Callback(h, eventdata, handles)
amplitud=get(h,'Value');%Obtener de la barra de control de la cuarta banda de frecuencia el valor de la amplitud 
set_param('modelo/ecualizador/Gain3','dB',num2str(amplitud));%Establecer la ganancia de la cuarta banda de frecuencia como la amplitud en el modelo
set(handles.indic_4,'String',round(amplitud));%Mostrar en el indicador correspondiente la amplitud de la cuarta banda de frecuencia 

%Función de llamada para la quinta banda de frecuencia(1k-3k Hz)
function freq5_Callback(h, eventdata, handles)
amplitud=get(h,'Value');%Obtener de la barra de control de la quinta banda de frecuencia el valor de la amplitud 
set_param('modelo/ecualizador/Gain4','dB',num2str(amplitud));%Establecer la ganancia de la quinta banda de frecuencia como la amplitud en el modelo
set(handles.indic_5,'String',round(amplitud));%Mostrar en el indicador correspondiente la amplitud de la quinta banda de frecuencia 

%Función de llamada para la sexta banda de frecuencia(3k-6k Hz)
function freq6_Callback(h, eventdata, handles)
amplitud=get(h,'Value');%Obtener de la barra de control de la sexta banda de frecuencia el valor de la amplitud 
set_param('modelo/ecualizador/Gain9','dB',num2str(amplitud));%Establecer la ganancia de la sexta banda de frecuencia como la amplitud en el modelo
set(handles.indic_6,'String',round(amplitud));%Mostrar en el indicador correspondiente la amplitud de la sexta banda de frecuencia 

%Función de llamada para la septima banda de frecuencia(6k-12k Hz)
function freq7_Callback(h, eventdata, handles)
amplitud=get(h,'Value');%Obtener de la barra de control de la septima banda de frecuencia el valor de la amplitud 
set_param('modelo/ecualizador/Gain10','dB',num2str(amplitud));%Establecer la ganancia de la septima banda de frecuencia como la amplitud en el modelo
set(handles.indic_7,'String',round(amplitud));%Mostrar en el indicador correspondiente la amplitud de la septima banda de frecuencia 

%Función de llamada para la octava banda de frecuencia(12k-14k Hz)
function freq8_Callback(h, eventdata, handles)
amplitud=get(h,'Value');%Obtener de la barra de control de la octava banda de frecuencia el valor de la amplitud 
set_param('modelo/ecualizador/Gain11','dB',num2str(amplitud));%Establecer la ganancia de la octava banda de frecuencia como la amplitud en el modelo
set(handles.indic_8,'String',round(amplitud))%Mostrar en el indicador correspondiente la amplitud de la octava banda de frecuencia 

%Función de llamada para la novena banda de frecuencia(14k-16k Hz)
function freq9_Callback(h, eventdata, handles)
amplitud=get(h,'Value');%Obtener de la barra de control de la novena banda de frecuencia el valor de la amplitud 
set_param('modelo/ecualizador/Gain12','dB',num2str(amplitud));%Establecer la ganancia de la novena banda de frecuencia como la amplitud en el modelo
set(handles.indic_9,'String',round(amplitud));%Mostrar en el indicador correspondiente la amplitud de la novena banda de frecuencia 

%Función de llamada para la decima banda de frecuencia(14k-22k Hz)
function freq10_Callback(h, eventdata, handles)
amplitud=get(h,'Value');%Obtener de la barra de control de la decima banda de frecuencia el valor de la amplitud 
set_param('modelo/ecualizador/Gain13','dB',num2str(amplitud));%Establecer la ganancia de la decima banda de frecuencia como la amplitud en el modelo
set(handles.indic_10,'String',round(amplitud));%Mostrar en el indicador correspondiente la amplitud de la decima banda de frecuencia 
%*****************************************************************

%**********Control general****************************
%Función de llamada para el volumen de reproducción
function vol_Callback(h, eventdata, handles)
%Control del nivel de volumen de reproducción
volumenn=get(h,'Value');%Obtener el valor de volumen de la barra de control correspondiente 
set_param('modelo/volumen','Value',num2str(volumenn));%Establecer la ganancia del volumen general en el modelo
set(handles.indic_vol,'String',volumenn);%Mostrar en el indicador correspondiente el volumen general

%Función de llamada para el volumen de reproducción
function reproducir_Callback(hObject, eventdata, handles)
%Incia la simulación del modelo. Ejecuta START en el modelo--v
set_param(gcs,'SimulationCommand','Start');%Configurar 

%Función de llamada para el botón de pausa
function pausa_Callback(hObject, eventdata, handles)
%Pausar la simulación del modelo
set_param(gcs,'SimulationCommand','Pause')  %Permitir que el botón de "Pausa" en la interfaz pause la ejecución de simulación

%Función de llamada para el botón de continuar
function continuar_Callback(hObject, eventdata, handles)
%Continuar la simulación del modelo
set_param(gcs,'SimulationCommand','Continue')%Permitir que el botón de "Continuar" en la interfaz continúe la ejecución de simulación

%Función de llamada para el botón de detener audio
function parar_Callback(hObject, eventdata, handles)
%Detener la simulación del modelo
set_param(gcs,'SimulationCommand','Stop')%Permitir que el botón de "Parar" en la interfaz detenga la ejecución de simulación

%Función de llamada para abrir archivo de audio(tema)
function abrir_tema_Callback(h, eventdata, handles)
%Abrir el tema a reproducir
[nombre ruta]=uigetfile('*.wav','Seleccione el tema');%Obtener nombre y dirección del archivo .wav a seleccionar
if nombre == 0% Si se selecciona CANCELAR
    return
end
%La siguiente línea establece el nombre del tema en simulink
%en el bloque que reproduce la canción en formato.wav
set_param('modelo/From Wave File','FileName',fullfile(ruta,nombre));%Establecer el audio seleccionado de la interfaz en el modelo
%Habilitar los botones de mando
set(handles.reproducir,'Enable','on');
set(handles.pausa,'Enable','on');
set(handles.continuar,'Enable','on');
set(handles.parar,'Enable','on');
%*******************************************************

%Función de llamada para quitar el audio seleccionado de la interfaz
function figure1_DeleteFcn(hObject, eventdata, handles)
%Parar la simulación si se cierra la interfaz
try
set_param(gcs,'SimulationCommand','Stop')%Detiene la simulación
save_system%Guarda los cambios en el sistema
close_system('modelo.mdl')%Cierra el modelo
catch
end


% --- Executes on selection change in popupmenu1.

%Función de llamada el menú que permite seleccionar configuración del
%ecualizador
function popupmenu1_Callback(hObject, eventdata, handles)
%Acrivar ecualizador
set_param('modelo/selector','Value','1');   %Cambiar canal de audio al que tenga ecualización
set(handles.el_efecto,'String','Ecualizador')   %Mostrar que se está usando el ecualizador en la interfaz

val= get(hObject,'Value');  %Obter el valor del menú que se selccionó

%Configuración del ecualizador de acuerdo a la opción seleccionada en el menu 
switch val
    case 1
        preset=[5,3,-2,-3,-1,1,5,6,6,6]; % Rock
    case 2
        preset=[0,0,0,0,0,0,-4,-4,-4,-6]; %Clásico
    case 3
        preset=[-4,0,3,3,3,3,3,1,1,1]; % Live
    case 4
        preset=[-1,1,2,2,1,-1,-1,-1,-1,-1];%Pop
    case 5
        preset=[4,3,0,-2,-2,0,4,5,5,5];%Techno
    case 6
        preset=[2,1,-1,-1,0,1,3,4,4,6];%Soft
    case 7
        preset=[6,6,6,4,0,-2,-5,-7,-7,-7];%Full bass
    case 8
        preset=[-7,-7,-7,-2,1,6,12,12,12,12];%Full Treble
    otherwise
        preset=[0,0,0,-2,0,2,2,0,0,0];%Reggae
end
%Establecer cada ganancia en las barras de control de cada banda de frecuencia 
set(handles.freq1,'Value',preset(1));
set(handles.freq2,'Value',preset(2));
set(handles.freq3,'Value',preset(3));
set(handles.freq4,'Value',preset(4));
set(handles.freq5,'Value',preset(5));
set(handles.freq6,'Value',preset(6));
set(handles.freq7,'Value',preset(7));
set(handles.freq8,'Value',preset(8));
set(handles.freq9,'Value',preset(9));
set(handles.freq6,'Value',preset(10));

%Llamar cada función de llamda de las bandas de frecuencia para actualizar
%su valor de ganancia
freq1_Callback(handles.freq1, eventdata, handles)
freq2_Callback(handles.freq2, eventdata, handles)
freq3_Callback(handles.freq3, eventdata, handles)
freq4_Callback(handles.freq4, eventdata, handles)
freq5_Callback(handles.freq5, eventdata, handles)
freq6_Callback(handles.freq6, eventdata, handles)
freq7_Callback(handles.freq7, eventdata, handles)
freq8_Callback(handles.freq8, eventdata, handles)
freq9_Callback(handles.freq9, eventdata, handles)
freq10_Callback(handles.freq6, eventdata, handles)




% VOLUMEN DE CANALES L Y R
% --- CANAL L
%Función de llamada para el volumen izquierdo
function L_slider_Callback(hObject, eventdata, handles)
volumenn=get(hObject,'Value');%Obtener el volumen izquiero de la barra de control correspondiente  
set_param('modelo/L','Gain',num2str(volumenn));%Establecer la ganancia del volumen izquierdo general en el modelo
set(handles.indic_L,'String',volumenn);%Mostrar en el indicador correspondiente el volumen izquierdo 

% --- CANAL R
%Función de llamada para volumen derecho
function R_slider_Callback(hObject, eventdata, handles)
%Control del nivel de volumen de reproducciÃ³n
volumenn=get(hObject,'Value');%Obtener el volumen derecho de la barra de control correspondiente 
set_param('modelo/R','Gain',num2str(volumenn));%Establecer la ganancia del volumen derecho general en el modelo
set(handles.indic_R,'String',volumenn);%Mostrar en el indicador correspondiente el volumen derecho correspondiente 


% Programa original:
% http://www.mathworks.com/matlabcentral/fileexchange/3719-simulink-stereo-player-featuring-vocal-remover
% Desarrollado por: Ansuman Barik

% Trabajo basado en el programa de Diego Barragán en http://www.matpic.com/esp/matlab/ecualizador.html



