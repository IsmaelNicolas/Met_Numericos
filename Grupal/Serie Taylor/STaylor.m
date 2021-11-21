function [tx,Rx,R,r,Ea] = STaylor(fx,c,e,N,x)
    clc
    [v_fx,v_c,v_e,v_N,v_x] = validate(lower(fx),lower(c),lower(e),lower(N),lower(x));
    v = [v_fx,v_c,v_e,v_N,v_x];
    if all(v==true)
        disp('Validado')
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

function [v_fx,v_c,v_e,v_N,v_x] = validate(fx,c,e,N,x)
    
    tras = ["sin",'cos','tan','exp','csc','log','sinh','cosh','tanh',]; 
    
    v_fx = false;
    v_c = false;
    v_e = false;
    v_N = false;
    v_x = false;
    
    for i = 1:length(tras)
        if fx==tras(1,i)
            v_fx = true;
            return;
        end
    end
        
end
