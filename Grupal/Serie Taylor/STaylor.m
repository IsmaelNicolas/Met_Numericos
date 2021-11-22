function [tx,Rx,R,r,Ea,Er] = STaylor(fx,n,c,e,N,x)
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
% :raises: :exc:`STaylor(args)`
    
    [v_fx,v_c,v_e,v_N,v_x] = validate(fx,n,c,e,N,x);
    v = [v_fx,v_c,v_e,v_N,v_x];
    disp(v) 
%     if all(v == true)
%         disp('Validado')
%     else
    if all(v == true)
        disp('Ingresa argumentos validos')
    else
        disp('Igresa de nuevo')
        tx = true;
        Rx = true;
        R = true;
        r = true;
        Ea = true;
        return;
    end
    tx = true;
    Rx = true;
    R = true;
    r = true;
    Ea = true;
    Er = true;
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
        if fx==tras(1,i)
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
    if isreal(x)==true && isnumeric(x) 
        v_x = true;
    else 
        v_x = false;
    end
   
end
