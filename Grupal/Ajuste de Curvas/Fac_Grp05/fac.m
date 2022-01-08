function fac(varargin)
tic
% FAC Resuleve el ajuste de curvas
% <strong>Modos de entrada</strong>
% [X,Y,r] = FAC(M)
% [X,Y,r,Ec,Ea,Er] = FAC(M,m)
% [X,Y,r,Ec,Ea,Er,y] = FAC(M,m,x)
% 
% <strong>Valores de entrada</strong>
% <strong>M:</strong> Matriz de pares ordenados [xi;yi]
% <strong>m:</strong> Tipo de ajuste:
%   0 - Lineal
%   1 - Cuadratico
%   2 - Cubico
%   3 - Exponencial
% <strong>x:</strong> Valor a comprovar dentro del ajuste ya efectuado
%
% <strong>Valores de Salida</strong>
% <strong>X:</strong> Lista de puntos en x
% <strong>Y:</strong> Lista de puntos en y
% <strong>r:</strong> Coeficiente de correlacion -1 < r < 1
% <strong>Ec:</strong> Ecuacion nde regresion
% <strong>Ea:</strong> Error absoluto
% <strong>Er:</strong> Error relativo
% <strong>y:</strong>  Valor de Ec evaluado en x
M = varargin{1};
switch nargin
    case 1
        disp('fac(M)')
        coeficiente_correlacion(M)
        plot_points(M)
    case 2
        disp('fac(M,m)')
        switch varargin{2}
            case 0
                disp('Ajuste Lineal')
                lineal(M)
            case 1
                disp('Ajuste cuadratico')
                cuadratico(M)
            case 2
                disp('Ajuste cubico')
                cubico(M)
            case 3
                disp('Ajuste Exponencial')
                exponencial(M)
            otherwise
               fprintf(2,'<strong>Ingresa un Ajuste valido\n</strong>'); 
        end
    case 3
        disp('fac(M,m,x)')
        
        switch varargin{2}
            case 0
                disp('Ajuste Lineal')
                lineal(M)
            case 1
                disp('Ajuste cuadratico')
                cuadratico(M)
            case 2
                disp('Ajuste cubico')
                cubico(M)
            case 3
                disp('Ajuste Exponencial')
                exponencial(M)
            otherwise
               fprintf(2,'<strong>Ingresa un Ajuste valido\n</strong>'); 
        end
        
    otherwise
        fprintf(2,'<strong>Ingresa un modo valido \n</strong>');
end

    function lineal(M)
        disp(M)
        disp('Coef:')
        coeficiente_correlacion(M)
        plot_points(M)
        for i = 1:n
            x(i) = M(i,1);
            y(i) = M(i,2);
        end
        p = polyfit(x,y,1);
        disp(p)
    end

    function cuadratico(M)
        plot_points(M)
        [n,~] = size(M);

        for i = 1:n
            x(i) = M(i,1);
            y(i) = M(i,2);
        end
        p = polyfit(x,y,2);
        disp(p)
    end

    function cubico(M)
        plot_points(M)
        [n,~] = size(M);
        for i = 1:n
            x(i) = M(i,1);
            y(i) = M(i,2);
        end
        [p,S] = polyfit(x,y,3);
        [y_fit,delta] = polyval(p,x,S);
        plot(x,y_fit+2*delta,'m--',x,y_fit-2*delta,'m--')
        plot(x,y_fit,'r-')
        disp(p)
    end

    function exponencial(M)
        plot_points(M)
        [n,~] = size(M);
        for i = 1:n
            x1(i) = M(i,1);
            y1(i) = M(i,2);
        end
        Sx = sum(x1);
        Sy = sum(y1);
        Sx2 = sum(x1.^2);
        Ly = log(y1);
        SLy = sum(Ly);
        xLy = sum(x1.*Ly);
        A = [n Sx;Sx Sx2]
        B = [SLy;xLy]
        z = A\B
        b0 = exp(z(1));
        x = sym('x');       
        y = b0*exp(z(2)*x);
        disp(y)
        fplot(y);
        
    end

    function coeficiente_correlacion(M)
        [m,~] = size(M);%Obtenemos el tamanio de la matriz
        xmed=0;%inicualizamos las variables
        ymed=0;
        xymed=0;
        for i=1:m 
            xmedi=xmed+M(i,1);%sumatorio de coordenadas en x
            xmed=xmedi;
            ymedi=ymed+M(i,2);%sumatorio de coordenadas en y
            ymed=ymedi;
    
        end

        xmedia=xmed/m;%calculo de la media aritmetica para x
        ymedia=ymed/m;%calculo de la media aritmetica para y

        %Encero las variables
        xmed=0;
        ymed=0;
        xymed=0;

        for i=1:m
    
            Sx=xmed+((M(i,1)-xmedia)^2);%Sumatorio de la covarianza para x
            xmed=Sx;
    
            Sy=ymed+((M(i,2)-ymedia))^2;%Sumatorio de la covarianza para y
            ymed=Sy;
    
            Sxy=xymed+((M(i,1)-xmedia)*(M(i,2)-ymedia));%Sumatorio de la covarianza para xy
            xymed=Sxy;
    
        end

        p=Sxy/((Sx^(1/2))*(Sy^(1/2)));%Calculo del coeficiente de coorelacion
        disp(p)%imprimimos el resultado


    end
    
    function plot_points(M)
       [n,~] = size(M);
       
       for i = 1:1:n
           plot(M(i,1),M(i,2),'o','MarkerSize',4)
           hold on
       end
       grid on
       
    end
toc
end

