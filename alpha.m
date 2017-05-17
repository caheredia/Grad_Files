clear, clc
TC = (300:1:1000); %generates temperature range in Celcius
T = TC + 273.15; %generates temperature range in Kelvin

%Absorption intrinsic carrier concentration
for m = 1:numel(T, 1, :)%Steps through all the temperature values
ni(m) = 9.38*10^(19)*(T(m)/300)^2*exp(-6884/T(m));
end 

%P. Van Absorption intrinsic carrier concentration
for m = 1:numel(T, 1, :)%Steps through all the temperature values
vni(m) = 3.88*10^(16)*(T(m))^(3/2)*exp(-7000/T(m));
end 

figure(1)
plot(TC,ni,TC,vni)
set(gca, 'yscale', 'log')
title('N_i of Si')
ylabel('Intrinsic Density (cm^{-3})')
xlabel('Temperature (^o C)')
legend('M.A. Green','Vandenabeele');

