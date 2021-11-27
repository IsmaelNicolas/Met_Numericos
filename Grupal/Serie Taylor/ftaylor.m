
<<<<<<< HEAD

function varargout = STaylor(varargin) %declaracion de la funcion principal STaylot

=======
function varargout = ftaylor(varargin)

function varargout = STaylor(varargin) %declaracion de la funcion principal STaylot
>>>>>>> 784b022f02baf5cdfefff2d91e2eb3630f1f19a6
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

%Establecemos los casos para la ejecucion del algoritmo 
    switch nargin
        %Caso 2: Ingreso de la funcion y n
        case 2
            fx = varargin{1}; %guardo la funcion que recibo por consola de forma dinamica
            n = varargin{2};  %guardo el parametro n que recibo por consola de forma dinamica
            [varargout{1},varargout{2}] = taylor1(fx,n);  %envio de los parametros receptados a la funcion de taylor1 en este caso
        %Caso 3: Ingreso de la funcion, n , c 
        case 3
            fx = varargin{1}; %guardo la funcion que recibo por consola de forma dinamica
            n = varargin{2};  %guardo el parametro n que recibo por consola de forma dinamica
            c = varargin{3}; %guardo el parametro c que recibo por consola de forma dinamica
            [varargout{1},varargout{2},varargout{3},varargout{4}] = taylor2(fx,n,c); %envio de los parametros receptados a la funcion taylor2 en este caso
        %Caso 4: Ingreso de la funcion, n, c y epsilon 
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

            fx = varargin{1};  %guardo la funcion que recibo por consola de forma dinamica
            n = varargin{2};   %guardo el parametro n que recibo por consola de forma dinamica
            c = varargin{3};  %guardo el parametro c que recibo por consola de forma dinamica
            e = varargin{4};  %guardo el parametro e que recibo por consola de forma dinamica
            [varargout{1},varargout{2},varargout{3},varargout{4}] = taylor3(fx,n,c,e);  %envio de los parametros receeptados a la funcion taylor3 en este caso

        otherwise
            error('Ingrese los parametros correctos') %error producto de un ingreso erroneo de los parametros
    end
    toc %calculo del tiempo de convergencia computacional
end



function print(varargin) %declaracion de la funcion de impresion de resultados
    
    var = {'f(x): ','n: ','t(x): ','Rt(x): ','c: ','R: ','r: ','e: ','N','Ea(x)','Er(x)'}; %declaracion de las variables para imprimir
    fprintf('<strong>\t Impresion de datos.\n</strong>') %mensaje de impresion de datos
    for i = 1:nargin %ciclo for para buscar los valores de los diferentes parametros
        fprintf('<strong>%s</strong>',var{i}) %impresion de los valores de los parametros
        disp(varargin{i}) %impresion de los valores de los parametros
    end %fin del ciclo for
        
end %fin de la funcion de impresion

function [tx,Rtx] = taylor1(fx,n) %declaracion de la funcion taylor1
    
    %condicional que verifique si la validacion de la funcion se cumple
    if validatefx(fx) && validateIntPosi(n) 
        %declaro las variables simbolicas c x e
        syms c x e
            fxs=str2sym(fx);%convertir la funcion a simbolica
            vs = symvar(fxs);%Encontrar la variable simbólica en fxs.
            for i=0:n %ciclo for desde 0 hasta n 
                s(i+1)=subs(diff(fxs,i),vs,c)/factorial(i)*(x-c)^i;
                tx(i+1)= poly2sym(fliplr(s(1:i+1)),vs);
            end
            Rtx = (subs(diff(fxs,n),vs,e)*x^(n+1))/factorial(n+1);
     
            %Impresion de los parametros y sus valores 
                disp('<strong>Impresion de datos.</strong>')
                fprintf('<strong>f(x):</strong> %s\n',fxs)
                fprintf('<strong>n:</strong> %d\n',n)
                fprintf('<strong>t(x):</strong> %s\n',tx(end))
                fprintf('<strong>Rt(x):</strong> %s\n',Rtx)
    else
        %error en el ingreso de datos
        error('Error al ingresar los datos')

    end
    %establecemos la formula del error de truncamiento
    Rtx = (subs(diff(fxs,n),vs,e)*x^(n+1))/factorial(n+1); 
    %grafico de la funcion
    fplot(fxs,[-10,10],'LineWidth',2); grid on; 
    
    %fplot(tx,'LineWidth',2);
    %Imprimo los valores
    print(fxs,n,tx(end),Rtx)

    
end %fin de la funcion taylor1

%declaracion de la funcion validatefx
function [v_fx]= validatefx(fx) 
    %validatefx: valida si es fx es funcion trasendental
    
    %valores de entrada
    %fx=funcion trasendental
    
    %valores de salida
    %v_fx=boolean
    
    % defino las funciones tracedentales
    tras = ["sin",'cos','tan','exp','csc','log','sinh','cosh','tanh',]; 
     %asignacion de v_fx como falsa
     v_fx = false;
     %ciclo for desde uno hasta el valor de la longitud del arreglo tras
     for i = 1:length(tras)
         
        if strfind(fx,tras(1,i)) %busca encontrar una funcion trascendente dentro del parametro funcion 
            v_fx = true; %cumple con que la funcion es trascendente
            break;
        else
            v_fx = false; %la funcion no es trascendente
        end
    end
