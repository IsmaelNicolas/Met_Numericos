%declaracion de la funcion Principal fsec con varargin
function varargout = fsec(varargin)
%[r,z,w]=fsec('((log(3*x-2))^2)*(exp(1/x-3)-1)*(cos(x*pi/3))',[1,7],0.0001)
	%determinamos los 4 modos de uso del programa dadas las diferentes 
	%posibilidades de entrada de datos	
	switch nargin
	%caso1:Entrada de una funcion
        case 1

            disp(1);
            fx = varargin{1};
            [varargout{1}] = fsec1(fx);
        	

            disp(1); %imprimir el 1
            fx = varargin{1};   %ingreso de la funcion
            [varargout{1}] = fsec1(fx); %Disponemos argumento de salida a fsec1
       	%caso2:Entrada de una funcion y de un intervalo
        case 2
            fx = varargin{1}; %ingreso de la funcion
            a = varargin{2};  %ingreso del intervalo de inicio
	    %Disponemos argumentos de salida fsec2
            [varargout{1},varargout{2}] = fsec2(fx,a);

	%caso3:Entrada de una funcion, intervalo, (n iteraciones o e (error))
	%En este caso solo se puede ingresar n o e pero no los dos
        case 3
            
            fx = varargin{1};   %ingreso de la funcion
            a = varargin{2};    %ingreso del intervalo de inicio
            fx = varargin{1}; %ingreso de la funcion
            a = varargin{2};  %ingreso del intervalo de inicio
	%condicional: si cumple con ser un valor numerico y entero

            if mod(varargin{3},1)==0 && isnumeric(varargin{3})
                n = varargin{3};	%ingresamos la variable n
	%Disponemos los argumentos de salida para la funcion fsec3 con los parametros ingresados
                [varargout{1},varargout{2},varargout{3}] = fsec3(fx,a,n);
	%condicional: si cumple con ser un valor numerico y real
            elseif isnumeric(varargin{3}) && isreal(varargin{3})
                e = varargin{3};	%ingresamos la variable e
	%Disponemos los argumentos de salida para la funcion fsec3 con los parametros ingresados
                [varargout{1},varargout{2},varargout{3}] = fsec4(fx,a,e);
	%fin del switch
            end
        %mensaje de error en caso de que el usuario haya ingresado
	%un numero erroneo de parametros     
        otherwise
            warning('Ingrese un numero de parametros aceptables')
            for i = 1:nargout
               varargout{i} = NaN; 
            end
            return;
    end
end	%fin de la funcion

%declaracion de la funcion fsec1
%param fx (funcion a estudiar)
function [r] = fsec1(fx) 
    %declaracion de variable simbolica x
    syms x
    fxs=str2sym(fx);%convertir la funcion a simbolica
    %excepciones para el ingreso de datos
    try

        r=solve(fxs,x,'Real',true); 

        r=double(solve(fxs,x,'Real',true));

    catch e
        [msgstr, msgid] = lastwarn;
        switch msgid
            case 'Warning: Unable to solve symbolically.'    
        end
        warning('No existe raices reales')
    end
end	%fin de la funcion fsec1

