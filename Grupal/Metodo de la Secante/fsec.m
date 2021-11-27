%declaracion de la funcion Principal fsec con varargin
function varargout = fsec(varargin)

	%determinamos los 4 modos de uso del programa dadas las diferentes 
	%posibilidades de entrada de datos	
	switch nargin
	%caso1:Entrada de una funcion
        case 1
            disp(1);
            fx = varargin{1};
            [varargout{1}] = fsec1(fx);
        case 2
            disp(2);
            fx = varargin{1};
            a = varargin{2};

            fx = varargin{1}; %ingreso de la funcion
            [varargout{1}] = fsec1(fx); %Disponemos un argumento de salida para la funcion fsec1
	
	%caso2:Entrada de una funcion y de un intervalo
        case 2
            fx = varargin{1}; %ingreso de la funcion
            a = varargin{2};  %ingreso del intervalo de inicio
	    %Disponemos argumentos de salida fsec2
            [varargout{1},varargout{2}] = fsec2(fx,a);

	%caso3:Entrada de una funcion, intervalo, (n iteraciones o e (error))
	%En este caso solo se puede ingresar n o e pero no los dos
        case 3
            
            fx = varargin{1};
            a = varargin{2};
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
    r = zeros(4); %creamos un arreglo de ceros para las raices de la funcion
    disp(fx)      %imprime la funcion
end	%fin de la funcion fsec1

%declaracion de la funcion fsec2
%param fx (funcion a estudiar)
%param i (intervalo de entrada)
function [r,z] = fsec2(fx,i) 
	r = zeros(2);	%creamos un arreglo de ceros para las raices de la funcion
    z{1} = i;
    z{2} = r;
    disp('z = { [a,b], r} ')
    disp('r')		%imprime la letra 'r'
    disp(z{1})		%imprime el valor de z{1}
    disp('r')		%imprime la letra 'r'
    disp(z{2})		%imprime el valor de z{1}
end	%fin de la funcion fsec2


%declaracion de la funcion fsec3
%param fx (funcion a estudiar)
%param i (intervalo de entrada)
%param n (iteraciones para buscar el error)
function [r,z,w] = fsec3(fx,i,n)
    syms  x 
    fxs = str2sym(fx);%convertir la funcion a simbolica
    vs = symvar(fxs);%Encontrar la variable simbólica en fxs.
    %plot_fun(fxs,'k-','LineWidth',2)
    fplot(fxs,'k-','LineWidth',2,'DisplayName',fx); grid on; hold on;
    obj = plot(i,[subs(fxs,vs,i(1)),subs(fxs,vs,i(2))],'ko','MarkerFaceColor','r');
    title(fx);
    
    %set(gcf,'Position',[551,86,560,420],'Units','pixels');
    a = i(1);
    b = i(2);
    
    fa = feval(inline(fx),a);
    fb = feval(inline(fx),b);

    r(1) = b - fb*((b-a)/(fb-fa));
    error(1) = abs(b-a);
    ea(1) = abs((b-a)/b)*100;
    legend()
    for k = 2:1:n
        
        ylim([-1 5])
        xlim([-1 15])
        b = a;
        a = r(k-1);
        fa = feval(inline(fx),a);
        fb = feval(inline(fx),b);
        r(k) = b - fb*((b-a)/(fb-fa));
        error(k) = abs(b-a);
        ea(k) = abs((b-a)/b)*100;
        dfdx = (fb - fa)/(b - a);
        dfunc = poly2sym([dfdx,(dfdx * -b) + fb],x);
        
        obj1 = plot(r(k),subs(fxs,vs,r(k)),'ko');    
        obj2 = fplot(dfunc,'b');
        %obj3 = plot([b,b],[0,fb],'--');
        %pause(0.5);       
        delete(obj1); delete(obj2);%Borra el punto medio actual y su línea de apoyo  
        
        s = strcat('A(',num2str(round(a,4)),',',num2str(round(fa,4)),'),B(',num2str(round(b,4)),',',num2str(round(fb,4)),')');
        
        set(obj(1),'markerfacecolor','w');
        obj = plot([a,b],[fa,fb],'ko','markerfacecolor','r','DisplayName',s); %Actualiza los límites
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
end
%declaracion de la funcion fsec3
%param fx (funcion a estudiar)
%param i (intervalo de entrada)
%param n (iteraciones para buscar el error)
% function [r,z,w] = fsec3(fx,i,n) 
% 	r = zeros(2);	%creamos un arreglo de ceros para las raices de la funcion
%     z{1} = i;
%     z{2} = r;
%     w = [n,'ci','ec','ea','er','e(n)'];
% end	%fin de la funcion