end

%declaracion de la funcion para validar numeros reales
function [isreal]=validateReal(num) 


    %validateReal: valida si un numero es real
    
    %valores de entrada
    %num=numero cualquiera
    
    %valores de salida
    %isreal=boolean
    
    %condicional para saber si el numero ingresado es real
    if isreal(num)==true && isnumeric(num) 
        isreal = true; %el valor ingresado es real
    else 
        isreal = false; %el valor ingresado no es real
    end

end %fin de la funcion validateReal

%declaracion de la funcion de validacion de enteros positivos
function isenteroposi = validateIntPosi(num)

    %validateReal: valida si un numero es entero positivo
    
    %valores de entrada
    %num=numero cualquiera
    
    %valores de salida
    %isreal=boolean
    
    isenteroposi=false;
    %condicional para saber si el valor cumple con ser numerico, positivo 
    if num>0 && isnumeric(num) && mod(num,1)==0 
        isenteroposi = true; %el valor es entero positivo
    end

end %fin de la funcion validateIntPosi

%declaracion de la funcion taylor2
function [tx,Rtx,R,r] = taylor2(fx,n,c)

    %declaro las variables simbolicas x,e
    syms  x e
    fxs=str2sym(fx);%convertir la funcion a simbolica
    vs = symvar(fxs);%Encontrar la variable simbólica en fxs.
    for i=0:n

        s(i+1)=subs(diff(fxs,vs,i),vs,c)/factorial(i)*(x-c)^i;

        %calculo para mostrar el polinomio de taylor
        s(i+1)=subs(diff(fxs,vs,i),vs,c)/factorial(i)*(x-c)^i;

        tx(i+1)= poly2sym(fliplr(s(1:i+1)),vs);
        
        
    end
    %calculo del error de truncamiento
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

    %calculo del radio de convergencia

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
    

    %establecer limites en x,y
    xlim([-(double(R)+c/2) double(R)+c*2])
    ylim([-(double(R)+c/2) double(R)+c*2])
    %ciclo repetitivo para la impresion de las funciones en una sola
    %interfaz

    for i = 2:n+1
       hold on
       fplot(tx(i));
    end

    
    theta = (0:0.001:2.01*pi);

    %grafico de circulo de convergencia
    theta = (0:0.01:2.01*pi);

    x1 = c + double(R) * cos(theta);
    y1 = double(subs(fxs,vs,c))+ double(R) * sin(theta);
    
    plot(c,subs(fxs,vs,c),'ro','MarkerFaceColor','r');
    plot(x1,y1,'-g','LineWidth',1)

end



function [tx,Rtx,R,r] = taylor4(fx,n,c,e)
    %declaro la variable simbolica x

    syms  x 
    fxs=str2sym(fx);%convertir la funcion a simbolica
    vs = symvar(fxs);%Encontrar la variable simbólica en fxs.
    for i=0:n
        %calculo para mostrar el polinomio de taylor
        s(i+1)=subs(diff(fxs,vs,i),vs,c)/factorial(i)*(x-c)^i;
        tx(i+1)= poly2sym(fliplr(s(1:i+1)),vs);
        
    end

    Valor_aproximado=double(subs(fxs,vs,c)); 
    for i = n:N
        s(i+1)=subs(diff(fxs,vs,i),vs,c)/factorial(i)*(x-c)^i;
        sigma(i+1)=sum(double(s));
        Er(i+1)=abs(((Valor_aproximado-sigma(i+1))/Valor_aproximado))*100; 
    end
    
    

    %calculo del error de truncamiento

    Rtx = (subs(diff(fxs,n),vs,e)*x^(n+1))/factorial(n+1);

     R= limit(abs(tx(n))/abs(tx(n)),x,inf);
    r=subs(abs(x-c),'c',c);
    R= limit(abs(s(i+1)/s(i+1)),x,inf) ;
    disp(limit(abs(tx(n+1)/tx(n)),x,0))

    %Imprimo los valores
    print(fxs,n,tx(end),Rtx,c,R,r)
    
    %grafico
    fplot(fxs,'LineWidth',3); grid on;
<<<<<<< HEAD

=======
    
>>>>>>> 784b022f02baf5cdfefff2d91e2eb3630f1f19a6
%    xlim([-(double(R)+c-2) double(R)+c*2])
%    ylim([-(double(R)+c-2) double(R)+c*2])


    xlim([-(double(R)+c-2) double(R)+c*2])
    ylim([-(double(R)+c-2) double(R)+c*2])

    

    xlim([-(double(R)+c/2) double(R)+c*2])
    ylim([-(double(R)+c/2) double(R)+c*2])
    %ciclo repetitivo para la impresion de las funciones en una sola
    %interfaz   

    for i = 2:n+1
       hold on
       fplot(tx(i));
    end
     %grafico de circulo de convergencia
    theta = (0:0.01:2.01*pi);
    x1 = c + double(R) * cos(theta);
    y1 = double(subs(fxs,vs,c))+ double(R) * sin(theta);
    
    plot(c,subs(fxs,vs,c),'ro','MarkerFaceColor','r');
    plot(x1,y1,'-g','LineWidth',1)

%fin de la funcion 

end
