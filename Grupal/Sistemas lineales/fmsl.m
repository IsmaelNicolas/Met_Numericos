function fmsl(varargin)
% FMSL resuelve un sistema de ecuaciones NxN
%
% [AX=B,Ea,Er] = FMSL(A,B,m,f)
% [AX=B,Ea,Er,Ec] = FMSL(A,B,m,f,n)
% [AX=B,Ea,Er,n] = FMSL(A,B,m,f,Ec)
%
% A: Una matriz NxN
% B: Una matriz 1xN
% m: El metodo para resolver el sistema (Integer)
%   0 - Gauss 
%   1 - Gauss - Jordan 
%   2 - Gauss - Sediel
%   3 - Descomposicion LU 
%   4 - Matriz Inversa
%   5 - Todos los metodos 
%
% f: Formato de decimales (Integer o String)
%   0 - Short - 4 decimales
%   1 - Long - 15 decimales
%   2 - Bank - 2 decimales
%   3 - Rad - Fraccion
%   'eng' - Notacion Cientifica
%
% n: Numero de iteraccion para Gauss- Sediel(Integer)
% Ec: Error de calculo para Gauss- Sediel(Real)

switch nargin
    case 4
       fprintf('fmsl(A,B,m,f)\n');
        switch varargin{3}
            case 0
                fprintf('<strong>Gauss</strong>');
                Gauss(varargin{1},varargin{2})
            case 1
                fprintf('<strong>Gauss-Jordan</strong>');
                GaussJordan(varargin{1},varargin{2})
            case 2
                fprintf('<strong>Gauss-Sediel</strong>');
                GaussSediel(varargin{1},varargin{2},varargin{5})
            case 3
                fprintf('<strong>Descomposicion LU</strong>');
                DescomposicionLu(varargin{1},varargin{2});
            case 4
                fprintf('<strong>Matriz Inversa</strong>');
                MatrizInversa(varargin{1},varargin{2});
            case 5
                fprintf('<strong>Todos los metodos</strong>');
            otherwise
                clc;
                fprintf(2,'<strong>Ingresa un metodo valido \n</strong>');
        end
        
    case 5
        fprintf('fmsl(A,B,m,f,n) o fmsl(A,B,m,f,Ec)\n');
        
    case 6
        fprintf('fmsl(A,B,m,f,n,k) o fmsl(A,B,m,f,Ec,k)\n');
    otherwise
        clc;
        fprintf(2,'<strong>Ingresa los parametros de manera correcta\n</strong>');
    
end

    function Gauss(A,B)
        disp(A)
        disp(B)
    end

    function GaussJordan(A,B)
        disp(A)
        disp(B)
    end

    function GaussSediel(A,B,n)
        disp(A)
        disp(B)
        disp(n)
    end
    function GaussSediel1(A,B,Ec)
        disp(A)
        disp(B)
        disp(Ec)
    end
    
    function DescomposicionLu(A,B)
        disp(A)
        disp(B)
    end
    
    function MatrizInversa(A,B)
        disp(A)
        disp(B)
    end

end