%declaracion de la funcion fsec2
%param fx (funcion a estudiar)
%param i (intervalo de entrada)
function [r,z] = fsec2(fx,i)
    k=1;    %asignamos el valor de 1 a k
    syms x  %declaracion de variable simbolica x
    fxs=str2sym(fx);%convertir la funcion a simbolica
    %r = zeros(size((solve(fxs)))); %creamos un arreglo de ceros para las raices de la funcion

    %r(k)=double(solve(fxs,x,'Real',true));
	arr = strsplit(i,','); %Declaramos arr y lo dividimos cone l delimitador ','
    a = str2double(arr(1)); %Declaramos a y convertimos su valor a doble presicion
    b = str2double(arr(2)); %Declaramos b y convertimos su valor a doble presicion
    error(k)=abs(b-a); %Definimos el error k como el valor absoluto de b menos a
    e=10e-10;   %Definimos el valor de e
    fa = feval(inline(fx),a);   %Evaluamos funcion con a
    fb = feval(inline(fx),b);   %Evaluamos funcion con b 
    r(k) = b - fb*((b-a)/(fb-fa));  %formula para el calculo de la secante

    r=double(solve(fxs,x,'Real',true));
	arr = strsplit(i,',');
    a = str2double(arr(1));
    b = str2double(arr(2));
    error(k)=abs(b-a);
    e=10e-10;
    fa = feval(inline(fx),a);
    fb = feval(inline(fx),b);
    z(k) = b - fb*((b-a)/(fb-fa));

    
    %mientras el error sea mayor al e por defecto 
    while error(k)>e 

        k = k+1;    %aumentamos k en uno
        b = a;      %modificamos el valor de b
        a = r(k-1); %modificamos el valor de a
        fa = feval(inline(fx),a);   %evaluamos la funcion con a
        fb = feval(inline(fx),b);   %evaluamos la funcion con b
        r(k) = b - fb*((b-a)/(fb-fa));  %formula para el calculo de la secante
        error(k) = abs(b-a);    %Definimos el error k como el valor absoluto de b menos a
        disp(r(k))  %imprimimos la raiz
        disp(r(k-1))    %imprimimos la raiz menos 1
        disp('----------------')
        if r(k)==r(k-1) 
            break;
        end    
    end  %fin del bucle
    
    z=i;
    fplot(fxs,'DisplayName',fx) %grafica de la funcion
    grid on;    %Lineas de los ejes en la grafica
    hold on;    
    xlim([-3 15])   %Definimos el limite en x
    ylim([-1 5])    %Definimos el limite en y
    s = strcat('A(',num2str(round(a,6)),',',num2str(round(fa,3)),')'); %Concatenacion de la leyenda en la grafica
    plot([a,b],[fa,fb],'ko','markerfacecolor','r','DisplayName',s); %Grafica de la funcion

%         k = k+1;
%         b = a;
%         a = z(k-1);
%         fa = feval(inline(fx),a);
%         fb = feval(inline(fx),b);
%         z(k) = b - fb*((b-a)/(fb-fa));
%         error(k) = abs(b-a);
%         disp(z(k))
%         disp(z(k-1))
%         disp('----------------')
%         if z(k)==z(k-1)
%             break;
%         end    
    
    %z{1}=i;
    fprintf('<strong>Raices reales :</strong> %d\n',r)
    fplot(fxs,'DisplayName',fx)
    grid on;
    hold on;
    xlim([-3 15])
    ylim([-1 5])
    s = strcat('A(',num2str(round(a,6)),',',num2str(round(fa,3)),')');
    plot([a,b],[fa,fb],'ko','markerfacecolor','r','DisplayName',s);

    legend()
end	%fin de la funcion fsec2

