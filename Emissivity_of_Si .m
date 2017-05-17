
clear, clc
T = (300:1:800); %generates temperature range 
ece = 0.88; %energy coupling efficiency
P = 1.1;% incident power
bc = 5.67*10^-12; %Stefan-Boltzmann constant 
T0 = 300; % Room temp
R = 0.3204; % Assumed Reflectivity 
lambda = 1.55;

%Absorption coefficient 
alpha = 4.15*10^(-5)*lambda^(1.51)*T.^(2.95)*exp(-7000/T);

a = T.^(4);
b = T0^4;
c = a - b ;
d = a/c;

em = (1-R)./(2*bc*(a-b));

divc = T0./(T-T0);