function varargout = STaylor(varargin)
tic
% Authors: 
%   Andrade Mateo
%   Cedillo Nicolas
%   Garces Elian
%   Han Martin
%   Sanmiento Alejandro
% Date: 23/11/2021
% 
% STaylor: Aproxima el valor de una funcion 
%           en un punto dado utilizando la serie de taylor 
% [tx,Rx,R,r,Ea] = STaylor(fx,n,c,e,N,x) 
% 
% :param args: 
%    fx: Funcion a evaluar
%    n: orden del polinomio
%    c: Centro de la funcion
%    e: Valor de Epsilon
%    N: Error residual
%    x: Punto a evaluar la funcion
% :type args: boolean 
% :returns: 
%      tx: Polinomio de taylor
%      Rx: Formula del error de truncamiento
%      R: Radio mayor de convergencia
%      r: Radio menor de convergencia donde diverge mas rapdio la funcion
%      Ea: Error Absoluto
%      Er: Error relativo


    switch nargin
        
        case 2
            fx = varargin{1};
            n = varargin{2};
            [varargout{1},varargout{2}] = taylor1(fx,n);
        case 3
            fx = varargin{1};
            n = varargin{2};
            c = varargin{3};
            [varargout{1},varargout{2},varargout{3},varargout{4}] = taylor2(fx,n,c);
        case 4
            fx = varargin{1};
            n = varargin{2};
            c = varargin{3};
            e = varargin{4};
            [varargout{1},varargout{2},varargout{3},varargout{4}] = taylor3(fx,n,c,e);
        case 5
            fx = varargin{1};
            n = varargin{2};
            c = varargin{3};
            e = varargin{4};
            N = varargin{5};
            [varargout{1},varargout{2},varargout{3},varargout{4}] = taylor4(fx,n,c,e,N);
        otherwise
            error('Ingrese los parametros correctos')
    end
    toc
end



function print(varargin)
    
    var = {'f(x): ','n: ','t(x): ','Rt(x): ','c: ','R: ','r: ','e: ','N','Ea(x)','Er(x)'};
    fprintf('<strong>\t Impresion de datos.\n</strong>')
    for i = 1:nargin
        fprintf('<strong>%s</strong>',var{i})
        disp(varargin{i})
    end
        
end

function [tx,Rtx] = taylor1(fx,n)
    
    
    if validatefx(fx) && validateIntPosi(n) 
 
        syms c x e
            fxs=str2sym(fx);%convertir la funcion a simbolica
            vs = symvar(fxs);%Encontrar la variable simbólica en fxs.
            for i=0:n
                s(i+1)=subs(diff(fxs,i),vs,c)/factorial(i)*(x-c)^i;
                tx(i+1)= poly2sym(fliplr(s(1:i+1)),vs);
            end
            Rtx = (subs(diff(fxs,n),vs,e)*x^(n+1))/factorial(n+1);
     
            %Imprimo los valores 
                disp('<strong>Impresion de datos.</strong>')
                fprintf('<strong>f(x):</strong> %s\n',fxs)
                fprintf('<strong>n:</strong> %d\n',n)
                fprintf('<strong>t(x):</strong> %s\n',tx(end))
                fprintf('<strong>Rt(x):</strong> %s\n',Rtx)
    else
        error('Error al ingresar los datos')

    end

    Rtx = (subs(diff(fxs,n),vs,e)*x^(n+1))/factorial(n+1);
    fplot(fxs,[-10,10],'LineWidth',2); grid on;
    
    %fplot(tx,'LineWidth',2);
    %Imprimo los valores
    print(fxs,n,tx(end),Rtx)

    
end

function [v_fx]= validatefx(fx)
    %validatefx: valida si es fx es funcion trasendental
    
    %valores de entrada
    %fx=funcion trasendental
    
    %valores de salida
    %v_fx=boolean
    
    % defino las funciones tracedentales
    tras = ["sin",'cos','tan','exp','csc','log','sinh','cosh','tanh',]; 
    
     v_fx = false;
     
     for i = 1:length(tras)
        if strfind(fx,tras(1,i))
            v_fx = true;
            break;
        else
            v_fx = false;
        end
    end
end

function [isreal]= validateReal(num)

    %validateReal: valida si un numero es real
    
    %valores de entrada
    %num=numero cualquiera
    
    %valores de salida
    %isreal=boolean
    

    if isreal(num)==true && isnumeric(num) 
        isreal = true;
    else 
        isreal = false;
    end

end

function isenteroposi = validateIntPosi(num)

    %validateReal: valida si un numero es entero positivo
    
    %valores de entrada
    %num=numero cualquiera
    
    %valores de salida
    %isreal=boolean

    
    isenteroposi=false;
    if num>0 && isnumeric(num) && mod(num,1)==0 
        isenteroposi = true;
    end

end