%declaracion de la funcion fsec3
%param fx (funcion a estudiar)
%param i (intervalo de entrada)
%param n (iteraciones para buscar el error)
function [r,z,w] = fsec3(fx,i,n)
    syms  x     %declaracion de la variable simbolica x

    fxs = str2sym(fx);%convertir la funcion a simbolica
    vs = symvar(fxs);%Encontrar la variable simbólica en fxs.
    %plot_fun(fxs,'k-','LineWidth',2)
    fplot(fxs,'k-','LineWidth',2,'DisplayName',fx); grid on; hold on;   %grafica de la funcion
    obj = plot(i,[subs(fxs,vs,i(1)),subs(fxs,vs,i(2))],'ko','MarkerFaceColor','r'); %definicion de colores y puntos
    title(fx);  %agregamos titulo de funcion
    
    %set(gcf,'Position',[551,86,560,420],'Units','pixels');

    a = i(1);
    b = i(2);
    ai(1)= a;
    bi(1)= b;
    fa(1) = feval(inline(fx),a);
    fb(1) = feval(inline(fx),b);
    
    
    r(1) = b - fb*((b-a)/(fb-fa));
    error(1) = abs(b-a);
    ea(1) = abs((b-a)/b)*100;
    er(1) = feval(inline(fx),ai(1))- r(1);
    
    
 
    a = i(1);   %definimos el valor de a con el primer punto del intervalo
    b = i(2);   %definimos el valor de b con el segundo punto del intervalo
    
    ai(1) = a;
    bi(1) =b;
    
    fa(1) = feval(inline(fx),a);   %evaluamos la funcion con a
    fb(1) = feval(inline(fx),b);   %evaluamos la funcion con b

    r(1) = b - fb*((b-a)/(fb-fa));  %calculo de la secante
    error(1) = abs(b-a);    %definimos el error como el valor absoluto de b menos a
    ea(1) = abs((b-a)/b)*100;   %definimos el error absoluto
    legend()
    for k = 2:1:n
        
        ylim([-1 5])    %limite en y
        xlim([-1 15])   %limite en x
        b = a;          %modificamos el valor de b
        a = r(k-1);     %modificamos el valor de a
        
        ai(k) = a;
        bi(k) =b;
        
        fa(k) = feval(inline(fx),a);   %evaluamos la funcion con a
        fb(k) = feval(inline(fx),b);   %evaluamos la funcion con b
        r(k) = b - fb(k)*((b-a)/(fb(k)-fa(k)));  %metodo de la secante
        error(k) = abs(b-a);    %error = valor absoluto de b - a
        ea(k) = abs((b-a)/b)*100;   %definimos el error absoluto
        %calculo ec_secante
        dfdx = (fb(k) - fa(k))/(b - a);   

        dfunc = poly2sym([dfdx,(dfdx * -b) + fb(k)],x);
        
        obj1 = plot(r(k),subs(fxs,vs,r(k)),'ko');   %punto medio 
        obj2 = fplot(dfunc,'b');    %linea de apoyo
        %obj3 = plot([b,b],[0,fb],'--');
        %pause(0.5);       
        delete(obj1); delete(obj2);%Borra el punto medio actual y su línea de apoyo  

        
        %concatenacion de la leyenda en la grafica
        s = strcat('A(',num2str(round(a,4)),',',num2str(round(fa(k),4)),'),B(',num2str(round(b,4)),',',num2str(round(fb(k),4)),')');
        
        set(obj(1),'markerfacecolor','w'); 
        obj = plot([a,b],[fa(k),fb(k)],'ko','markerfacecolor','r','DisplayName',s); %Actualiza los límites
        %obj = plot(i,[subs(fxs,vs,i(1)),subs(fxs,vs,i(2))],'ko','MarkerFaceColor','r');
        %ylim(yLimits)
        %pause(0.1);
        %xLimits = get(gca,'XLim');  % Get the range of the x axis
        %yLimits = get(gca,'YLim');  % Get the range of the y axis
        
    end
    
    %plot(x,subs(fxs,vs,x),'ko','MarkerFaceColor','b');
    z{1} = i;
    z{2} = r;
    w = {n,'ci',error,'ea',error(end),error(end-1)};

    iter = 1:n;
    f = double(subs(diff(fxs,1),vs,r));
    f1 = double(subs(diff(fxs,2),vs,r));
    VarNames = ["Iteraccion","ai","bi","f(ai)","f(bi)","ci","f'(ci)","f''(ci)","ec","ea"];
    T = table(iter.',ai.',bi.',fa.',fb.',r.',f.',f1.',error.',ea.','VariableNames',VarNames);
    disp(T)
    
end


