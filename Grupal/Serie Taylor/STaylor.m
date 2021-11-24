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
% 
    
    %[v_fx,v_n,v_c,v_e,v_N,v_x] = validate(fx,n,c,e,N,x);
    %v = [v_fx,v_n,v_c,v_e,v_N,v_x];
    %disp(v)
    %if all(v == true)
    %    disp('Validado')
    %else
    %    disp('Igresa de nuevo')
    %    tx = NaN;
    %    Rx = NaN;
    %    R = NaN;
    %    r = NaN;
    %    Ea = NaN;
    %    return;
    %end

    
    %Se procede a realizar los calculos en la serie de taylor
%     fxs=str2sym(fx);%convertir la funcion a simbolica
%     vs = symvar(fxs);%Encontrar la variable simbólica en fxs.
%     Valor_aproximado=double(subs(fxs,vs,x)); %Valor real al cual aproximarse.
%     
%     %Imprimo los valores 
%     disp('Impresion de datos.')
%     fprintf('f(x): %s\n',fxs)
%     fprintf('n: %i\n',n)
%     
%     
%     for i=0:n
%         s(i+1)=subs(diff(fxs,vs,i),vs,c)/factorial(i)*(x-c)^i;
%         sigma(i+1)=sum(double(s));
%        
%         %polinomio de Taylor
%         
%         %Tp(i+1)= STaylor(fxs,i+1,c,e,i+1);
%         tx(i+1)= poly2sym(fliplr(s(1:i+1)),vs);
%         
%         Er(i+1)=abs(((Valor_aproximado-sigma(i+1))/Valor_aproximado))*100; %error relativo
%         if i >= 1 %Error absoluto
%             Ea(i+1) = abs((sigma(i+1)-sigma(i))/sigma(i+1))*100;
%         end
%         
%     end
%     
%     %Imprimo los valores 
%     disp('Impresion de datos.')
%     fprintf('f(x): %s\n',fxs)
%     fprintf('n: %d\n',n)
%     fprintf('n: %d\n',n)
%     %ezplot(fxs,[-5,5]);
%     
%     fplot(fxs,'LineWidth',2); grid on;
%     hold on
%     plot(x,Valor_aproximado,'ro','MarkerFaceColor','r');
%     hold on
%     plot(c,subs(fxs,vs,c),'bo','MarkerFaceColor','b');
%      for i = 2:n+1
%          hold on
%          fplot(tx(i));
%      end
%     %legend()
%     txt1 = strcat(strseq('T_p_',1:n+1),{'(x)'});
%     legend([cellstr(fx); {['f(',num2str(x),')']}; {'a'}; txt1],'Location','Best')
%     
%     %---------------Tabla de resultados------------
%     %aprox = sigma(end); etf = Er(end); eaf = Ea(end);
%     %Encabezado = {'Iteracion','Valor aproximado','Error relativo porcentual','Error absoluto porcentual'};
%     %T = num2cell([(1:n+1)', sigma', Er', Ea']); M = [Encabezado;T];
%     %Rx=max(T);
%     
%     %tx=true;
%     Rx=true;
%     R=true;
%     disp(tx);
%     disp('valor aproximado: ')
%     disp(Valor_aproximado);
%     disp('Error relativo: ')
%     disp(Er)
%     r=true;

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
        otherwise
            error('Ingrese los parametros correctos')
    end
    toc
end

function [v_fx,v_n,v_c,v_e,v_N,v_x] = validate(fx,n,c,e,N,x)
% validate: valida los valores 
% [v_fx,v_c,v_e,v_N,v_x] = validate(fx,n,c,e,N,x) 
% 
% :param args: 
%    fx: Funcion a evaluar
%    n: orden del polinomio
%    c: Centro de la funcion
%    e: Valor de Epsilon
%    N: Error residual
%    x: Punto a evaluar la funcion
% :type args: boolean 
% :returns: boolean 
% :raises: :exc:`STaylor(args)`

    
    % defino las funciones tracedentales
    tras = ["sin",'cos','tan','exp','csc','log','sinh','cosh','tanh',]; 
    
    %Asigno los valores por defecto de los returns
    v_fx = false;
    v_n = false;
    v_c = false;
    v_e = false;
    v_N = false;
    v_x = false;
    
    %Verifico si es una funcion trasedental
    for i = 1:length(tras)
        if strfind(fx,tras(1,i))
            v_fx = true;
            break;
        else
            v_fx = false;
        end
    end
    
    %I check if "c" is a real
    if isreal(c)==true && isnumeric(c) 
        v_c = true;
    else 
        v_c = false;
    end
    
    %I check if "e" is a real
    if isreal(e)==true && isnumeric(e) 
        v_e = true;
    else 
        v_e = false;
    end
        
    %I check if "x" is a real
    if isreal(x) && isnumeric(x) 
        v_x = true;
    end
    
    %I check if "n" is positive integer
    if isnumeric(n) && mod(n,1)==0 && n>0
        v_n= true;
    end
    %I check if "n" is positive integer
    if isnumeric(N) && mod(N,1)==0 && N>0
        v_N = true;
    end
   
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
        s(i+1)=subs(diff(fxs,vs,i),vs,c)/factorial(i)*(x-c)^i
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
    
    xlim([-(double(R)+c/2) double(R)+c*2])
    ylim([-(double(R)+c/2) double(R)+c*2])
    
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
    
    xlim([-(double(R)+c/2) double(R)+c*2])
    ylim([-(double(R)+c/2) double(R)+c*2])
    
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
