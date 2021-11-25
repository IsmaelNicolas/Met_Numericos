function varargout = fsec(varargin)
		
	switch nargin
        case 1
            fx = varargin{1};
            [varargout{1}] = fsec1(fx);
        case 2
            fx = varargin{1};
            a = varargin{2};
            [varargout{1},varargout{2}] = fsec2(fx,a);
        case 3
            fx = varargin{1};
            a = varargin{2};
            if mod(varargin{3},1)==0 && isnumeric(varargin{3})
                n = varargin{3};
                [varargout{1},varargout{2},varargout{3}] = fsec3(fx,a,n);
            elseif isnumeric(varargin{3}) && isreal(varargin{3})
                e = varargin{3};
                [varargout{1},varargout{2},varargout{3}] = fsec4(fx,a,e);
            end
            
        otherwise
            warning('Ingrese un numero de parametros aceptables')
            for i = 1:nargout
               varargout{i} = NaN; 
            end
            return;
    end
end

function [r] = fsec1(fx)
    r = zeros(4);
    disp(fx)
end

function [r,z] = fsec2(fx,i)
	r = zeros(2);
    z{1} = i;
    z{2} = r;
    disp('z = { [a,b], r} ')
    disp('r')
    disp(z{1})
    disp('r')
    disp(z{2})
end

function [r,z,w] = fsec3(fx,i,n)
	r = zeros(2);
    z{1} = i;
    z{2} = r;
    w = [n,'ci','ec','ea','er','e(n)'];
end

function [r,z,w] = fsec4(fx,i,e)
	r = zeros(2);
    z{1} = i;
    z{2} = r;
    w = ['ci','ec','ea','er','n(e)'];
end