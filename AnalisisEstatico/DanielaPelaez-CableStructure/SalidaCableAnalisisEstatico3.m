function [Tmin] = SalidaCableAnalisisEstatico3(H,L,Wo,DT, Tmin, To, Tf, Tmax, Tten, Nten, S, Lo, Lf, DTo, DTf, str, x, y, A, B, D, wx, wy, ruta, nameFileUser, nameFileExperimento)               
    %%

    text_tiket=fopen([ruta nameFileUser],'wt');
    
    fprintf(text_tiket,[  '                                       "UNIVERSIDAD TÉCNICA PARTICULAR DE LOJA"                                    \n']);
    fprintf(text_tiket,[  '                                            TITULACIÓN DE INGENIERÍA CIVIL                                         \n']);
    fprintf(text_tiket,[  '                                   LABORATORIO VIRTUAL DE INGENIERÍA SÍSMICA (VLEE)                                \n']);
    fprintf(text_tiket,[  '                                                                                                                   \n']);
    fprintf(text_tiket,[  '                                                                                                                   \n']);
    fprintf(text_tiket,[  'LABORATORIO:      CABLES - STRUCTURES                                                                              \n']);
    fprintf(text_tiket,[  'EXPERIMENTO:      Análisis Estático de Cables con Cargas distribuidas uniformemente a lo largo de líneas rectas    \n']);
    fprintf(text_tiket,[  'CASO       :      3   : Ho=Hf : La flecha en el punto O es igual a la flecha del punto F                           \n']);
    fprintf(text_tiket,[  'FECHA      :      ' num2str(str) '\n']);
    fprintf(text_tiket,[  '                                                                                                                   \n']);
    fprintf(text_tiket,[  '                                                                                                                   \n']);
    fprintf(text_tiket,[  '-------------------------------------------------------------------------------------------------------------------\n']);
    fprintf(text_tiket,[  '                                                                                                                   \n']);
    fprintf(text_tiket,[  'DATOS DE ENTRADA                                                                                                   \n']);
    fprintf(text_tiket,[  '                                                                                                                   \n']);
    fprintf(text_tiket,[  '                                                                                                                   \n']);
    fprintf(text_tiket,[  '                   Detalle              |  Símbolo  |  Unidades |   Magnitud\n']);
    fprintf(text_tiket,[  '          ------------------------------|-----------|-----------|------------\n']);
    fprintf(text_tiket,[  '           Altura o flecha              |    H      |     m     |  ' num2str(H) '\n']);
    fprintf(text_tiket,[  '           Vano entre el punto O y F    |    L      |     m     |  ' num2str(L) '\n']);
    fprintf(text_tiket,[  '           Carga distribuida lìnea recta|    Wo     |     KN    |  ' num2str(Wo) '\n']);
    fprintf(text_tiket,[  '           Distancia entre tensores     |    Wo     |     m     |  ' num2str(DT) '\n']);
    fprintf(text_tiket,[  '                                                                                                                  \n']);
    fprintf(text_tiket,[  '------------------------------------------------------------------------------------------------------------------\n']);
    fprintf(text_tiket,[  '                                                                                                                  \n']);
    fprintf(text_tiket,[  'DATOS DE SALIDA                                                                                                   \n']);
    fprintf(text_tiket,[  '                                                                                                                  \n']);
    fprintf(text_tiket,[  '                                                                                                                  \n']);
    fprintf(text_tiket,[  '                   Detalle              |  Símbolo  |  Unidades |   Magnitud\n']);
    fprintf(text_tiket,[  '          ------------------------------|-----------|-----------|------------\n']);
    fprintf(text_tiket,[  '           Tensión mímima               |    Tmin   |     KN    |  ' num2str(Tmin) '\n']);
    fprintf(text_tiket,[  '           Tensión punto O              |    To     |     KN    |  ' num2str(To) '\n']);
    fprintf(text_tiket,[  '           Tensión punto F              |    Tf     |     KN    |  ' num2str(Tf) '\n']);
    fprintf(text_tiket,[  '           Tensión máxima               |    Tmax   |     KN    |  ' num2str(Tmax) '\n']);
    fprintf(text_tiket,[  '           Tensión en los Tensores      |    Tten   |     KN    |  ' num2str(Tten) '\n']);
    fprintf(text_tiket,[  '           Número de Tensores           |    Nten   |     #     |  ' num2str(Nten) '\n']);
    fprintf(text_tiket,[  '           Longitud del Cable           |    S      |     m     |  ' num2str(S) '\n']);
    fprintf(text_tiket,[  '           Distancia o vano punto O     |    Lo     |     m     |  ' num2str(Lo) '\n']);
    fprintf(text_tiket,[  '           Distancia o vano punto F     |    Lf     |     m     |  ' num2str(Lf) '\n']);
    fprintf(text_tiket,[  '           Dist. punto O y Tensor       |    DTo    |     m     |  ' num2str(DTo) '\n']);
    fprintf(text_tiket,[  '           Dist. punto F y Tensor       |    DTf    |     m     |  ' num2str(DTf) '\n']);
    fprintf(text_tiket,[  '                                                                                                                  \n']);
    fprintf(text_tiket,[  '                                                                                                                  \n']);
    fprintf(text_tiket,[  '------------------------------------------------------------------------------------------------------------------\n']);
    fclose(text_tiket);
    
    %%%_DATOS DE SALIDA PARA LA WEB
    text_tiket=fopen([ruta nameFileExperimento],'wt');
    text_tiket=fopen([ruta nameFileExperimento],'a');
    
    
    %fprintf(text_tiket,[  'DATOS DE SALIDA \n']);
    fprintf(text_tiket,[  'Tmin ' num2str(Tmin) '\n']);
    fprintf(text_tiket,[  'To ' num2str(To) '\n']);
    fprintf(text_tiket,[  'Tf ' num2str(Tf) '\n']);
    fprintf(text_tiket,[  'Tmax ' num2str(Tmax) '\n']);
    fprintf(text_tiket,[  'Tten ' num2str(Tten) '\n']);
    fprintf(text_tiket,[  'Nten ' num2str(Nten) '\n']);
    fprintf(text_tiket,[  'S ' num2str(S) '\n']);
    fprintf(text_tiket,[  'Lo ' num2str(Lo) '\n']);
    fprintf(text_tiket,[  'Lf ' num2str(Lf) '\n']);
    fprintf(text_tiket,[  'DTo ' num2str(DTo) '\n']);
    fprintf(text_tiket,[  'DTf ' num2str(DTf) '\n']);    

    %fprintf(text_tiket,[  'CABLE \n']);
    fprintf(text_tiket,['x' ' ']);
    dlmwrite([ruta nameFileExperimento],x,'-append','roffset', 0, 'delimiter', ' ', 'precision','%.4f')
    fprintf(text_tiket,['y' ' ']);
    dlmwrite([ruta nameFileExperimento],y,'-append','roffset', 0, 'delimiter', ' ', 'precision','%.4f') 
    %fprintf(text_tiket,[  'Tensores \n']);   
    fprintf(text_tiket,[  'xx' ' ']);
    dlmwrite([ruta nameFileExperimento],(A(1,:)),'-append','roffset', 0, 'delimiter', ' ', 'precision','%.4f')  
    fprintf(text_tiket,[  'yy' ' ']);
    dlmwrite([ruta nameFileExperimento],(B(1,:)),'-append','roffset', 0, 'delimiter', ' ', 'precision','%.4f')  
    fprintf(text_tiket,[  'yy' ' ']);
    dlmwrite([ruta nameFileExperimento],(D(1,:)),'-append','roffset', 0, 'delimiter', ' ', 'precision','%.4f') 
    %fprintf(text_tiket,[  'CARGA DISTRIBUIDA \n']);
    fprintf(text_tiket,[  'wx' ' ']);
    dlmwrite([ruta nameFileExperimento],(wx(1,:)),'-append','roffset', 0, 'delimiter', ' ', 'precision','%.4f')    
    fprintf(text_tiket,[  'wy' ' ']); 
    dlmwrite([ruta nameFileExperimento],(wy(1,:)),'-append','roffset', 0, 'delimiter', ' ', 'precision','%.4f')
    %fprintf(text_tiket,[  'CABLES-TENSORES-CARGA DISTRIBUIDORA\n']);
    
    fclose(text_tiket);
    
end

