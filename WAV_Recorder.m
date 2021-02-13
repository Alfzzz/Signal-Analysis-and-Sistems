function WAV_Recorder(segundos, nombre)
    Aud = audiorecorder(44100,16,1); %se genera el objeto con la capacidad de grabacion 
    record(Aud,segundos); %le damos valores al objeto mediante la grabacion de longitud establecida
    disp('Recording in progress now ...')
while isrecording(Aud) == 1 %esperamos a que se termine de dar valores al objeto
    disp('Recording in progress now ...')
    %read
pause(1);
end
File = getaudiodata(Aud);File%se posicionan los valores del objeto en una matriz de formato Double
Arch = nombre + '.wav'; %se crea un string con el nombre del archivo
audiowrite(Arch,File,44100); %se guarda la matriz con el nombre estipulado y a una frecuencia de 44100hz
end

