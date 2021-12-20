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
%   3 - Rat - Fraccion
%   'eng' - Notacion Cientifica
%
% n: Numero de iteraccion para Gauss- Sediel(Integer)
% Ec: Error de calculo para Gauss- Sediel(Real)

switch nargin
    case 4
       fprintf('fmsl(A,B,m,f)\n');
       
        switch varargin{4}
            case 0
                fprintf('<strong>format short\n</strong>');
                format short
            case 1
                fprintf('<strong>format long\n</strong>');
                format long
            case 2
                fprintf('<strong>format bank\n</strong>');
                format bank
            case 3
                fprintf('<strong>format rat\n</strong>');
                format rational
            case 'eng'
                fprintf('<strong>format eng\n</strong>');
                format short e
            otherwise
                warning('Formato erroneo')
            
        end
       
        switch varargin{3}
            case 0
                fprintf('<strong>Gauss</strong>');
                Gauss(varargin{1},varargin{2})
            case 1
                fprintf('<strong>Gauss-Jordan\n</strong>');
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

        %Validamos las matrices de entrada
        if size(A,1) ~= size(A,2) %La matriz no es cuadrada
            error('Se necesita que la matriz A sea cuadrada')
        elseif size(B,2) ~= 1 %El vector no es una columna
            error('B debe ser un vector columna');
        elseif size(A,1) ~= size(B,1) % no coinciden los valores
            error('El número de filas de A no coincide con el de B. Sistema inconsistente');
        end
        
        %Validamos si el sistema tiene solucion
        if det(A) == 0
            error('El determinante de la matriz A es cero, no se puede resolver');
        end
        
        n = size(A,1); %Numero de ecuaciones
        
        a = num2str(A); b = num2str(B);% c = [a T b]; ;
        
        for k = 1:n
            if A(k,k) ~= max(abs(A(:,k)))
            [filapivote,~] = find(abs(A) == max(abs(A(:,k))));
            A([k,filapivote(1)],:) = A([filapivote(1),k],:);
            B([k,filapivote(1)]) = B([filapivote(1),k]);
            end
        end

        
        j = 1;
        for k = 1:n
            if A(k,k) ~= 1 %%si el elemento i,i de la diagonal es diferente de 1
                B(k) = B(k)/A(k,k);
                A(k,:) = A(k,:)./A(k,k);
                j = j+1;
            end
    
            for i = 1:n
                if i ~= k
                    factor = A(i,k)/A(k,k);
                    A(i,:) = A(i,:) - factor*A(k,:);
                    B(i) = B(i) - factor*B(k);
                    j = j+1;
                end
            end
            x = B;
        end
        
    varNames = {'xi','vt','ve','Ea','Er'};   
    xi = 1:n;
    xi = xi.';
    xi = strcat('x',num2str(xi));
    s = rref([A,B]);
    vt = s(:,n+1);
    Ea = abs(vt-x);
    Er = abs(vt-x)./vt;
    
    if varargin{4} == 3
        vt = rats(vt) ;
        vt =deblank(vt);
        vt =strtrim(vt);
        
        x = rats(x);
        x= deblank(x);
        x = strtrim(x);
        
        Ea = rats(Ea);
        Ea = deblank(Ea);
        Ea = strtrim(Ea);
        
        Er = rats(Er);
        Er = deblank(Er);
        Er = strtrim(Er);
        
    end
    
    T = table(xi,vt,x,Ea,Er,'VariableNames',varNames);
    fprintf('<strong>\t\t Tabla Gauss-Jordan\n</strong>')
    disp(T)
    
    
    end %% Final funcion Gauss-Jordan

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