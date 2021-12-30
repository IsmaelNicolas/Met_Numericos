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
    case 3
        fprintf('fmsl(A,B,m)');
        
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
        %fmsl(A,B,m,f)
        switch varargin{3}
            case 0
                fprintf('<strong>Gauss</strong>');
                Gauss(varargin{1},varargin{2})
            case 1
                fprintf('<strong>Gauss-Jordan\n</strong>');
                GaussJordan(varargin{1},varargin{2})
            case 2
                fprintf('<strong>Gauss-Sediel</strong>');
                Seidel2(varargin{1},varargin{2})
            case 3
                fprintf('<strong>Descomposicion LU \n</strong>');
                DescomposicionLu(varargin{1},varargin{2});
            case 4
                fprintf('<strong>Matriz Inversa</strong>');
                MatrizInversa(varargin{1},varargin{2});
            case 5
                fprintf('<strong>Todos los metodos</strong>');
                Gauss(varargin{1},varargin{2});
                GaussJordan(varargin{1},varargin{2});
                %Gauss Seidel 
                DescomposicionLu(varargin{1},varargin{2});
                MatrizInversa(varargin{1},varargin{2});
            otherwise
                clc;
                fprintf(2,'<strong>Ingresa un metodo valido \n</strong>');
        end
        
    case 5
        fprintf('fmsl(A,B,m,f,n) o fmsl(A,B,m,f,Ec)\n');
        
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
        %fmsl(A,B,m,f,n) o fmsl(A,B,m,f,Ec)
        switch varargin{3}
            case 0
                fprintf('<strong>Gauss</strong>');
                Gauss(varargin{1},varargin{2})
            case 1
                fprintf('<strong>Gauss-Jordan\n</strong>');
                GaussJordan(varargin{1},varargin{2})
            case 2
                fprintf('<strong>Gauss-Sediel</strong>');
                Seidel(varargin{1},varargin{2},varargin{5})
            case 3
                fprintf('<strong>Descomposicion LU \n</strong>');
                DescomposicionLu(varargin{1},varargin{2});
            case 4
                fprintf('<strong>Matriz Inversa</strong>');
                MatrizInversa(varargin{1},varargin{2});
            case 5
                fprintf('<strong>Todos los metodos</strong>');
                Gauss(varargin{1},varargin{2});
                GaussJordan(varargin{1},varargin{2});
                %Gauss Seidel 
                DescomposicionLu(varargin{1},varargin{2});
                MatrizInversa(varargin{1},varargin{2});
            otherwise
                clc;
                fprintf(2,'<strong>Ingresa un metodo valido \n</strong>');
        end
        
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
            [mayor,j]=max(abs(AB(k:n,k))); %Selecciono la fila pivote
            fila=j+k-1;
            if fila~=k
                AB([k,fila],:)=AB([fila,k],:);%intercambio de filas
            end
            for i=k+1:n %opero las filas con el factor
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
    
    
    %Transformo todo a fortmat rat
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
    
    %Creo la tabla de los valores resultantes del metodo
    T = table(xi,vt,x,Ea,Er,'VariableNames',varNames);
    fprintf('<strong>\t\t\tTabla Gauss\n</strong>')
    disp(T)
    end %Fin funcion GAUSS

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
        
        %Ordeno la diagonal de mayor a menor de izquierda a derecha  
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
                    factor = A(i,k)/A(k,k);%Calculo el factor para el pivote
                    A(i,:) = A(i,:) - factor*A(k,:); %Opero toda la fila de A con el factor
                    B(i) = B(i) - factor*B(k); %Opero la fila de B
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
    
    
    end %% Fin funcion Gauss-Jordan

    function Seidel(A,B,m)
        
        tol = 0.0001;
        x=[1 1 1]';
        n=length(x);
        for k=1:m
            w=x;
            for i=1:n
                s=A(i,1:i-1)*x(1:i-1)+A(i,i+1:n)*x(i+1:n);
                x(i)=(B(i)-s)/A(i,i);
            end
            if norm(x-w,inf)<tol
            return
            end
            fprintf('\nLa solucion en el sistema en la iteracion %4.0f\n',k)
            for i=1:n
                fprintf('       x(%1.0f)=%6.8f\n',i,x(i))
            end
        end
    end %Fin funcion Seidel
    function Seidel2(A,B)
        tol = 0.0001;
        m=1;
        x=[1 1 1]';
        n=length(x);
        for k=1:m
            w=x;
            for i=1:n
                s=A(i,1:i-1)*x(1:i-1)+A(i,i+1:n)*x(i+1:n);
                x(i)=(B(i)-s)/A(i,i);
            end
            if norm(x-w,inf)<tol
                return
            end
            fprintf('\nLa solucion en el sistema\n')
            for i=1:n
                fprintf('       x(%1.0f)=%6.8f\n',i,x(i))
            end
        end
    end %Fin de funcions seidel 2
    
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
        
    end %% Fin funcion Descomposicion LU
    
    function MatrizInversa(A,B)
        dimA = size(A); %tamanio de A
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
        C=[A eye(dimA(1))]; %unión de A y B en una sola matriz                    
        for i=1:length(C(:,1)) %recorrer matriz extendida
            if C(i,i)~=1 %si el elemento (i,i) de la diagonal es diferente de 1                  
               C(i,:)= C(i,:)./C(i,i);  %entonces se convierte a 1  dividiendo toda la fila por dicho elemento
            end
            for n=1:length(C(:,1)) %recorre matrix extendida
                if n~=i % si n en la columna i no está en la diagonal es decir si i no es igual a n
                    C(n,:)=-C(n,i).*C(i,:)+C(n,:); %entonces se convierte a 0
                end
            end
        end
        dimC = size(C);
        matrizInv = C(:,dimA(1)+1:dimC(2));
        matrizInv
        %disp('Solucion')
        X = matrizInv*B

    end

end