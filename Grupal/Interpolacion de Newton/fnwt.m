function varargout = fnwt(varargin)
% FNWT resuelve problemas de interpolacion de puntos
% <strong>Modos de entrada</strong>
% [Pn,Rt] = FNWT(A)
% [Pn,Rt] = FNWT(A,x)
%
% <strong>Valores de salida</strong>
% <strong>A:</strong> Matriz 2xN con los pares oredenados
% <strong>x:</strong> Valor numerico a evaluar
%
% <strong>Valores de Salida</strong>
% <strong>Pn:</strong> Polinomio interpolador
% <strong>Rt:</strong> Error residual
% 
% <strong>Nota:</strong>
% En caso del [Pn,Rt] = FNWT(A) se devolvera de 
% manera  algebraica y en el [Pn,Rt] = FNWT(A,x)
% como valor numerico
tic
A = varargin{1};

if nargout == 0
    fprintf(2,'<strong>No tiene parametros de salida\n</strong>');
end

switch nargin
    
    case 1
       [varargout{1},varargout{2}] = newton(A);
    case 2
        x = varargin{2};
        [varargout{1},varargout{2}] = evaluar(A,x);
    otherwise
        fprintf(2,'<strong>Ingresa un Ajuste valido\n</strong>');
        
end


    function [Pn,Rt] = newton(A)
        A = A';
        disp(A)
        Pn = 0;
        Rt = 1;
    end

    function [Pn,Rt] = evaluar(A,x)
        [Pn,Rt] = newton(A);
        disp(x)
        disp(Pn)
        disp(Rt)
    end
    
toc
end

