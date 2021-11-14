classdef Analysis < handle
   
    
    properties
        inData
        t
        minValue
        maxValue
        func_size
        meanValue
       dispersion
       standartDeviation
       meanSquare
       meanSquareError
       assymetry
       assymetryCoef
       kurtosis
       kurtosisCoef
        
    end
    
    methods
        function obj = Analysis(inputArg1,inputArg2)
            if(nargin >0)
                obj.inData = inputArg1;
                obj.t = inputArg2;
                obj.minValue = min (obj.inData);
                obj.maxValue = max (obj.inData);
                obj.func_size = size(obj.inData, 2);
                obj.meanValue = (1/obj.func_size)*sum(obj.inData);
            end
        end
   
        function obj = dispersionCalc(obj)
            sq_sum = 0;
            for i=1:obj.func_size
                 sq_sum = (sq_sum + (obj.inData(1,i) - obj.meanValue).^2);
            end
            obj.dispersion = (1/obj.func_size)*sq_sum;
        end
        
        function obj = meanSquareCalc(obj)
             mean_sqr = 0;
            for i=1:obj.func_size
                 mean_sqr = (mean_sqr + (obj.inData(1,i)).^2);
            end
            obj.meanSquare = (1/obj.func_size)*mean_sqr;
        end
        
        function obj = assymetryCalc(obj)
            cb_sum = 0;
            for i=1:obj.func_size
                 cb_sum = (cb_sum + (obj.inData(1,i) - obj.meanValue).^3);
            end
            obj.assymetry = (1/obj.func_size)*cb_sum;
            
        end
        
        function obj = kurtosisCalc(obj)
            forth_sum = 0;
            if (obj.meanValue<0)
               obj.meanValue = obj.meanValue*(-1);
            end
            for i=1:(obj.func_size)
                 forth_sum = forth_sum + ((obj.inData(1,i) - obj.meanValue).^4);
            end
            obj.kurtosis = (1/obj.func_size)*forth_sum;
            
        end
        
        function obj = gamma1Calc(obj)
            obj.assymetryCoef = obj.assymetry/(obj.standartDeviation);          
        end
        
        function obj = gamma2Calc(obj)
%             obj.kurtosis = obj.kurtosisCalc;
%             obj.standartDeviation = obj.sigmaCalc;
%             a = 6;
            obj.kurtosisCoef = (obj.kurtosis/(obj.standartDeviation.^4)-3);          
         end
        function obj = sigmaCalc(obj)
             obj.standartDeviation = sqrt(obj.dispersion);          
        end
              
        function obj = epsilonCalc(obj)
            obj.meanSquareError = sqrt(obj.meanSquare);          
        end
        
       
        
    end
    
    
   methods (Static = true)
              

      function printResult(input,t)
                 fprintf('Kurtosis test %f\n',(gamma2 - kurt2));
      end
      
      function autocorr(func)
          figure(1)
            autocorr(func),grid on;
            title ('Autocorrelation'); 
      end
      
      function pdf(func)
          figure(2)
            histogam(func),grid on;
            title ('Probability dencity function'); 
      end
      
      function crossCorr(func1, func2)
          figure(3)
          crosscorr(func1, func2),grid on;
          title ('Cross correlation');
      end
       
      function printPlot(input, t, plotName)
             figure ('Name',plotName,'NumberTitle','off')
            
             plot (t,input), grid on;
             title(plotName);
      end
       
      function Stationary (func_seq, bound_interval)
            % Stationary
            func_size = size(func_seq, 2);
            sq_sum2 = 0;
            mean_value_stat = 0;
            m=0;
            numb_in = func_size/bound_interval;
            for k=1:bound_interval
                for i = 1:numb_in
                    mean_value_stat = mean_value_stat + func_seq(m+i);    
                end
                mean_value_m(k) = (1/numb_in)*(mean_value_stat);
                mean_value_stat = 0;
                % Dispersion
                for j=1:numb_in
                    sq_sum2 = (sq_sum2 + (func_seq(m+j) - mean_value_m(k))^2);
                end
                dispersion_m(k) = (1/func_size)*sq_sum2;
                m = k*numb_in;
                sq_sum2 = 0;
            end


            for i = 1:(bound_interval-1)

                if (abs(dispersion_m(i))<abs(dispersion_m(i+1))||abs(dispersion_m(i))==abs(dispersion_m(i+1)))
                    diff(i) = abs(dispersion_m(i+1))/abs(dispersion_m(i));
                else diff(i) = abs(dispersion_m(i))/abs(dispersion_m(i+1));

                end
                if (diff(i)>1.1)
                    fprintf('Process is not stationary\n');
                    break
                else
                    fprintf('Process is stationary\n');
                end
   
            end


      end
      
      
   end
end

