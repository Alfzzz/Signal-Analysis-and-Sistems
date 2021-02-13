%Alfredo, Andrés, Juan Pablo, Miguel Cruz, Omar Yair

function Echo(nombre)   %introduzca en la ventana de comandos Echo("pez") como ejemplo para correr función
    [Audio,frec] = audioread(nombre+".wav"); %leer archivo wav y obtener las muestras del Audio junto con la frecuencia de muestreo
    %la frecuencia de muestreo para un archivo .wav es de 44100 muestras/s
    Audio_Length = size(Audio,1);   %cantidad de muestras
    subplot(3,1,1); %crear un cuadro con tres gráficas y posicionar la primer gráfica en el lugar 1 
    plot((((1:Audio_Length) -1)/frec),Audio); %Graficar audio original
    title('Audio original')    
    ylabel('Amplitud')
    s=Audio(:,1);   %datos de audio original 
    t=zeros(size(Audio,1),1);   %crear un arreglo de datos de ceros de la misma longitud que el audio original
    %cada impulso es un efecto del echo y se decrementa la magnitud
    t(1)=1;    %echo en t=1/44100=22.6ms, audio original
    t(20000)=0.8; %echo en t=20000/44100=454ms 
    t(40000)=0.6; %echo en t=40000/44100=907ms
    t(60000)=0.4; %echo en t=60000/44100=1.36s
    t(80000)=0.2; %echo en t=80000/44100=1.8s
    subplot(3,1,2)  %posicionar la siguiente gráfica en el lugar 2
    plot((((1:Audio_Length) -1)/frec),t); %Graficar impulsos
    title('función de impulsos')    
    xlabel('Tiempo')
    ylabel('Amplitud')
    Audio_echo=conv(s,t);    %convolución del audio original con la función que contiene todos los impulsos
    subplot(3,1,3); %posicionar la siguiente gráfica en el lugar 3
    plot(Audio_echo) %graficar resultado de la convolución, audio con efecto de ech
    sound(Audio_echo,44100)  %reproducir audio con efecto de echo
end
%referencias:
%https://www.youtube.com/watch?v=vmiRcJNJKAw