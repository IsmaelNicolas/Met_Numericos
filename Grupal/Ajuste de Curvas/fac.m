function fac(varargin)
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

switch nargin
    case 1
        disp('fac(M)')
        
    case 2
        disp('fac(M,m)')
        switch varargin{2}
            case 0
                disp('Ajuste Lineal')
            case 1
                disp('Ajuste cuadratico')
            case 2
                disp('Ajuste cubico')
            case 3
                disp('Ajuste Exponencial')
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
    end

    function cuadratico(M)
        disp(M)
    end

    function cubico(M)
        disp(M)
    end

    function exponencial(M)
        disp(M)
    end
end

