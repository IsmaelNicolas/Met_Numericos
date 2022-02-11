function  [Ea,Er,Rt,F] = fdiff(f,o,t,x,h)
% FDIFF deriva funciones de manera numerica
%
% <strong>Llamada a la funcion</strong>
% [Ea,Er,Rt,F] = FDIFF(f,o,t,x,h)
%   
% <strong>Parametros de entrada</strong>
% <strong>f:</strong> Funcion deribable y continua
% <strong>o:</strong> Orden de la derivada 0< o <4
% <strong>t:</strong> Tipo de diferenciacion :
%       <strong>0</strong> - Diferenciacion hacia atras
%       <strong>1</strong> - Diferenciacion hacia adelante
%       <strong>2</strong> - Diferenciacion hacia centrada
%       <strong>3</strong> - Todos los metodos
% <strong>x:</strong> Punto a evaluar que debe de estar dentro del dominio
% <strong>h:</strong> Paso de la derivada

tic
Ea = 0;
Er=0;
Rt=0;
%Verifico si la llamada a la fucnion es correcta
if nargin ~= 5 || nargout ~= 4
   help fdiff
   error("Ingresa numero de parametros correcto")
end

if(validarf(f,o,x) == false)
   error('F no es continua y derivable en ese punto') 
end

h1 = h;
X = sym('x');
tol = 0.00000001;
F = 0;
fplot(f,'DisplayName','f(x)');
grid on
hold on
plot(x,subs(f,X,x),'d','DisplayName','(x,f(x))')
legend
%Verifico el tipo de diferenciacion
switch t
    case 0
        diff_atras(f,x,h)
    case 1
        diff_adelante(f,x,h)
    case 2
        diff_centrada(f,x,h)
    case 3
        F = 0;
        diff_adelante(f,x,h)
        F = 0;
        diff_atras(f,x,h)
        F = 0;
        diff_centrada(f,x,h)
    otherwise
        help fdiff
        error('Metodo no valido')
      