%declaracion de la funcion fsec4
%param fx (funcion a estudiar)
%param i (intervalo de entrada)
%param e (error de la funcion secante)
function [r,z,w] = fsec4(fx,i,e)
    %declaracion de variable simbolica x
	syms  x 
    fxs = str2sym(fx);%convertir la funcion a simbolica
    vs = symvar(fxs);%Encontrar la variable simbólica en fxs.
    %plot_fun(fxs,'k-','LineWidth',2)
    %grafica
    fplot(fxs,'k-','LineWidth',2,'DisplayName',fx); grid on; hold on;
    obj = plot(i,[subs(fxs,vs,i(1)),subs(fxs,vs,i(2))],'ko','MarkerFaceColor','r');
    title(fx);  %titulacion en la grafica
    
    %set(gcf,'Position',[551,86,560,420],'Units','pixels');

    a = i(1);   %definimos el valor de a con el primer punto del intervalo
    b = i(2);   %definimos el valor de a con el segundo punto del intervalo
    
    fa = feval(inline(fx),a);   %evaluamos la funcion con a
    fb = feval(inline(fx),b);   %evaluamos la funcion con b
    k=1; %k se le asigna el valor de 1
    r(k) = b - fb*((b-a)/(fb-fa));  %metodo de la secante
    error(k) = abs(b-a);    %error valor absoluto de b-a
    ea(k) = abs((b-a)/b)*100;   %error absoluto

    
    %mientras el error sea mayor al e por defecto
    while error(k)>e
        k = k+1;    %k aumenta en 1
        ylim([-1 5])    %limite en y
        xlim([-1 15])   %limite en x
        b = a;
        bi(k) = a;
        a = r(k-1);

        ai(k)=a;
        fa(k) = feval(inline(fx),a);
        fb(k) = feval(inline(fx),b);
        r(k) = b - fb(k)*((b-a)/(fb(k)-fa(k)));
        error(k) = abs(b-a);
        ea(k) = abs((b-a)/b)*100;
        dfdx = (fb(k) - fa(k))/(b - a);
        dfunc = poly2sym([dfdx,(dfdx * -b) + fb(k)],x);

                
        obj1 = plot(r(k),subs(fxs,vs,r(k)),'ko');   %punto medio actual  
        obj2 = fplot(dfunc,'b');    %linea de apoyo
        %obj3 = plot([b,b],[0,fb],'--');
        %pause(0.5);       
        delete(obj1); delete(obj2);%Borra el punto medio actual y su línea de apoyo  


        %concatenacion de leyendas para la grafica
        s = strcat('A(',num2str(round(a,6)),',',num2str(round(fa,3)),'),B(',num2str(round(b,6)),',',num2str(round(fb,3)),')');
        
        %set(obj(1),'markerfacecolor','w');
        obj = plot([a,b],[fa(k),fb(k)],'ko','markerfacecolor','r','DisplayName',s); %Actualiza los límites
        %obj = plot(i,[subs(fxs,vs,i(1)),subs(fxs,vs,i(2))],'ko','MarkerFaceColor','r');
        %ylim(yLimits)
        %pause(0.1);
        %xLimits = get(gca,'XLim');  % Get the range of the x axis
        %yLimits = get(gca,'YLim');  % Get the range of the y axis
        
    end
    
    %plot(x,subs(fxs,vs,x),'ko','MarkerFaceColor','b');
    z = i;
    %z{2} = r;
    w = {k,'ci',error,'ea',error(end),error(end-1)};
    
    iter = 1:k;
    f = double(subs(diff(fxs,1),vs,r));
    f1 = double(subs(diff(fxs,2),vs,r));
    
    
    
    VarNames = ["Iteraccion","ai","bi","f(ai)","f(bi)","ci","f'(ci)","f''(ci)","ec","ea"];
    T = table(iter.',ai.',bi.',fa.',fb.',r.',f.',f1.',error.',ea.','VariableNames',VarNames);
    
    disp(T)
end


% 	r = zeros(2);	%creamos un arreglo de ceros para las raices de la funcion
%     z{1} = i;
%     z{2} = r;
%     w = ['ci','ec','ea','er','n(e)'];	%declaramos un arreglo para los errores
% end	%fin de la funcion

