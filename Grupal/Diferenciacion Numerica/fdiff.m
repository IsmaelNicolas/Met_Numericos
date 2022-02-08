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
%
Ea = 0;
Er=0;
Rt=0;
F=0;
%Verifico si la llamada a la fucnion es correcta
if nargin ~= 5 || nargout ~= 4
   help fdiff
   error("Ingresa numero de parametros correcto")
end

X = sym('x');
tol = 0.0000001;
%Verifico el tipo de diferenciacion
switch t
    case 0
        diff_atras(f,x,h)
    case 1
        diff_adelante(f,x,h)
    case 2
        diff_centrada(f,x,h)
    case 3
        diff_atras(f,x,h)
        diff_adelante(f,x,h)
        diff_centrada(f,x,h)
    otherwise
        help fdiff
        error('Metodo no valido')
end
    %Subproceso para diferecniacion hacia atras
    function diff_atras(f,x,h)
        fprintf('<strong>Diferenciacion hacia atras\n</strong>')
        disp('Funcion:')
        disp(f)
        disp('Punto:')
        disp(x)
        disp('Paso:')
        disp(h)
        switch o
            case 1
                i = 1;
                dif = double(subs(diff(f,1),X,x));
                while dif-F > tol 
                    F = (3*subs(f,X,x)-4*subs(f,X,x-h) + subs(f,X,x-2*h) )/(2*h);
                    fprintf(" i: %d | F:%f | Ea:%f \n",i,double(F),dif-double(F));
                    i = i+1;
                    h = h*0.5;
                end
            case 2
                i = 1;
                dif = double(subs(diff(f,2),X,x));
                while dif-F > tol 
                    F = (2*subs(f,X,x)-5*subs(f,X,x-h) + 4*subs(f,X,x-2*h)- subs(f,X,x-3*h))/(h^2);
                    fprintf(" i: %d | F:%f | Ea:%f \n",i,double(F),dif-double(F));
                    i = i+1;
                    h = h*0.5;
                end
            case 3
                i = 1;
                dif = double(subs(diff(f,3),X,x));
                while dif-F > tol 
                    F = (5*subs(f,X,x)-18*subs(f,X,x-h) + 24*subs(f,X,x-2*h)- 14*subs(f,X,x-3*h)+3*subs(f,X,x-4*h) )/(2*h^3);
                    fprintf(" i: %d | F:%f | Ea:%f \n",i,double(F),dif-double(F));
                    i = i+1;
                    h = h*0.5;
                end
                raiz=solve(diff(f,3))
                p_infl=double(raiz);
                fplot(f);
                hold on;
                plot(p_infl, subs(f,p_infl),'g*')
                hold off;
            case 4
                i = 1;
                dif = double(subs(diff(f,4),X,x));
                while dif-F > tol 
                    F = (3*subs(f,X,x)-14*subs(f,X,x-h) + 26*subs(f,X,x-2*h)- 24*subs(f,X,x-3*h)+11*subs(f,X,x-4*h) -2*subs(f,X,x-5*h) )/(h^4);
                    fprintf(" i: %d | F:%f | Ea:%f \n",i,double(F),dif-double(F));
                    i = i+1;
                    h = h*0.5;
                end
                
            otherwise
                help fdiff
                error('Orden de derivada no valido')
        end
    end
    
    %Subproceso para diferenciacion hacia adelante
    function diff_adelante(f,x,h)
        fprintf('<strong>Diferenciacion hacia adelante</strong>')
        disp('Funcion:')
        disp(f)
        disp('Punto:')
        disp(x)
        disp('Paso:')
        disp(h)
        switch o
            case 1 % Orden 1
                i = 1;
                dif = double(subs(diff(f,1),X,x));
                while dif-F > tol 
                    F = (-3*subs(f,X,x)+4*subs(f,X,x+h) - subs(f,X,x+2*h) )/(2*h);
                    fprintf(" i: %d | F:%f | Ea:%f \n",i,double(F),dif-double(F));
                    i = i+1;
                    h = h*0.5;
                end
            case 2 % Orden 2
                i = 1;
                dif = double(subs(diff(f,2),X,x));
                while dif-F > tol 
                    F = (2*subs(f,X,x)-5*subs(f,X,x+h) + 4*subs(f,X,x+2*h)- subs(f,X,x+3*h))/(h^2);
                    fprintf(" i: %d | F:%f | Ea:%f \n",i,double(F),dif-double(F));
                    i = i+1;
                    h = h*0.5;
                end
            case 3 % Orden 3
                i = 1;
                dif = double(subs(diff(f,3),X,x));
                while dif-F > tol 
                    F = (-5*subs(f,X,x)+18*subs(f,X,x+h) - 24*subs(f,X,x+2*h)+ 14*subs(f,X,x+3*h)-3*subs(f,X,x+4*h) )/(2*h^3);
                    fprintf(" i: %d | F:%f | Ea:%f \n",i,double(F),dif-double(F));
                    i = i+1;
                    h = h*0.5;
                end
            case 4 % Orden 4
                i = 1;
                dif = double(subs(diff(f,4),X,x));
                while dif-F > tol 
                    F = (3*subs(f,X,x)-14*subs(f,X,x+h) + 26*subs(f,X,x+2*h)- 24*subs(f,X,x+3*h)+11*subs(f,X,x+4*h) -2*subs(f,X,x+5*h) )/(h^4);
                    fprintf(" i: %d | F:%f | Ea:%f \n",i,double(F),dif-double(F));
                    i = i+1;
                    h = h*0.5;
                end
            otherwise
                help fdiff
                error('Orden de derivada no valido')
        end
    end

    %Subproceso para diferenciacion centrada
    function diff_centrada(f,x,h)
        fprintf('<strong>Diferenciacion centrada</strong>')
        disp('Funcion:')
        disp(f)
        disp('Punto:')
        disp(x)
        disp('Paso:')
        disp(h)
        switch o
            case 1 % Orden 1
                i = 1;
                dif = double(subs(diff(f,1),X,x));
                while dif-F > tol 
                    F = (-subs(f,X,x+2*h) +8*subs(f,X,x+h) - 8*subs(f,X,x-h) + subs(f,X,x-2*h))/(12*h);
                    fprintf(" i: %d | F:%f | Ea:%f \n",i,double(F),dif-double(F));
                    i = i+1;
                    h = h*0.5;
                end
            case 2 % Orden 2
                i = 1;
                dif = double(subs(diff(f,2),X,x));
                
                while dif-F > tol 
                    F = (-subs(f,X,x+2*h) +16*subs(f,X,x+h)-30*subs(f,X,x) +16*subs(f,X,x-h) - subs(f,X,x-2*h))/(12*h^2);
                    fprintf(" i: %d | F:%f | Ea:%f \n",i,double(F),dif-double(F));
                    i = i+1;
                    h = h*0.5;
                end
            case 3 % Orden 3
                i = 1;
                dif = double(subs(diff(f,3),X,x));
                while dif-F > tol 
                    F = (-subs(f,X,x+3*h)+8*subs(f,X,x+2*h) -13*subs(f,X,x+h) + 13*subs(f,X,x-h) -8*subs(f,X,x-2*h)+ subs(f,X,x-3*h))/(8*h^3);
                    fprintf(" i: %d | F:%f | Ea:%f \n",i,double(F),dif-double(F));
                    i = i+1;
                    h = h*0.5;
                end
            case 4 % Orden 4
                i = 1;
                dif = double(subs(diff(f,4),X,x));
                while dif-F > tol 
                    %F = (-subs(f,X,x+3*h)+12*subs(f,X,x+2*h) +39*subs(f,X,x+h) +56*subs(f,X,x) - 39*subs(f,X,x-h)+12*subs(f,X,x-2*h)+ subs(f,X,x-3*h))/(6*h^4);
                    F = (subs(f,X,x+2*h) -4*subs(f,X,x+h) +6*subs(f,X,x) -4*subs(f,X,x-1*h) +subs(f,X,x-2*h) )/(h^4);
                    fprintf(" i: %d | F:%f | Ea:%f \n",i,double(F),dif-double(F));
                    i = i+1;
                    h = h*0.5;
                end
            otherwise
                help fdiff
                error('Orden de derivada no valido')
        end
    end
end