end
toc

    %Subproceso para diferecniacion hacia atras
    function diff_atras(f,x,h)
        fprintf('<strong>Diferenciacion hacia atras\n</strong>')
        dif = double(subs(diff(f,o),X,x));
        i = 1;
        T =0;
        T(1,1) = 0;
        switch o
            case 1
                while abs(dif-F) > tol
                    
                    F = (3*subs(f,X,x)-4*subs(f,X,x-h) + subs(f,X,x-2*h) )/(2*h);
                    %F= (subs(f,X,x)-subs(f,X,x-h))/(h);
                    Ea = real(dif-double(F));
                    Er = real(double((Ea/F)*100));
                    e = x-i*h1;
                    Rt = double(subs(diff(f,4),X,e));
                    T(i,1) = i; T(i,2) = h; T(i,3)=x+i*h1;
                    T(i,4)=Ea;T(i,5)=Er;T(i,6)=Rt;T(i,7)=real(double(F));
                    i = i+1;
                    h = h*0.5;
                end
                    T(i,1) = i; T(i,2) = h; T(i,3)=x+i*h1;
                    T(i,4)=Ea;T(i,5)=Er;T(i,6)=Rt;T(i,7)=real(double(F));
                pendiente(double(F))
            case 2
                while abs(dif-F) > tol 
                    F = (2*subs(f,X,x)-5*subs(f,X,x-h) + 4*subs(f,X,x-2*h)- subs(f,X,x-3*h))/(h^2);
                    Ea = real(dif-double(F));
                    Er = real(double((Ea/F)*100));
                    e = x-i*h1;
                    Rt = double(subs(diff(f,4),X,e));
                    T(i,1) = i; T(i,2) = h; T(i,3)=x+i*h1;
                    T(i,4)=Ea;T(i,5)=Er;T(i,6)=Rt;T(i,7)=real(double(F));
                    i = i+1;
                    h = h*0.5;
                end
                pCriticos(f);
            case 3 %Orden 3
                while abs(dif-F) > tol 
                    F = (5*subs(f,X,x)-18*subs(f,X,x-h) + 24*subs(f,X,x-2*h)- 14*subs(f,X,x-3*h)+3*subs(f,X,x-4*h) )/(2*h^3);
                    Ea = real(dif-double(F));
                    Er = real(double((Ea/F)*100));
                    e = x-i*h1;
                    Rt = double(subs(diff(f,4),X,e));
                    T(i,1) = i; T(i,2) = h; T(i,3)=x+i*h1;
                    T(i,4)=Ea;T(i,5)=Er;T(i,6)=Rt;T(i,7)=real(double(F));
                    i = i+1;
                    h = h*0.5;
                end
                pInflexion(f);
            case 4
                while abs(dif-F) > tol 
                    F = (3*subs(f,X,x)-14*subs(f,X,x-h) + 26*subs(f,X,x-2*h)- 24*subs(f,X,x-3*h)+11*subs(f,X,x-4*h) -2*subs(f,X,x-5*h) )/(h^4);
                    Ea = real(double(dif-double(F)));
                    Er = real(double((Ea/F)*100));
                    e = x-i*h1;
                    Rt = double(subs(diff(f,4),X,e));
                    T(i,1) = i; T(i,2) = h; T(i,3)=x+i*h1;
                    T(i,4)=Ea;T(i,5)=Er;T(i,6)=Rt;T(i,7)=real(double(F));
                    i = i+1;
                    h = h*0.5;
                end
                
            otherwise
                help fdiff
                error('Orden de derivada no valido')
        end
        Ea = real(Ea);
        Er = real(Er);
        F = double(F);
        T = array2table(T,'VariableNames',{'i','hi','f(hi)','Ea','Er','Rt','Derivada'});
        disp(T)
    end
    
    %Subproceso para diferenciacion hacia adelante
    function diff_adelante(f,x,h)
        fprintf('<strong>Diferenciacion hacia adelante\n</strong>')
        dif = double(subs(diff(f,o),X,x));
        i = 1;
        T(1,1) = 0;
        switch o
            case 1 % Orden 1
                while abs(dif-F) > tol 
                    F = (-3*subs(f,X,x)+4*subs(f,X,x+h) - subs(f,X,x+2*h) )/(2*h);
                    Ea = real(dif-double(F));
                    Er = real(double((Ea/F)*100));
                    e = x-i*h1;
                    Rt = double(subs(diff(f,4),X,e));
                    T(i,1) = i; T(i,2) = h; T(i,3)=x+i*h1;
                    T(i,4)=Ea;T(i,5)=Er;T(i,6)=Rt;T(i,7)=real(double(F));
                    i = i+1;
                    h = h*0.5;
                end
                pendiente(double(F))
            case 2 % Orden 2
                while abs(dif-F) > tol 
                    F = (2*subs(f,X,x)-5*subs(f,X,x+h) + 4*subs(f,X,x+2*h)- subs(f,X,x+3*h))/(h^2);
                    Ea = real(dif-double(F));
                    Er = real(double((Ea/F)*100));
                    e = x-i*h1;
                    Rt = double(subs(diff(f,4),X,e));
                    T(i,1) = i; T(i,2) = h; T(i,3)=x+i*h1;
                    T(i,4)=Ea;T(i,5)=Er;T(i,6)=Rt;T(i,7)=real(double(F));
                    i = i+1;
                    h = h*0.5;
                end
                pCriticos(f);
            case 3 % Orden 3
                while abs(dif-F) > tol 
                    F = (-5*subs(f,X,x)+18*subs(f,X,x+h) - 24*subs(f,X,x+2*h)+ 14*subs(f,X,x+3*h)-3*subs(f,X,x+4*h) )/(2*h^3);
                    Ea = real(dif-double(F));
                    Er = real(double((Ea/F)*100));
                    e = x-i*h1;
                    Rt = double(subs(diff(f,4),X,e));
                    T(i,1) = i; T(i,2) = h; T(i,3)=x+i*h1;
                    T(i,4)=Ea;T(i,5)=Er;T(i,6)=Rt;T(i,7)=real(double(F));
                    i = i+1;
                    h = h*0.5;
                end
                pInflexion(f);
            case 4 % Orden 4
                while abs(dif-F) > tol 
                    F = (3*subs(f,X,x)-14*subs(f,X,x+h) + 26*subs(f,X,x+2*h)- 24*subs(f,X,x+3*h)+11*subs(f,X,x+4*h) -2*subs(f,X,x+5*h) )/(h^4);
                    Ea = real(dif-double(F));
                    Er = real(double((Ea/F)*100));
                    e = x-i*h1;
                    Rt = double(subs(diff(f,4),X,e));
                    T(i,1) = i; T(i,2) = h; T(i,3)=x+i*h1;
                    T(i,4)=Ea;T(i,5)=Er;T(i,6)=Rt;T(i,7)=real(double(F));
                    i = i+1;
                    h = h*0.5;
                end
            otherwise
                help fdiff
                error('Orden de derivada no valido')
        end
        T(i,1) = i; T(i,2) = x-i*h1; T(i,3)=subs(f,X,x-i*h1);
        T(i,4)=Ea;T(i,5)=Er;T(i,6)=double(F);
        F = double(F);
        Ea = real(Ea);
        Er = real(Er);
        T = array2table(T,'VariableNames',{'i','hi','f(hi)','Ea','Er','Rt','Derivada'});
        disp(T)
        
    end

    %Subproceso para diferenciacion centrada
    function diff_centrada(f,x,h)
        fprintf('<strong>Diferenciacion centrada\n</strong>')
        dif = double(subs(diff(f,o),X,x));%Calculo valor teorico
        i = 1;
        T(1,1) = 0; %Inicializo array para crear la tabla
        switch o
            case 1 % Orden 1
                while abs(dif-F) > tol 
                    %Ingreso formula
                    F = (-subs(f,X,x+2*h) +8*subs(f,X,x+h) - 8*subs(f,X,x-h) + subs(f,X,x-2*h))/(12*h);
                    Ea = real(dif-double(F)); %Error Absoluto
                    Er = real(double((Ea/F)*100)); %Error relativo
                    e = x-i*h1; % valor epsilon
                    Rt = double(subs(diff(f,4),X,e)); %Error de truncamiento
                    %Añado valores a la tabla
                    T(i,1) = i; T(i,2) = h; T(i,3)=x+i*h1;
                    T(i,4)=Ea;T(i,5)=Er;T(i,6)=Rt;T(i,7)=real(double(F));
                    i = i+1;
                    h = h*0.5;
                end
                    T(i,1) = i; T(i,2) = h; T(i,3)=x+i*h1;
                    T(i,4)=Ea;T(i,5)=Er;T(i,6)=Rt;T(i,7)=real(double(F));
                    pendiente(double(F))
            case 2 % Orden 2               
                while abs(dif-F) > tol 
                    %Ingreso formula
                    F = (-subs(f,X,x+2*h) +16*subs(f,X,x+h)-30*subs(f,X,x) +16*subs(f,X,x-h) - subs(f,X,x-2*h))/(12*h^2);
                    Ea = real(dif-double(F));%Error Absoluto
                    Er = real(double((Ea/F)*100));%Error relativo
                    e = x-i*h1;
                    Rt = double(subs(diff(f,4),X,e)); %Error de truncamiento
                    %Agrego a las tablas
                    T(i,1) = i; T(i,2) = h; T(i,3)=x+i*h1;
                    T(i,4)=Ea;T(i,5)=Er;T(i,6)=Rt;T(i,7)=real(double(F));
                    i = i+1;
                    h = h*0.5;
                end
                pCriticos(f);
            case 3 % Orden 3
                while abs(dif-F) > tol 
                    F = (-subs(f,X,x+3*h)+8*subs(f,X,x+2*h) -13*subs(f,X,x+h) + 13*subs(f,X,x-h) -8*subs(f,X,x-2*h)+ subs(f,X,x-3*h))/(8*h^3);
                    Ea = real(dif-double(F));%Error Absoluto
                    Er = real(double((Ea/F)*100));%Error relativo
                    e = x-i*h1;
                    Rt = double(subs(diff(f,4),X,e));%Error de truncamiento
                    %Añade la tabla
                    T(i,1) = i; T(i,2) = h; T(i,3)=x+i*h1;
                    T(i,4)=Ea;T(i,5)=Er;T(i,6)=Rt;T(i,7)=real(double(F));
                    i = i+1;
                    h = h*0.5;
                end
                pInflexion(f);
            case 4 % Orden 4
                while abs(dif-F) > tol 
                    %F = (-subs(f,X,x+3*h)+12*subs(f,X,x+2*h) +39*subs(f,X,x+h) +56*subs(f,X,x) - 39*subs(f,X,x-h)+12*subs(f,X,x-2*h)+ subs(f,X,x-3*h))/(6*h^4);
                    F = (subs(f,X,x+2*h) -4*subs(f,X,x+h) +6*subs(f,X,x) -4*subs(f,X,x-1*h) +subs(f,X,x-2*h) )/(h^4);
                    Ea = real(dif-double(F));%Error Absoluto
                    Er = real(double((Ea/F)*100));%Error relativo
                    e = x-i*h1;
                    Rt = double(subs(diff(f,4),X,e));%Error de truncamiento
                    %Añado a la tabla
                    T(i,1) = i; T(i,2) = h; T(i,3)=x+i*h1;
                    T(i,4)=Ea;T(i,5)=Er;T(i,6)=Rt;T(i,7)=real(double(F));
                    i = i+1;
                    h = h*0.5;
                end
            otherwise
                help fdiff
                error('Orden de derivada no valido')
        end
        %Convierto los valores a numericos y no expresiones
        F = double(F);
        Ea = real(Ea);
        Er = real(Er);
        %Convierto array en tabla
        T = array2table(T,'VariableNames',{'i','hi','f(hi)','Ea','Er','Rt','Derivada'});
        disp(T) %Muestro tabla
    end

    %Funcion para validad que la funsion sea continua y derivable
    function val = validarf(f,o,x)
        X = sym('x');
        if(isreal(double(subs(diff(f,o),X,x))))
            val = true;
        else
            val = false;
        end
    end

    function pCriticos(f)
        raiz=solve(diff(f,2));
        p_crit=double(raiz);
        plot(p_crit, subs(f,p_crit),'ro','DisplayName','Maximos y minimos')
        title('Máximos y mínimos')
    end

    function pInflexion(f)
        raiz=solve(diff(f,3));
        p_infl=double(raiz);
        plot(p_infl, subs(f,p_infl),'ro','DisplayName','Puntos de Inflexion')
    end
    
    function pendiente(m)
        %Utilizo la formula punto pendiente
        y = m*(X-x) + subs(f,X,x);
        %plot recta tangente
        fplot(y,'DisplayName','Recta tangente')
        legend
    end

end