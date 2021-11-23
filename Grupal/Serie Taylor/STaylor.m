function [tx,Rx,R,r,Ea,Er] = STaylor(fx,n,c,e,N,x)
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
%      tx: Funcion de taylor
%      Rx: Formula del error de truncamiento
%      R: Radio mayor de convergencia
%      r: Radio menor de convergencia donde diverge mas rapdio la funcion
%      Ea: Error Absoluto
%      Er: Error relativo
% 
    if nargin ~= 6
        error('Ingrese todos los argumentos');
    end
    [v_fx,v_n,v_c,v_e,v_N,v_x] = validate(fx,n,c,e,N,x);
    v = [v_fx,v_n,v_c,v_e,v_N,v_x];
    %disp(v)
    if all(v == true)
        disp('Validado')
    else
        disp('Igresa de nuevo')
        tx = NaN;
        Rx = NaN;
        R = NaN;
        r = NaN;
        Ea = NaN;
        return;
    end

    
    %Se procede a realizar los calculos en la serie de taylor
    fxs=str2sym(fx);%convertir la funcion a simbolica
    vs = symvar(fxs);%Encontrar la variable simbólica en fxs.
    Valor_aproximado=double(subs(fxs,vs,x)); %Valor real al cual aproximarse.
    
    for i=0:n
        s(i+1)=subs(diff(fxs,vs,i),vs,c)/factorial(i)*(x-c)^i;
        sigma(i+1)=sum(double(s));
       
        %polinomio de Taylor
        
        %Tp(i+1)= STaylor(fxs,i+1,c,e,i+1);
        tx(i+1)= poly2sym(fliplr(s(1:i+1)),vs);
        
        Er(i+1)=abs(((Valor_aproximado-sigma(i+1))/Valor_aproximado))*100; %error relativo
        if i >= 1 %Error absoluto
            Ea(i+1) = abs((sigma(i+1)-sigma(i))/sigma(i+1))*100;
        end
        
    end
    
    %ezplot(fxs,[-5,5]);
    
    fplot(fxs,'LineWidth',2); grid on; hold on
    plot(x,Valor_aproximado,'ro','MarkerFaceColor','r'); 
    hold on
    plot(c,subs(fxs,vs,c),'bo','MarkerFaceColor','b');
%     for i = 2:n+1
%         hold on
%         fplot(Ea(i));
%     end
    %txt1 = strcat(strseq('T_p_',1:n+1),{'(x)'});
    %legend([cellstr(fun); {['f(',num2str(x),')']}; {'a'}; txt1],'Location','Best')
    
    %---------------Tabla de resultados------------
    %aprox = sigma(end); etf = Er(end); eaf = Ea(end);
    %Encabezado = {'Iteracion','Valor aproximado','Error relativo porcentual','Error absoluto porcentual'};
    %T = num2cell([(1:n+1)', sigma', Er', Ea']); M = [Encabezado;T];
    %Rx=max(T);
    
    %tx=true;
    Rx=true;
    R=true;
    disp(tx);
    disp('valor aproximado: ')
    disp(Valor_aproximado);
    disp('Error relativo: ')
    disp(Er)
    r=true;
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


