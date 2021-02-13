%Alfredo, Andrés, Juan Pablo, Miguel Cruz, Omar Yair
function Reverberation(nombre)
    [Audio,frec] = audioread(nombre+".wav"); %leer archivo wav y obtener las muestras del Audio junto con la frecuencia de mumestreo
    %la frecuencia de muestreo para un archivo .wav es de 44100 muestras/s
    Audio = Audio./max(abs(Audio)); %Normalización del audio 
    Audio_Length = size(Audio,1);  %cantidad de muestras

    %preguntar al usuario el tiempo de los impulsos y la amplitud 
    tiempo_impulso = 0.03;%tiempo de reflexión de audio, usualmente pequeño 
    disp(' Introducir magnitud de amplitud del impulso(valores encima de 3 podrian causar daños en los emisores de audio)')
    impulso_amplitud = input('');
    
    %Crear función con todos los impulsos en la duración especificada
    Imp_response = zeros(size(Audio,1),1);%crear un arreglo de datos de ceros de la misma longitud que el audio original
    Imp_response(tiempo_impulso*frec) = impulso_amplitud; %Crear impulsos diferentes de 0 de las muestras en la duración
    Imp_response2 = zeros(size(Audio,1),1);%crear un arreglo de datos de ceros de la misma longitud que el audio original
    Imp_response2((tiempo_impulso+0.03)*frec) = impulso_amplitud*impulso_amplitud; %función de impulso para efecto de reverberación 2
    Imp_response3 = zeros(size(Audio,1),1);%crear un arreglo de datos de ceros de la misma longitud que el audio original
    Imp_response3((tiempo_impulso+0.06)*frec) = impulso_amplitud*impulso_amplitud*impulso_amplitud; %función de impulso para efecto de reverberación 3
    
    
    %Convolución de audio con función de impulso h(t) es igual a la transformada
    %de fourier inversa de de la transformada de fourier de f(t) multiplicado por la transformada de fourier g(t)
    %h(t)=transofrmada inversa de H(t)=F(t)*G(t)
    Reverber_length = length(Audio) + length(Imp_response) - 1; %Intervalo para aplicar transformada de fourier 
    F_input    = fft(Audio, Reverber_length) ;  %;Transformada de fourier del audio
    F_impluse  = fft(Imp_response, Reverber_length); %;Transformada de fourier del la función de impulsos
    Audio_reverb = ifft(F_input.*F_impluse); %transofrmada inversa de F(t)*G(t), la convolución
    Audio_reverb = impulso_amplitud.*(Audio_reverb./max(abs(Audio_reverb))); %Normalización del audio con efecto de reverberación
    %Agregar segundo efecto de reverberación para obtneer más efecto en el
    %audio
    Reverber_length2 = length(Audio) + length(Imp_response2) - 1; %Intervalo para aplicar transformada de fourier 
    F_input2    = fft(Audio, Reverber_length2) ;  %;Transformada de fourier del audio
    F_impluse2  = fft(Imp_response2, Reverber_length2); %;Transformada de fourier del la función de impulsos
    Audio_reverb2 = ifft(F_input2.*F_impluse2); %transofrmada inversa de F(t)*G(t), la convolución
    Audio_reverb2 = impulso_amplitud.*(Audio_reverb2./max(abs(Audio_reverb2))); %Normalización del audio con efecto de reverberación
    %Agregar tercer efecto de reverberación para obtneer más efecto en el
    %audio
    Reverber_length3 = length(Audio) + length(Imp_response3) - 1; %Intervalo para aplicar transformada de fourier 
    F_input3    = fft(Audio, Reverber_length3) ;  %;Transformada de fourier del audio
    F_impluse3  = fft(Imp_response3, Reverber_length3); %;Transformada de fourier del la función de impulsos
    Audio_reverb3 = ifft(F_input3.*F_impluse3); %transofrmada inversa de F(t)*G(t), la convolución
    Audio_reverb3 = impulso_amplitud.*(Audio_reverb3./max(abs(Audio_reverb3))); %Normalización del audio con efecto de reverberación
    
  
    Audio_reverb_out(1:Audio_Length) =Audio_reverb3(1:Audio_Length)+Audio_reverb(1:Audio_Length)+ Audio_reverb2(1:Audio_Length) + Audio(1:Audio_Length); %agregar efecto de reverberación
    sound(Audio_reverb_out,frec) %Producir audio con efecto de reverberación
 
    
end
%Referencias:
%https://www.youtube.com/watch?v=d-QXxReQBxk