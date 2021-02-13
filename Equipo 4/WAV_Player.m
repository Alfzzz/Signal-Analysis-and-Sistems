function WAV_Player(nombre)
    [Audio,frec] = audioread(nombre+".wav"); %se mandan a llamar tanto a la matriz como a frecuencia a la que fue grabada mediante la funcion audioread(archivo)
    soundsc(Audio,frec); % se reproducen los datos en forma de audio a la frecuencia llamada mediante la funcion soundsc(array,frecuencia)
    plot(Audio);
end
