function [tx,Rx,R,r,Ea] = STaylor(fx,c,e,N,x)
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
    
    trasedental = ['sin','cos','tan','exp','csc','log']; 
    
    if(fx == 'sin')
        v_fx = true;
        v_c = true;
        v_e = true;
        v_N = true;
        v_x = true;
    else 
        v_fx = false;
        v_c = false;
        v_e = false;
        v_N = false;
        v_x = false;
    end
end
