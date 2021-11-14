classdef ModelNoise < Model

    
    properties (Access = public)
        embedRand;
        handleRand;
    end
    
    methods (Access = public)
        %coef_N - размер последовательности, Coef_S - коэффициент,
        %регулирующий амплитуду рандома
       
        function obj = ModelNoise(coef_N, coef_S)
            if(nargin >0)
            %forming embedded random
            low_lim = -1;
            high_lim = 1;
            obj.embedRand = coef_S*((high_lim - low_lim) * rand(1, coef_N) + low_lim);
            
            %forming handled random
            my_random_seq1 = ones(1,coef_N);
            m = (2^31) - 1;
            a = 1220703;
            c = 7;
            for i = 2:(coef_N-2)
                my_random_seq1(i) = (mod((a*my_random_seq1(i-1) + c), m));
            end
            obj.handleRand = coef_S*((high_lim - low_lim) * (my_random_seq1/(2.198*10^9)) + low_lim);
            end
            
        end
        
        function outputArg = method1(obj,inputArg)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg = obj.Property1 + inputArg;
        end
        
         function printPlot(obj)
             figure('Name','Random generator','NumberTitle','off');
             tiledlayout(2,1)
             ax1 = nexttile;
             plot(ax1,obj.embedRand);
             title('Embedded random generator');
             
             ax2 = nexttile;
             plot(ax2,obj.handleRand);
             title('My random generator');
         end
    end
end

