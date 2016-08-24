function [] = ProgramaMasterCablesStructures(ruta)
    ruta='C:\vlee\analisis_estatico\';
    nombreArchivo='input.txt';
    nameFileUser = 'outputUser.txt';
    nameFileExperimento = 'outputExperimento.txt';
    fid =fopen([ruta nombreArchivo ],'r');
    formato='%f32';
    ma=textscan(fid,formato);
    c1=ma{1}; % c1=columna #2 de la matriz ma
   
    %%
    switch c1(1)
        case 1
            [Ho,Hf,L,Wo,DT] = LeerCableAnalisisEstatico1 (ruta, nombreArchivo);
            [Ho,Hf,L,Wo,DT, Tmin, To, Tf, Tmax, Tten, Nten, S, Lo, Lf, DTo, DTf, str, x, y, A, B, D, wx, wy] = CableAnalisisEstatico1(Ho,Hf,L,Wo,DT);
            [Tmin] = SalidaCableAnalisisEstatico1(Ho,Hf,L,Wo,DT, Tmin, To, Tf, Tmax, Tten, Nten, S, Lo, Lf, DTo, DTf, str, x, y, A, B, D, wx, wy, ruta, nameFileUser, nameFileExperimento);  
        case 2
            [Ho,Hf,L,Wo,DT] = LeerCableAnalisisEstatico2 (ruta, nombreArchivo);
            [Ho,Hf,L,Wo,DT, Tmin, To, Tf, Tmax, Tten, Nten, S, Lo, Lf, DTo, DTf, str, x, y, A, B, D, wx, wy] = CableAnalisisEstatico2(Ho,Hf,L,Wo,DT);
            [Tmin] = SalidaCableAnalisisEstatico2(Ho,Hf,L,Wo,DT, Tmin, To, Tf, Tmax, Tten, Nten, S, Lo, Lf, DTo, DTf, str, x, y, A, B, D, wx, wy, ruta, nameFileUser, nameFileExperimento);  
        case 3
            [H,L,Wo,DT] = LeerCableAnalisisEstatico3 (ruta, nombreArchivo);
            [H,L,Wo,DT, Tmin, To, Tf, Tmax, Tten, Nten, S, Lo, Lf, DTo, DTf, str, x, y, A, B, D, wx, wy] = CableAnalisisEstatico3(H,L,Wo,DT);
            [Tmin] = SalidaCableAnalisisEstatico3(H,L,Wo,DT, Tmin, To, Tf, Tmax, Tten, Nten, S, Lo, Lf, DTo, DTf, str, x, y, A, B, D, wx, wy, ruta, nameFileUser, nameFileExperimento); 

    end
    fclose(fid);
    
    % Cierra todas las ventanas con gráficos
    %close
end


