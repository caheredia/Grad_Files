clear, clc
TC = (300:1:1000); %generates temperature range in Celcius
T = TC + 273.15; %generates temperature range in Kelvin
lambda = .8 %in microns
d = (2:1:2000); %generates depth in microns


TC1 = 300;
T1 = TC1 + 273.15;
I1 = exp(-4.15*10^(-5)*lambda^(1.51)*T1^(2.95)*exp(-7000/T1)*d*10^(-4));

TC2 = 500;
T2 = TC2 + 273.15;
I2 = exp(-4.15*10^(-5)*lambda^(1.51)*T2^(2.95)*exp(-7000/T2)*d*10^(-4));

TC3 = 800;
T3 = TC3 + 273.15;
I3 = exp(-4.15*10^(-5)*lambda^(1.51)*T3^(2.95)*exp(-7000/T3)*d*10^(-4));

figure(1)
plot(d,I1,d,I2,d,I3)
title('light Penetration depth of Si')
ylabel('normailized intensity ')
xlabel('Pentration depth \mum')
legend('300','500','800');
%set(gca, 'Yscale', 'log')
%axis ([min(TC(:)) max(TC(:)) 0.1 100])