function [tx,Rtx,R,r] = taylor2(fx,n,c)

    syms  x e
    fxs=str2sym(fx);%convertir la funcion a simbolica
    vs = symvar(fxs);%Encontrar la variable simbólica en fxs.
    for i=0:n
        s(i+1)=subs(diff(fxs,vs,i),vs,c)/factorial(i)*(x-c)^i;
        tx(i+1)= poly2sym(fliplr(s(1:i+1)),vs);
        
        
    end
    Rtx = (subs(diff(fxs,n),vs,e)*x^(n+1))/factorial(n+1);
    R= limit(abs(tx(n))/abs(tx(n)),x,inf);
    r=subs(abs(x-c),'c',c);
    %R= limit(abs(s(n+1))/abs(s(n)),x,inf) ;
    %disp(limit(abs(tx(n+1)/tx(n)),x,0))
    R= 1;%limit(abs(tx(n+1)/tx(n)),x,inf) ;
    r=0;
    %R= 1%;limit(abs(s(i+1)/s(i+1)),x,inf) ;
    disp(limit(abs(tx(n+1)/tx(n)),x,0))
    %Imprimo los valores
    print(fxs,n,tx(end),Rtx,c,R,r)
    
    %grafico
    fplot(fxs,'LineWidth',3); grid on;
    xlim([-(double(R)-c) double(R)+c])
    ylim([-(double(R)-c) double(R)+c])
    
    for i = 2:n+1
       hold on
       fplot(tx(i));
    end
    
    theta = (0:0.01:2.01*pi);
    x1 = c + double(R) * cos(theta);
    y1 = double(subs(fxs,vs,c))+ double(R) * sin(theta);
    
    plot(c,subs(fxs,vs,c),'ro','MarkerFaceColor','r');
    plot(x1,y1,'-g','LineWidth',1)

end

function [tx,Rtx,R,r] = taylor3(fx,n,c,e)

    syms  x 
    fxs=str2sym(fx);%convertir la funcion a simbolica
    vs = symvar(fxs);%Encontrar la variable simbólica en fxs.
    for i=0:n
        s(i+1)=subs(diff(fxs,vs,i),vs,c)/factorial(i)*(x-c)^i;
        tx(i+1)= poly2sym(fliplr(s(1:i+1)),vs);
        
    end
    
  
    Rtx = (subs(diff(fxs,n),vs,e)*x^(n+1))/factorial(n+1);
    R= limit(abs(tx(n+1)/tx(n)),x,inf) ;
    r=0;
    R= limit(abs(s(i+1)/s(i+1)),x,inf) ;
    disp(limit(abs(tx(n+1)/tx(n)),x,0))

    %Imprimo los valores
    print(fxs,n,tx(end),Rtx,c,R,r)
    
    %grafico
    fplot(fxs,'LineWidth',3); grid on;
    
    xlim([(double(R)+2) double(R)+1])
    ylim([(double(R)+2) double(R)+1])
    
    for i = 2:n+1
       hold on
       fplot(tx(i));
    end
    
    theta = (0:0.001:2.01*pi);
    x1 = c + double(R) * cos(theta);
    y1 = double(subs(fxs,vs,c))+ double(R) * sin(theta);
    
    plot(c,subs(fxs,vs,c),'ro','MarkerFaceColor','r');
    plot(x1,y1,'-g','LineWidth',1)

end

function [tx,Rtx,R,r] = taylor4(fx,n,c,e,N)

    syms  x 
    fxs=str2sym(fx);%convertir la funcion a simbolica
    vs = symvar(fxs);%Encontrar la variable simbólica en fxs.
    for i=0:n
        s(i+1)=subs(diff(fxs,vs,i),vs,c)/factorial(i)*(x-c)^i;
        tx(i+1)= poly2sym(fliplr(s(1:i+1)),vs);
        
    end
    Valor_aproximado=double(subs(fxs,vs,c)); 
    for i = n:N
        s(i+1)=subs(diff(fxs,vs,i),vs,c)/factorial(i)*(x-c)^i;
        sigma(i+1)=sum(double(s));
        Er(i+1)=abs(((Valor_aproximado-sigma(i+1))/Valor_aproximado))*100; 
    end
    
    
    Rtx = (subs(diff(fxs,n),vs,e)*x^(n+1))/factorial(n+1);
     R= limit(abs(tx(n))/abs(tx(n)),x,inf);
    r=subs(abs(x-c),'c',c);
    %R= limit(abs(s(i+1)/s(i+1)),x,inf) ;
    %disp(limit(abs(tx(n+1)/tx(n)),x,0))
    %Imprimo los valores
    print(fxs,n,tx(end),Rtx,c,R,r)
    
    %grafico
    fplot(fxs,'LineWidth',3); grid on;
    
    xlim([-(double(R)+c-2) double(R)+c*2])
    ylim([-(double(R)+c-2) double(R)+c*2])
    
    for i = 2:n+1
       hold on
       fplot(tx(i));
    end
    
    theta = (0:0.01:2.01*pi);
    x1 = c + double(R) * cos(theta);
    y1 = double(subs(fxs,vs,c))+ double(R) * sin(theta);
    
    plot(c,subs(fxs,vs,c),'ro','MarkerFaceColor','r');
    plot(x1,y1,'-g','LineWidth',1)
    

end
