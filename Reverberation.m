%Alfredo, Andr�s, Juan Pablo, Miguel Cruz, Omar Yair
function Reverberation(nombre)
    [Audio,frec] = audioread(nombre+".wav"); %leer archivo wav y obtener las muestras del Audio junto con la frecuencia de mumestreo
    %la frecuencia de muestreo para un archivo .wav es de 44100 muestras/s
    Audio = Audio./max(abs(Audio)); %Normalizaci�n del audio 
    Audio_Length = size(Audio,1);  %cantidad de muestras

    %preguntar al usuario el tiempo de los impulsos y la amplitud 
    tiempo_impulso = 0.03;%tiempo de reflexi�n de audio, usualmente peque�o 
    disp(' Introducir magnitud de amplitud del impulso(valores encima de 3 podrian causar da�os en los emisores de audio)')
    impulso_amplitud = input('');
    
    %Crear funci�n con todos los impulsos en la duraci�n especificada
    Imp_response = zeros(size(Audio,1),1);%crear un arreglo de datos de ceros de la misma longitud que el audio original
    Imp_response(tiempo_impulso*frec) = impulso_amplitud; %Crear impulsos diferentes de 0 de las muestras en la duraci�n
    Imp_response2 = zeros(size(Audio,1),1);%crear un arreglo de datos de ceros de la misma longitud que el audio original
    Imp_response2((tiempo_impulso+0.03)*frec) = impulso_amplitud*impulso_amplitud; %funci�n de impulso para efecto de reverberaci�n 2
    Imp_response3 = zeros(size(Audio,1),1);%crear un arreglo de datos de ceros de la misma longitud que el audio original
    Imp_response3((tiempo_impulso+0.06)*frec) = impulso_amplitud*impulso_amplitud*impulso_amplitud; %funci�n de impulso para efecto de reverberaci�n 3
    
    
    %Convoluci�n de audio con funci�n de impulso h(t) es igual a la transformada
    %de fourier inversa de de la transformada de fourier de f(t) multiplicado por la transformada de fourier g(t)
    %h(t)=transofrmada inversa de H(t)=F(t)*G(t)
    Reverber_length = length(Audio) + length(Imp_response) - 1; %Intervalo para aplicar transformada de fourier 
    F_input    = fft(Audio, Reverber_length) ;  %;Transformada de fourier del audio
    F_impluse  = fft(Imp_response, Reverber_length); %;Transformada de fourier del la funci�n de impulsos
    Audio_reverb = ifft(F_input.*F_impluse); %transofrmada inversa de F(t)*G(t), la convoluci�n
    Audio_reverb = impulso_amplitud.*(Audio_reverb./max(abs(Audio_reverb))); %Normalizaci�n del audio con efecto de reverberaci�n
    %Agregar segundo efecto de reverberaci�n para obtneer m�s efecto en el
    %audio
    Reverber_length2 = length(Audio) + length(Imp_response2) - 1; %Intervalo para aplicar transformada de fourier 
    F_input2    = fft(Audio, Reverber_length2) ;  %;Transformada de fourier del audio
    F_impluse2  = fft(Imp_response2, Reverber_length2); %;Transformada de fourier del la funci�n de impulsos
    Audio_reverb2 = ifft(F_input2.*F_impluse2); %transofrmada inversa de F(t)*G(t), la convoluci�n
    Audio_reverb2 = impulso_amplitud.*(Audio_reverb2./max(abs(Audio_reverb2))); %Normalizaci�n del audio con efecto de reverberaci�n
    %Agregar tercer efecto de reverberaci�n para obtneer m�s efecto en el
    %audio
    Reverber_length3 = length(Audio) + length(Imp_response3) - 1; %Intervalo para aplicar transformada de fourier 
    F_input3    = fft(Audio, Reverber_length3) ;  %;Transformada de fourier del audio
    F_impluse3  = fft(Imp_response3, Reverber_length3); %;Transformada de fourier del la funci�n de impulsos
    Audio_reverb3 = ifft(F_input3.*F_impluse3); %transofrmada inversa de F(t)*G(t), la convoluci�n
    Audio_reverb3 = impulso_amplitud.*(Audio_reverb3./max(abs(Audio_reverb3))); %Normalizaci�n del audio con efecto de reverberaci�n
    
  
    Audio_reverb_out(1:Audio_Length) =Audio_reverb3(1:Audio_Length)+Audio_reverb(1:Audio_Length)+ Audio_reverb2(1:Audio_Length) + Audio(1:Audio_Length); %agregar efecto de reverberaci�n
    sound(Audio_reverb_out,frec) %Producir audio con efecto de reverberaci�n
 
    
end
%Referencias:
%https://www.youtube.com/watch?v=d-QXxReQBxk