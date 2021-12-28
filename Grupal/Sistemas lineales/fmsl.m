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
                fprintf('<strong>Descomposicion LU \n</strong>');
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
        AB=[A B];
        n=length(B);
        %matriz triangular
        for k=1:n-1 
            [~,j]=max(abs(AB(k:n,k)));
            fila=j+k-1;
            if fila~=k
                AB([k,fila],:)=AB([fila,k],:);%intercambio de filas
            end
            for i=k+1:n
                factor=AB(i,k)/AB(k,k);
                AB(i,k:n+1)=AB(i,k:n+1)-factor*AB(k,k:n+1);          
            end
        end
    %incógnitas
    x=zeros(n,1);
    x(n)=AB(n,n+1)/AB(n,n);
    %Aux=A\B
    %Er=zeros(n,1)
    for i=n-1:-1:1 
        x(i)=AB(i,n+1)/AB(i,i)-AB(i,i+1:n)*x(i+1:n)/AB(i,i);
        %Er=abs((Aux(i)-x(i))/Aux(i))*100
    end
    varNames = {'xi','vt','ve','Ea','Er'};   
    xi = 1:n;
    xi = xi.';
    xi = strcat('x',num2str(xi));
    s = A\B ;
    vt = s(i:n);
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
    fprintf('<strong>\t\t\tTabla Gauss\n</strong>')
    disp(T)
    end %fin de la funcion GAUSS

    function GaussJordan(A,B)
        
        A1 = A;
        B1 =B;
        
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
            xs = B;
        end
        
    varNames = {'xi','vt','ve','Ea','Er'};   
    xi = 1:n;
    xi = xi.';
    xi = strcat('x',num2str(xi));
    s = rref([A,B]);
    vt = s(:,n+1);
    Ea = abs(vt-xs);
    Er = abs(vt-xs)./vt;
    
    if varargin{4} == 3
        vt = rats(vt) ;
        vt =deblank(vt);
        vt =strtrim(vt);
        
        xs = rats(xs);
        xs= deblank(xs);
        xs = strtrim(xs);
        
        Ea = rats(Ea);
        Ea = deblank(Ea);
        Ea = strtrim(Ea);
        
        Er = rats(Er);
        Er = deblank(Er);
        Er = strtrim(Er);
        
    end
    
    T = table(xi,vt,xs,Ea,Er,'VariableNames',varNames);
    fprintf('<strong>\t\t Tabla Gauss-Jordan\n</strong>')
    disp(T)
    
    if (n ==2)
        x = sym('x');
        disp('Sistema 2x2')
        hold on
        grid on
        legend()
        for i = 1:n
            y1 = strcat('(',num2str(B1(i,1)),'-',num2str(A1(i,1)),'*','x',')/',num2str(A1(i,2)));
            y1 = str2sym(y1);
            fplot(y1)            
        end
        %delete(o)
    
    elseif(n ==3)
        disp('Sistema 3x3')
        %grid on
        for i = 1:n
            %x = sym('x');
            %y = sym('y');
            z = strcat('(',num2str(B1(i,1)),'-',num2str(A1(i,1)),'.*','x','-',num2str(A1(i,2)),'.*y)/',num2str(A1(i,3)));
            [x y] = meshgrid(-10:1:10);
            z = eval(z);            
            surf(x,y,z)       
            hold on
        end
        legend()
    end
    
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

        if size(A,1) ~= size(A,2)
            error('Se necesita que la matriz A sea cuadrada')
        elseif size(B,2) ~= 1
            error('B debe ser un vector columna');
        elseif size(A,1) ~= size(B,1)
            error('El número de filas de A no coincide con el de B. Sistema inconsistente');
        end
        
        if prod(diag(A)) == 0
            error('El determinante de la matriz A es cero, no se puede resolver');
        end
        
        n = size(A,1); 
        for k = 1:n
            if A(k,k) ~= max(abs(A(:,k)))
                [filapivote,~] = find(abs(A) == max(abs(A(:,k))));
                A([k,filapivote(1)],:) = A([filapivote(1),k],:);
                B([k,filapivote(1)]) = B([filapivote(1),k]);
            end
        end
        
        U = A; D = B; L = eye(n);
        for k = 1:n - 1
            for i = k + 1:n
                factor = U(i,k)/U(k,k);
                L(i,k) = factor;
                U(i,:) = U(i,:) - factor*U(k,:);
                D(i) = D(i) - factor*D(k);
            end
        end
        
        x(n) = D(n)/U(n,n);
        for i = n - 1:-1:1
            sum = D(i);
            for j = i + 1:n
                sum = sum - U(i,j)*x(j);
            end
            x(i) = sum/U(i,i);
        end
        x = x';
        
        disp('L')
        disp(L)
        disp('U')
        disp(U)
        disp('x')
        disp(x)
        
    end %% Final funcion Descomposicion LU
    
    function MatrizInversa(A,B)
        disp(A)
        disp(B)
    end

end