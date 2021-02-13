

function RecorderAndPlayer(segundos)

    A = audiorecorder(44100,16,1); %canal mono debido al hardware de la pc
    record(A,segundos);
    disp('Recording in progress now ...')
while isrecording(A) == 1
    disp('Recording in progress now ...')
pause(1);
end
Obj_Recorder2(A);
end

function Obj_Recorder2(A)
    disp('Playing in progress now ...')
    Obj= getplayer(A);
    play(Obj,44100);
while isplaying(Obj) == 1
    disp('Playing in progress now ...')
pause(1);
end
   
end

