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
                in = in+in1;
                n = n-4 ;
           elseif mod(n,3) == 0
                disp('Simpson 3/8 Compuesto')
%                 a1 = a + (naux-n)*h;
%                 b1 = a1 +3*h;
                 fprintf("a: %f,b: %f, n: %d\n",a1,b1,n);
%                 n = n-3 ;
                simpson38C(a,b,h);
                n=0;
           elseif mod(n,2) == 0
                disp('Simpson 1/3 Compuesto')
                a1 = a + (naux-n)*h;
                b1 = a1 +2*h;
                fprintf("a: %f,b: %f, n: %d\n",a1,b1,n);
                n = n-2;
           else
                disp('Trapecio simple')
                a1 = a + (naux-n)*h;
                b1 = a1 +1*h;
                fprintf("a: %f,b: %f, n: %d\n",a1,b1,n);
                n = n-1 ;
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
       elseif n==3
            disp('Simpson 3/8 Simple')
            a1 = a + (naux-n)*h;
            b1 = a1 +3*h;
            simpson38(a1,b1,h)
            fprintf("a: %f,b: %f, n: %d\n",a1,b1,n);
            n = n-3 ;
       elseif n ==2
           disp('Simpson 1/3 Simple')
           a1 = a + (naux-n)*h;
           b1 = a1 +2*h;
           fprintf("a: %f,b: %f, n: %d\n",a1,b1,n);
           n = n-2 ;
       elseif n == 1
            disp('Trapecio Simple')
            a1 = a + (naux-n)*h;
            b1 = a1 +1*h;
            fprintf("a: %f,b: %f, n: %d\n",a1,b1,n);
            n = n-1 ;
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
        Er=abs((integral(f,a,b)-I)/integral(f,a,b));
        Ea=abs(((integral(f,a,b)-I)/integral(f,a,b))*100);
        T = 0; 
        T(1,1) = 0; %T=arreglo para crear una tabla
        T(1,1)=I;T(1,2)=Er;T(1,3)=Ea;
        T = array2table(T,'VariableNames',{'Integral','Ea','Er'});
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
end