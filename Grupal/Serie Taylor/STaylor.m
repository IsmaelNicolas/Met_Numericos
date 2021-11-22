function [tx,Rx,R,r,Ea] = STaylor(fx,n,c,e,N,x)
% STaylor: Aproxima el valor de una funcion 
%           en un punto dado utilizando la serie de taylor 
% [tx,Rx,R,r,Ea] = STaylor(fx,n,c,e,N,x) 
% 
% :param args: 
%    fx: Funcion a evaluar
%    n: numero de derivadas
%    c: Centro de la funcion
%    e: Valor de Epsilon
%    N: Error residual
%    x: Punto a evaluar la funcion
% :type args: boolean 
% :returns: boolean 
% :raises: :exc:`STaylor(args)`
    clc
    [v_fx,v_c,v_e,v_N,v_x] = validate(fx,n,c,e,N,x);
    v = [v_fx,v_c,v_e,v_N,v_x];
    disp(v(1)) 
    if v(1) == 1
        disp('Validado')
    elseif (v(1) == 0)
        disp('Ingresa una funcion trasedental')
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
end

function [v_fx,v_c,v_e,v_N,v_x] = validate(fx,n,c,e,N,x)
% validate: valida los valores 
% [v_fx,v_c,v_e,v_N,v_x] = validate(fx,n,c,e,N,x) 
% 
% :param args: 
%    fx: Funcion a evaluar
%    n: numero de derivadas
%    c: Centro de la funcion
%    e: Valor de Epsilon
%    N: Error residual
%    x: Punto a evaluar la funcion
% :type args: boolean 
% :returns: boolean 
% :raises: :exc:`STaylor(args)`

    
    % defino las funciones tracedentales
    tras = ["sin",'cos','tan','exp','csc','log','sinh','cosh','tanh',]; 
    
    v_fx = false;
    v_c = false;
    v_e = false;
    v_N = false;
    v_x = false;
    
    for i = 1:length(tras)
        if fx==tras(1,i)
            v_fx = true;
            break;
        else
            v_fx = false;
        end
    end
    
    
    
end
