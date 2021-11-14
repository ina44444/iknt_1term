%% input data
t = 0:1/100:10-1/100;
k1=1;
k2=50;
a1 = 0.01;
b1 = 1;

%%  1 week 
model1 = ModelTrend(t,k1,k2,a1,b1);
model1.printPlot;

%% 2 week
noise = ModelNoise (1000,5);
noise.printPlot;

figure('Name','Rand + trend','NumberTitle','off');
% nosySig = model1.linUp + noise.embedRand;
% plot (t,nosySig);
%% 3 week
t = 0.01:0.01:10;
A1 = 10;
f1 = 4;
A2 = 100;
f2 = 47;
A3 = 15;
f3 = 173;
harm1 = ModelHarmonic(A1,f1,t);
harm1.printPlot;
harm2 = ModelHarmonic.formPoliHarm(A1,f1,A2,f2,A3,f3,t);
harm1.printPlot2(harm2,t,'Polyharmonic');
%% Statistics
statistic = Analysis(noise.embedRand,t);
D = statistic.dispersionCalc.dispersion;
Sigma = statistic.sigmaCalc.standartDeviation;

psi = statistic.meanSquareCalc.meanSquare;
epsilon = statistic.epsilonCalc.meanSquareError;

A = statistic.assymetryCalc.assymetry;
gamma1 = statistic.gamma1Calc.assymetryCoef;

E = statistic.kurtosisCalc.kurtosis;
gamma2 = statistic.gamma2Calc.kurtosisCoef;

fprintf(' Dispersion: %f \n Standart deviation %f: \n Mean square: %f \n Mean square error %f: \n Asymmetry: %f \n Asymmetry coificient: %f \n Kurtasis: %f \n Kurtasis coificient: %f \n ', ...
D, Sigma, psi, epsilon, A, gamma1, E, gamma2);
%-----Some test--------
% % fprintf('Dispersion of AWGN %f\n',D.dispersion);
% test = var(noise.embedRand);
% fprintf('Right Dispersion of AWGN %f\n',test);
% %---------------------------
% 
% kurt2 = kurtosis(noise.embedRand);
% fprintf('Kurtosis test %f\n',(gamma2 - kurt2));
%---------------------------
%% Stationary
whiteNoise = awgn(harm2,5);
statistic.Stationary(whiteNoise,5);

%% Plot PDF, ACF, CCF
statistic.autocorr(noise.embedRand);
statistic.crossCorr(noise.embedRand,harm2);
%% Processing
%Сигнал со спайками аддитивный
shiftSignal = Processing.shift(harm1.harmonic, 20);
spikeSignal = Processing.spike(harm1.harmonic);
Analysis.printPlot (shiftSignal, t, 'shift');
antishift = Processing.antishift(shiftSignal);
Analysis.printPlot (antishift, t, 'antishift');

