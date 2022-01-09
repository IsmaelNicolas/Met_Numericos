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
        scatter(A(:,1),A(:,2),'filled') 
        grid on
        hold on
        
        title("Interpolacion de newton")
        
        %Grafico la funcion
        fplot(Pn) 
        
        %Delimito los valores de la grafica
        xlim([A(1,1)-1 A(end,1)+1])
        ylim([min(A(:,2))-1 max(A(:,2))+1])
        disp(A)
        disp(A(1,2))
        
        
        
        varargout{1} = Pn;
        varargout{2} = Rt;
    end

    function evaluar(A,X)
        [Pn,Rt] = newton(A);
        Pn = subs(Pn,X);
        plot(X,Pn,'kd')
        legend('Puntos','Pn(x)',strcat('Pn(',num2str(X),')'))
        disp(A)
        [n,m]=size(A);
        p = " ";
        p1=0;
        p2=0;
        for i=1:m
            if X<A(1,i)
                p2=A(1,i);
                break;
            end
        end
        for i=1:m
            if X>A(1,i)
                p1=A(1,i);
                break;
            end
        end
        p11=0;
        p22=0;
        for i=1:m
            if p1==A(1,i)
                p11=A(2,i);
            end
        end
        for i=1:m
            if p2==A(1,i)
                p22=A(2,i);
            end
        end
        
        f=((p22-p11)/(p2-p1))/factorial(m+1);
        
        varargout{1} = Pn;
        varargout{2} = Rt;
    end
    
toc
end

