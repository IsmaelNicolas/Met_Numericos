function [I,F,Er,Ea,Rt] = fintg(f,a,b,n)
% FINTG integral numerica
% <strong>Llamada a la funcion</strong>
% [I,F,Er,Ea,Rt] = FINTG(f,a,b,n)
%
% <strong>Parametros de entrada</strong>
% <strong>f:</strong>  Funcion f(x)
% <strong>a:</strong>  Limite inferior 
% <strong>b:</strong>  Limite superior
% <strong>n:</strong>  numero de intervalos 
% 
%  <strong>Parametros de salida</strong>
% <strong>I:</strong>  Valor real de la integral
% <strong>F:</strong>  Valor teorico de la integral 
% <strong>Er:</strong> Error relativo
% <strong>Ea:</strong> Error absoluto
% <strong>Rt</strong>  Error de truncamiento

if nargout == 0
   I =  0;
   F =  0;
   Er = 0;
   Ea = 0;
   Rt = 0;
end

in = 0; e1=0;e2=0;

if nargin <4 || nargin >4
    help fintg
    error('Ingresa numero de  parametros correcto')
end
   naux =n;
   h = (b-a)/n;
   while n>0
       if n>4
           if mod(n,4) == 0
                disp('Boole simple')
                a1 = a + (naux-n)*h;
                b1 = a1 + 4*h;
               	h1 = (b-a)/n;
                fprintf("<strong>a: %f,b: %f, n: %d </strong> \n",a1,b1,n);
                [in1,e1,e2] = boole(a1,b1)  ;
                figure;
                hold on;
                grid on;
                fplot(f);
                title('Boole simple');
                in = in+in1;
                n = n-4 ;
           elseif mod(n,3) == 0
                disp('Simpson 3/8 Compuesto')
%                 a1 = a + (naux-n)*h;
%                 b1 = a1 +3*h;
                 fprintf("a: %f,b: %f, n: %d\n",a1,b1,n);