%declaracion de la funcion fsec3
%param fx (funcion a estudiar)
%param i (intervalo de entrada)
%param n (error de la funcion secante)
function [r,z,w] = fsec4(fx,i,e)

	syms  x 
    fxs = str2sym(fx);%convertir la funcion a simbolica
    vs = symvar(fxs);%Encontrar la variable simbólica en fxs.
    %plot_fun(fxs,'k-','LineWidth',2)
    fplot(fxs,'k-','LineWidth',2,'DisplayName',fx); grid on; hold on;
    obj = plot(i,[subs(fxs,vs,i(1)),subs(fxs,vs,i(2))],'ko','MarkerFaceColor','r');
    title(fx);
    
    %set(gcf,'Position',[551,86,560,420],'Units','pixels');
    a = i(1);
    b = i(2);
    
    fa = feval(inline(fx),a);
    fb = feval(inline(fx),b);
    k=1;
    r(k) = b - fb*((b-a)/(fb-fa));
    error(k) = abs(b-a);
    ea(k) = abs((b-a)/b)*100;
    legend()
    while error(k)>e
        k = k+1;
        ylim([-1 5])
        xlim([-1 15])
        b = a;
        a = r(k-1);
        fa = feval(inline(fx),a);
        fb = feval(inline(fx),b);
        r(k) = b - fb*((b-a)/(fb-fa));
        error(k) = abs(b-a);
        ea(k) = abs((b-a)/b)*100;
        dfdx = (fb - fa)/(b - a);
        dfunc = poly2sym([dfdx,(dfdx * -b) + fb],x);
        
        obj1 = plot(r(k),subs(fxs,vs,r(k)),'ko');    
        obj2 = fplot(dfunc,'b');
        %obj3 = plot([b,b],[0,fb],'--');
        %pause(0.5);       
        delete(obj1); delete(obj2);%Borra el punto medio actual y su línea de apoyo  
        
        s = strcat('A(',num2str(round(a,6)),',',num2str(round(fa,3)),'),B(',num2str(round(b,6)),',',num2str(round(fb,3)),')');
        
        set(obj(1),'markerfacecolor','w');
        obj = plot([a,b],[fa,fb],'ko','markerfacecolor','r','DisplayName',s); %Actualiza los límites
        %obj = plot(i,[subs(fxs,vs,i(1)),subs(fxs,vs,i(2))],'ko','MarkerFaceColor','r');
        %ylim(yLimits)
        %pause(0.1);
        %xLimits = get(gca,'XLim');  % Get the range of the x axis
        %yLimits = get(gca,'YLim');  % Get the range of the y axis
        
    end
    
    %plot(x,subs(fxs,vs,x),'ko','MarkerFaceColor','b');
    z{1} = i;
    z{2} = r;
    w = {k,'ci',error,'ea',error(end),error(end-1)};
end

% 	r = zeros(2);	%creamos un arreglo de ceros para las raices de la funcion
%     z{1} = i;
%     z{2} = r;
%     w = ['ci','ec','ea','er','n(e)'];	%declaramos un arreglo para los errores
% end	%fin de la funcion

