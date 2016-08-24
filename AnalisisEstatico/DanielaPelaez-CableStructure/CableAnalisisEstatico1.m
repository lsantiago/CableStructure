function [Ho,Hf,L,Wo,DT, Tmin, To, Tf, Tmax, Tten, Nten, S, Lo, Lf, DTo, DTf, str, x, y, A, B, D, wx, wy] = CableAnalisisEstatico1(Ho,Hf,L,Wo,DT)

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %                                ANÁLISIS ESTÁTICO DE CABLES                                %
    %          CARGAS DISTRIBUIDAS UNIFORMEMENTE A LO LARGO DE LINEAS RECTAS                    %
    %                                                                                           %
    % Un cable suspendido está sometido a una carga vertical distribuida uniformemente en toda  %
    % su longitud. El origen del sistema coordenado se encuentra en el punto másbajo del cable. %
    % La curva descrita por el cable es la catenaria.                                           %
    %                                                                                           %
    %                         CASO 1:   Ho<Hf                                                   %
    %                                                                                           %
    %                [Tmin To Tf Tmax Tten S] = CCDULLR1(Ho,Hf,L,Wo,DT)                         %
    %                                                                                           %
    %   Variables de entrada:                                                                   %
    %                                                                                           %
    %  Ho   = Es la altura desde el punto más bajo del cable hasta el punto O        (m)        %
    %  Hf   = Es la altura desde el punto más bajo del cable hasta el punto F        (m)        %
    %  L    = Es la distacia o el vano entre el punto O y el punto F                 (m)        %
    %  Wo   = Es la carga distribuida uniformemente a lo largo de líneas rectas      (KN/m)     %
    %  DT   = Distancia entre los tensores                                           (m)        %
    %                                                                                           %
    %   Variables de salida:                                                                    %
    %                                                                                           %
    %  To   = Tensión en el punto O                                                  (KN)       %
    %  Tf   = Tensión en el punto F                                                  (KN)       %
    %  Tmax = Es la tensión máxima entre la tensión del punto O y punto F            (KN)       %
    %  Tmin = Tensión en el punto mas bajo del cable, cuando la pendiente es 0       (KN)       % 
    %  Tten = Tensión en los tensores del cable                                      (KN)       %
    %  S    = La longitud del cable medida desde el punto O hasta el punto F         (m)        %  
    %  Lo   = Es la distancia entre punto màs bajo del cable hasta el punto O        (m)        %  
    %  Lf   = Es la distancia entre punto màs bajo del cable hasta el punto F        (m)        % 
    %  DTo  = Es la distancia entre el primer tensor y el punto O                    (m)        %
    %  DTf  = Es la distancia entre el último tensor y el punto F                    (m)        %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



    %%

    %---------------Desarrollo del Análisis----------------

    %La curva descrita por el cable es la parábola  Y=1/2*a*x^2: por lo tanto
    %entre dos puntos para conocer la distancia x es: a*x^2+b*x+c=0 
    a=1-Hf/Ho;
    b=2*L;
    c=L^2;
    d=b^2-4*a*c;
    if d>0
        x1=(-b+sqrt(d))/(2*a);
        x2=(-b-sqrt(d))/(2*a);
        %disp('valor positivo de la raiz')
    elseif d==0
        x1=-b/(2*a);
        x2=-b/(2*a);
        %disp('la raiz vale 0')
    else 
        x1=(-b+1i*sqrt(-d))/(2*a);
        x2=(-b-1i*sqrt(-d))/(2*a);
        %disp('la raiz es negativa')
    end
    %disp('valores de la ecuación de segundo grado:')
    x1;x2;
    %Lo: es la distancia entre el punto inicial hasta el punto con de máxima deformación x (-)
    Lo=x1;
    %Lf: es la distancia desde el punto con de máxima deformación hasta el punto final x (+)
    Lf=L+Lo;
    %a=es un parámetro.
    u=2*Ho/Lo^2;
    % Tmin: es la tensión en el cable en el punto con de máxima deformación 
    Tmin=Wo/u;
    % To: es la tensión en el cable en el punto inical.
    To=Tmin*sqrt(1+u^2*Lo^2);
    % Tf: es la tensión en el cable en el punto final.
    Tf=Tmin*sqrt(1+u^2*Lf^2);
    % Tmax: es la tensión máxima en el cable.
    Tmax=max(To,Tf);
    % Tten: es la tension en los tensores.
    Tten=Wo*DT; 
    % Nten: es el numero de tensores en toda la longitud del cable.
    Nten=floor(L/DT);
    % Dto: es la distancia entre el punto inicial y el primer tensor.
    DTo=(L-(Nten-1)*DT)/2;
    % Dtf: es la distancia entre el último tensor y el punto final.
    DTf=DTo;
    % So: Longitud desde el punto inicial al punto con de máxima deformaciòn.
    So=abs(1/2*(Lo*sqrt(1+u^2*Lo^2)+1/u*log(u*Lo+sqrt(1+u^2*Lo^2))));
    % Longitud desde el punto con de máxima deformaciòn hasta el punto final.
    Sf=abs(1/2*(Lf*sqrt(1+u^2*Lf^2)+1/u*log(u*Lf+sqrt(1+u^2*Lf^2))));
    % Longitud total del cable.
    S=So+Sf;

        %%

    %-----------------FIGURAS-GRAFICAS-----------------

    % El CABLE

    %La curva descrita por el cable es la parábola y=1/2*a*x^2 donde: y=Ho x=Lo
    u=2*Ho/Lo^2;
    % x: coordenadas en x para el cable limites [Lo,Lf]
    x=[Lo:0.05:Lf];
    % y: ecuación de la  la curva descrita por el cable es la parábola en funcion de x
    y=u/2*x.^2;
    
    %subplot(221),plot(x,y,'K')
    %grid on;
   
    % generar una gráfica en done la curva tiene un estilo de sombra
    
    %hline1 = plot(x,y,'K');
    %ax = gca;
    %hline2 = line(x+.06,y,...
    %   'LineWidth',4,...
    %   'Color',[.5 .5 .5],...
    %   'Parent',ax);
    %set(gca,'Children',[hline1 hline2])
    
    %axis off
    
    %title('CABLE');
    
    
    %%
    %  FIGURA DE LOS TENSORES


         %Determinación de los datos o puntos en "Y"

    % Es un proceso repetitivo hasta el número de tensores    
    b=Nten;
    bcol=1;
    B=ones(b,bcol);
    for p=1:Nten
        B(p)=-DT;
    end
    B;
    nrows =Nten;
    ncols =1;
    A= ones(nrows,ncols);
    dy=DT;
    DTY=dy;
    for r = 1:nrows
            if r == 1
                xxy=Lo+DTo;
                yy=u/2*(xxy)^2;
                A(r) =yy;
            elseif r>=2 && r< Nten
                for v=2:r
                    if v==2
                       pty=DTo+DTY;
                       DTY=pty;
                    elseif v>2
                        DTY=pty+dy-DTo;
                    end 
                end
                xxy=Lo+DTY;
                yy=u/2*(xxy)^2;
                A(r) =yy;
            else r=Nten;
            xxy=Lf-DTf;
                yy=u/2*(xxy)^2;
                A(r) =yy;    
            end
    end
     A;

     % C: es una matriz de los tensores que corresponde a la primera fila datos
     % de y (en la curva) y en la segunda fila datos de y (en la línea recta)
     %C=horzcat(A,B);


         %Determinacion de los datos de "X"


    % Es un proceso repetitivo hasta el número de tensores  
    drows=Nten;
    dcol=1;
    D=ones(drows,dcol);
    dx=DT;
    DTX=dx;
    for rx = 1:drows
            if rx == 1
                xxx=Lo+DTo;
                D(rx) =xxx;
            elseif rx>=2 && rx< Nten
                for vx=2:rx
                    if vx==2
                       ptx=DTo+DTX;
                       DTX=ptx;
                    elseif vx>2
                        DTX=ptx+dx-DTo;
                    end 
                end
                xxx=Lo+DTX;
                D(rx) =xxx;
            else rx=Nten;
            xxx=Lf-DTf;
                D(rx) =xxx;   
            end
    end
      D;
      
      %()
      A=A';
      B=B';
      D=D';

    % E: es una matriz de los tensores que corresponde a la primera fila datos
    % de x (en la curva) y en la segunda fila datos de x (en la línea recta) 
    %E=horzcat(D,D);

    % xx: son las coordenadas en x 
    %xx=E';
    % yy: son las coordenas en y
    %yy=C';

    %subplot(222),plot(xx,yy,'r')
    %title('TENSORES');
    %axis off 
    %%

    %figura la carga distribuida


    % Do: es un paràmetro
    Do=(Hf-Ho)*4/5; 
    % wx: es la cordenada x para graficar la carga distribuida
    wx=[Lo Lf Lf Lo];
    % wy: es la coordenada y para graficar la carga distribuida
    wy=[-DT -DT -Do -Do];

    %subplot(223),plot(wx,wy,'B')
    %title('CARGA DISTRIBUIDA');
   
    %limites de la grafica

    %wxmin=Lo-DT/2;
    %wxmax=Lf+DT/2;
    %wymin=-(Do+DT/2);
    %wymax=0;
    %axis([wxmin wxmax wymin wymax])
    %patch(wx,wy,'r')
    %axis off
    
    %%
    % Todas las Graficas

    %subplot(224),plot(x,y,'k',xx,yy,'r',wx,wy,'B')
    %title('CABLE - TENSORES - CARGA DISTRIBUIDA');
    %patch(wx,wy,'r')
    %axis([-L+Lf-DT/2 Lf+DT/2 -Do-DT Hf])
    %axis off


    %%
    %denominación de la herramienta : programa 1

    Programa=1;
    %%
    % fecha y hora
       str = datestr(now);

end





