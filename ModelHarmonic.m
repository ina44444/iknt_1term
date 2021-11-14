classdef ModelHarmonic < Model

    
    properties (Access = public)
        harmonic;
    end
    
    methods (Access = public)
        function obj = ModelHarmonic(A,f,t)
            if(nargin>0)

                obj.harmonic = A*sin(2*pi*f*t);
                obj.t = t;
            end
         end
        
        function printPlot(obj)
             figure ('Name','Harmonic','NumberTitle','off')
            
             plot (obj.t,obj.harmonic), grid on;
             title('Harmonic process');
        end
        

    end
        
%         function obj = formPoliHarm(A1,f1,A2,f2,A3,f3,t)
%             
%             obj.harmonic = A1*sin(2*pi*f1*t)+ A2*sin(2*pi*f2*t)+A3*sin(2*pi*f3*t);
%         end
        methods (Static = true)
        function poliHarm = formPoliHarm(A1,f1,A2,f2,A3,f3,t)
            
            poliHarm = A1*sin(2*pi*f1*t)+ A2*sin(2*pi*f2*t)+A3*sin(2*pi*f3*t);
        end
        
         function harm_func_discr = discretization(A,f,t)
            delta_t = 1/(2*f);
            i = t/delta_t;
            harm_func_discr = A*sin(2*pi*f*i*delta_t);
         end
            
             function printPlot2(input,t, plotName)
             figure ('Name',plotName,'NumberTitle','off')
            
             plot (t,input), grid on;
             title(plotName);
       end
    end
end

