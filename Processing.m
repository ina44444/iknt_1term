classdef Processing < handle

    
    properties
        inData
        outData
        t
    end
    
    methods
        function obj = Processing(data,time)
          if(nargin >0)
              obj.inData = data;
              obj.t = time;             
              
          end          
        end
        
        function outputArg = method1(obj,inputArg)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg = obj.Property1 + inputArg;
        end
    end
    
    methods(Static = true)
        
        function shifted = shift(inData, shiftConst)
            shifted = inData + shiftConst;
        end
            
        function spiked = spike (inData)
            maximum = max(inData);
            S = maximum*10;
            spiked = zeros(size(inData));
            r =randi(10,1);
            spks = randi(size(inData),r);
            for i = 1:r
                znak = randi([-1, 1],1);
                spiked(spks(1,i)) = znak*S;
            end
        end
        
        function antiShift = antishift(inData)
             meanValue = mean(inData);
             N = size(inData, 2);
             antiShift = zeros(N);
             for i = 1:N
                antiShift(i) = inData(i) - meanValue; 
             end
        end
        
        function medfiltLoopVoltage = antispike(inData)
            medfiltLoopVoltage = medfilt1(inData,3);
        end
        
    end
    
end

