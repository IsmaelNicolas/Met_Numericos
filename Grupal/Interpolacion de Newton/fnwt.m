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
        [varargout{1},varargout{2}]=newton(A);
    case 2
        evaluar(A,varargin{2});
    otherwise
        fprintf(2,'<strong>Ingresa un Ajuste valido\n</strong>');
        
end


    function [Pn,Rt]=newton(A)
        A = A';        
        Rt = 0;

        [~,m] = size(A); 
        for j = 1:m+1
            [n,m] = size(A); 
            for i = 1:n-j
                A(i,m+1)= ((A(i+1,m)-A(i,m))/(A(i+j,m-j)-A(i,m-j)));
            end
        end
        m = 1;
        p = " ";
        [n,~] = size(A); 
        Pn = strcat(num2str(A(1,2)));
        for i = 3:n+1
            Pn = strcat(Pn,'+',num2str(A(1,i)));
            for k = i-2:m
                p = strcat(p,'*(x-',num2str(A(k,1)),')'); 
            end
            Pn = strcat(Pn,p);
            m=m+1;
        end
        Pn = str2sym(Pn);
        Pn = expand(Pn);
        %Grafico los puntos
        scatter(A(:,1),A(:,2)) 
        grid on
        hold on
        fplot(Pn) %Grafico la funcion
        
        %Delimito los valores de la grafica
        xlim([A(1,1) A(end,1)])
        ylim([A(1,2),A(end,2)])
        disp(A)
        disp(A(1,2))

        varargout{1} = Pn;
        varargout{2} = Rt;
    end

    function evaluar(A,x)
        [Pn,Rt] = newton(A);
        disp(x)
        disp(Pn)
        disp(Rt)
        varargout{1} = Pn;
        varargout{2} = Rt;
    end
    
toc
end

