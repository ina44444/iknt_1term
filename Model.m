classdef Model %% Модель - это абстрактный класс, все методы переоределяются в
    %Классах наследниках: ModelTrend, ModelNoise, ModelHarmonic

    
    properties (Access = protected)
       y; % значения функции
       t; % значения времени
        
    end
    
    methods (Access = public)
        %Constructor 
         function obj = Model(time)
            if (nargin> 0)
                obj.t = time;
                obj.y = 0;
            end
        end
    
    
% %     methods (Abstract = true)
% %         formModel(); 
% %     end
% %         
%   methods (Static = true)
        function printPlot(obj)
            plot(obj.t,obj.y);
        end
 end
    
end