%                 n = n-3 ;
                 simpson38C(a,b,h);
                 figure;
                 hold on;
                 grid on;
                 fplot(f);
                 title('Simpson 3/8 Compuesto');
                n=0;
           elseif mod(n,2) == 0
                disp('Simpson 1/3 Compuesto')
                %a1 = a + (naux-n)*h;
                %b1 = a1 +2*h;
                %disp(naux)
                fprintf("a: %f,b: %f, n: %d\n",a,b,n);
                %n = n-2;
                [in1,e1,e2]=simpsonC13(a,b,h);
                figure;
                hold on;
                grid on;
                fplot(f);
                title('Simpson 1/3 Compuesto');
                n=0;
                in=in+in1;
           else
                disp('Trapecio multiple')
                a1 = a + (naux-n)*h;
                b1 = a1 +1*h;
                fprintf("a: %f,b: %f, n: %d\n",a1,b1,n);
                [in1,e1,e2]=trapmult(a,b,h);
                n = 0 ;
                in = in1+in;
                figure;
                hold on;
                grid on;
                fplot(f);
                title('Trapecio multiple');
           end
       elseif n==4
            disp('Boole simple')
            a1 = a + (naux-n)*h;
            b1 = a1 +4*h;
            h1 = (b-a)/n;
            fprintf("<strong>a: %f,b: %f, n: %d </strong> \n",a1,b1,n);
            [in1,e1,e2] = boole(a1,b1); 
            in = in+in1;
            n = n-4 ;
            figure;
            hold on;
            grid on;
            fplot(f);
            title('Boole simple');
       elseif n==3
            disp('Simpson 3/8 Simple')
            a1 = a + (naux-n)*h;
            b1 = a1 +3*h;
            simpson38(a1,b1,h)
            fprintf("a: %f,b: %f, n: %d\n",a1,b1,n);
            n = n-3 ;
            figure;
            hold on;
            grid on;
            fplot(f);
            title('Simpson 3/8 Simple');
       elseif n ==2
           disp('Simpson 1/3 Simple')
           a1 = a + (naux-n)*h;
           b1 = a1 +2*h;
           fprintf("a: %f,b: %f, n: %d\n",a1,b1,n);
           n = n-2 ;
           [in1,e1,e2]=simpson13(a1,b1,h);
           in=in+in1;
           figure;
           hold on;
           grid on;
           fplot(f);
           title('Simpson 1/3 Simple');
       elseif n == 1
            disp('Trapecio Simple')
            a1 = a + (naux-n)*h;
            b1 = a1 +1*h;
            fprintf("a: %f,b: %f, n: %d\n",a1,b1,n);
            n = n-1 ;
            figure;
            hold on;
            grid on;
            fplot(f);
            title('Grafica Trapecio Simple');
       end
   end
    
   fprintf("Integral: %f\n",in);
   
   I =  0;
   F =  0;
   Er = 0;
   Ea = 0;
   Rt = 0;
    function y = fx(x)
        X = sym('x');
        y = double( subs( sym(f),X,x) );
    end
    function intg = simpson38(a,b,h)
        x = a:h:b;
        intg = 3*h/8*(double(fx(x(1)) + 3* fx(x(2)) + 3*fx(x(3)) +fx(x(4)) ) );
    end
    
    function[I,Er,Ea] = boole(a,b)
        x = a:h:b;  
        I = (2/45)*h*(7*fx(a) + 32*fx(x(2)) + 12*fx(x(3)) + 32*fx(x(4)) +7*fx(b) );
        Ea=abs((integral(f,a,b)-I)/integral(f,a,b));
        Er=abs(((integral(f,a,b)-I)/integral(f,a,b))*100);
        T = 0; 
        T(1,1) = 0; %T=arreglo para crear una tabla
        T(1,1)=I;T(1,2)=Er;T(1,3)=Ea;
        T = array2table(T,'VariableNames',{'Integral','Ea','Er'});
        disp(T)
    end

    function [I,Er,Ea]=simpson13(a,b,h)
        %h=(b-a)/2;
        I=double(h*(subs(f,a)+4*subs(f,(a+b)/2)+subs(f,b))/3);
        Ea=abs((integral(f,a,b)-I)/integral(f,a,b));
        Er=abs(((integral(f,a,b)-I)/integral(f,a,b))*100);
        T = 0; 
        T(1,1) = 0; %T=arreglo para crear una tabla
        T(1,1)=I;T(1,2)=Er;T(1,3)=Ea;
        T = array2table(T,'VariableNames',{'Integral','Er','Ea'});
        disp(T)

    end

    function [I,Er,Ea]=simpsonC13(a,b,h)
        %h=(b-a)/n;
        x=a+h*(0:n);
        y=feval(f,x);
        I=h*(2*sum(y)+2*sum(y(2:2:n))-y(1)-y(n+1))/3;
        Ea=abs((integral(f,a,b)-I)/integral(f,a,b));
        Er=abs(((integral(f,a,b)-I)/integral(f,a,b))*100);
        T = 0; 
        T(1,1) = 0; %T=arreglo para crear una tabla
        T(1,1)=n;T(1,2)=I;T(1,3)=Er;T(1,4)=Ea;
        T = array2table(T,'VariableNames',{'Itervalos','Integral','Er','Ea'});
        disp(T)
    end

   function intg = simpson38C(a,b,h)
       x = a:h:b;
       f1 = fx(x);
       disp(x)
       disp(f1)
       [~,n1] = size(x);
       n1 = n1-1; 
       In = (3*h/8)*( fx(a) + 3*sum(f1(2:3:n1-1)) + 3*sum(f1(3:3:n1)) +2*sum(f1(4:3:n1-2)) +fx(b) );
       fprintf("I: %f\n",In);
       intg = In;
   end


    function y=ecrecta(x1,y1,x2,y2)
        x0=x1:h:x2;
        m=(y2-y1)/(x2-x1);
        y=m*(x0-x1)+y1;
    end

   function [I,Er,Ea]=trapsimple(a,b)
   fa=subs(f,a); %fa es la funcion evaluada en el punto a
   fb=subs(f,b); %fb es la funcion evaluada en el punto b
   I=(b-a)*(fa+fb)/2; %Calculo el integral por el metodo de trapecio simple
   Ea=abs((integral(f,a,b)-I)/integral(f,a,b)); %Error absoluto
   Er=abs(((integral(f,a,b)-I)/integral(f,a,b))*100); %Error relativo
   T(1,1) = 0; %T=arreglo para crear una tabla
   T(1,1)=I;T(1,2)=Ea;T(1,3)=Er;
   T=array2table(T,'VariableNames',{'Integral','Ea','Er'}); %Nombro las variables de mi tabla
   disp(T) %Imprimo la tabla
   end

   function [I,Er,Ea]=trapmult(a,b,h)
   %Datos:
   %   f es el integrando, dado como una cadena de caracteres 'f'    %   a y b son los extremos interior y superior del intervalo de integracion
   %   n es el numero de subintervalos
   %   h es el paso entre subintervalos
   %Calculos:
   %   fa es la funcion evaluada en el punto a
   %   fb es la funcion evaluada en el punto b
   %   fs es sumatoria de funciones envaluados en distintos puntos    %   I es la aproximacion obtenida con la regla del trapecio multiple
   %   Er es el error relativo
   %   Ea es el error absoluto
   fa=subs(f,a);
   fb=subs(f,b);
   fs=0;
   T(1,1) = 0; %T=arreglo para crear una tabla
   x=a:h:b;
   [~,n]=size(x); %Dominio para x
   h=(b-a)/n;
   for i=1:(n-1)
       x(i)=a+h*i;
       fs=fs+subs(f,x(i));
       I=double(h*(fa+fb)/2+h*fs); %Calculo la Integral por el metodo del trapecio multiple
       Ea=abs((integral(f,a,b)-I)/integral(f,a,b)); %Error absoluto
       Er=abs(((integral(f,a,b)-I)/integral(f,a,b))*100); %Error relativo
       T(i,1)=i;T(i,2)=x(i);T(i,3)=I;T(i,4)=Ea;T(i,5)=Er; %Lleno la tabla con sus respectivos campos
   end
   T=array2table(T,'VariableNames',{'i','x(i)','Integral','Ea','Er'}); %Nombro las variables de tabla
   disp(T) %Imprimo la tabla
   end
end