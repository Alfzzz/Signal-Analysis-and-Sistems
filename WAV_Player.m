function WAV_Player(nombre)
    [Audio,frec] = audioread(nombre+".wav"); %se mandan a llamar tanto a la matriz como a frecuencia a la que fue grabada
    soundsc(Audio,frec); % se reproducen los datos en forma de audio a la frecuencia llamada
    plot(Audio);
end
