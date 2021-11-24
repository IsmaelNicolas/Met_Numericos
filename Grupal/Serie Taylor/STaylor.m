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
        otherwise
            error('Ingrese los parametros correctos')
    end
    toc
end



function print(varargin)
    
    var = {'f(x): ','n: ','t(x): ','Rt(x): ','c','R','r','e','N','Ea(x)','Er(x)'};
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
    fplot(fxs,'LineWidth',2); grid on;
    
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

function [isreal]=validateReal(num)

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
    R=0;r=0;
    for i = 2:n+1
       hold on
       fplot(tx(i));
    end
    plot(c,subs(fxs,vs,c),'ro','MarkerFaceColor','r');
    %Imprimo los valores
    print(fxs,n,tx(end),Rtx,c,R,r)

end

