classdef ModelTrend < Model
  
    
    properties (Access = public)
        linUp;
        linDown;
        expUp;
        expDown;
        
    end
    
    methods (Access = public)
        function obj = ModelTrend(time, coef_a, coef_b, coef_alpha, coef_beta)
          if(nargin >0)
                obj.t = time;
                coef_N = size(obj.t,2);
                for i= 1: coef_N
                    obj.linUp(i) = coef_a*(i - 1) + coef_b;
                    obj.linDown(i) = - coef_a*(i-1) + coef_b;
                    obj.expUp(i) = coef_beta*exp(-coef_alpha*(i-1));
                    obj.expDown(i) = coef_beta*exp(coef_alpha*(i-1));
                end
          end
        end
        

%     end
%     
%       methods (Static = true)
        function printPlot(obj)
            
            figure('Name','Trend','NumberTitle','off')
            tiledlayout(2,2)

            % Top left plot
                ax1 = nexttile;
                plot(ax1,obj.t,obj.linUp)
                title(ax1,'Linear Up Plot')
                ylabel(ax1,'y = ax + b')

            % Bottom  left plot
                ax2 = nexttile;
                plot(ax2,obj.t,obj.linDown)
                title(ax2,'Linear Down Plot')
                ylabel(ax2,'y = -ax + b)')

             % Top right plot
                ax3 = nexttile;
                plot(ax3,obj.t,obj.expUp)
                title(ax3,'Exponential Up Plot')
                ylabel(ax3,'y = beta*exp(-alpha*k), alpha<0')

            % Bottom right plot
                ax4 = nexttile;
                plot(ax4,obj.t,obj.expDown)
                title(ax4,'Exponential Down Plot')
                ylabel(ax4,'y = beta*exp(-alpha*k), alpha<1')

        end
    end     
      
end

