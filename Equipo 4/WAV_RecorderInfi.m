
function WAV_RecorderInfi(nombre)
    check = 0;
    Aud = audiorecorder(44100,16,1); %se genera el objeto con la capacidad de grabacion con una frecuencia de muestreo de 44100Hz, registrando valores en una extension de 8bit en monocanal(caracteristicas propias del formato WAV a excepcion del multicanal).
    record(Aud); %se dan valores al objeto por cada muestreo al iniciar la grabacion
    disp('Recording in progress now ...')
while check ~= 1 %esperamos a que el usuario decida terminar la grabacion
    disp('Presione 1 en la terminal y dar Enter para terminar la grabacion ')
    check = input("");
    if(check == 1)
        break
    end
pause(1);
end
pause(Aud); %detenemos la grabacion
File = getaudiodata(Aud); %se posicionan los valores del objeto en una matriz de formato Double mediante el uso de la funcion getaudiodata(Objeto)
Arch = nombre + '.wav'; %se crea un string con el nombre del archivo
audiowrite(Arch,File,44100); %se guarda la matriz con el nombre estipulado y a una frecuencia de 44100hz
end
