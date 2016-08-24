function [Ho,Hf,L,Wo,DT] = LeerCableAnalisisEstatico1 (ruta, nombreArchivo)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % La presente función nos permite leer los datos de entrada referente a la %
    % función de CableAnalisisEstatico1, que hace referencia al Análisis       %
    % Estático de Cables con Cargas distribuidas uniformemente a lo largo de   %
    % líneas rectas cuando Ho<Hf.                                              %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Nomenclatura 
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % ma= Matriz de "n" datos ingresados en el archivo txt.                    %
    % Para crear una columna mas en el archivo txt lo realizamos de la siguien-%
    % te manera:                                                               %
    % c1=ma{1} donde c1= número de columna; m{1}=posicion de la columna        %
    % c1(1)= c1=posición (columna 1); (1)=posición de la fila, entonces        %
    % c1(1)= "posiciones" (columna 1 fila 1)                                   %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%
    %%%%%%%%%%%%%%%%%%%%%%% PROGRAMACIÓN %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Codigo lee archivo txt.
    %ruta='C:\Users\DELL i7\Dropbox\SHARED-DANIELA-PELAEZ\DanielaPelaez-CableStructure\REVISAR-CAMBIOS'
    %nombreArchivo='input.txt';
    %%
    
    fid =fopen([ruta nombreArchivo ],'r');
    formato='%f32';
    ma=textscan(fid,formato);
    c1=ma{1}; % c1=columna #1 de la matriz ma
    Ho=c1(2);
    Hf=c1(3);
    L=c1(4);
    Wo=c1(5);
    DT=c1(6);
    fclose(fid);
end       

