function varargout = fsec(varargin)
		
	switch nargin
        case 1
            disp(1);
            fx = varargin{1};
            [varargout{1}] = fsec1(fx);
        case 2
            disp(2);
            fx = varargin{1};
            a = varargin{2};
            [varargout{1},varargout{2}] = fsec2(fx,a);
        case 3
            
            fx = varargin{1};
            a = varargin{2};
            if mod(varargin{3},1)==0 && isnumeric(varargin{3})
                n = varargin{3};
                [varargout{1},varargout{2},varargout{3}] = fsec3(fx,a,n);
            elseif isnumeric(varargin{3}) && isreal(varargin{3})
                e = varargin{3};
                [varargout{1},varargout{2},varargout{3}] = fsec4(fx,a,e);
            end
            
        otherwise
            warning('Ingrese un numero de parametros aceptables')
            for i = 1:nargout
               varargout{i} = NaN; 
            end
            return;
    end
end

function [r] = fsec1(fx)
    r = zeros(4);
    disp(fx)
end

function [r,z] = fsec2(fx,i)
	r = zeros(2);
    z{1} = i;
    z{2} = r;
    disp('z = { [a,b], r} ')
    disp('r')
    disp(z{1})
    disp('r')
    disp(z{2})
end

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

