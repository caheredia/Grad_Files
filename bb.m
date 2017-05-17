 h = 6.6261*10^-34; % Planck's constant J s
c = 2.9979*10^8; % speed of light m/s
k = 1.3807*10^-23; % Boltzmann's constant J/K
lambda = 1e-9:10e-9:3000e-9;
T1 = 4500;
T2 = 6000;
T3 = 7500;
A1=(h.*c)./(k.*T1.*lambda);
A2=(h.*c)./(k.*T2.*lambda);
A3=(h.*c)./(k.*T3.*lambda);

%energy density function:
B=(8.*pi.*h.*c)*(1e-6)./lambda.^5;
BB1=B.*(1./(exp(A1)-1));
BB2=B.*(1./(exp(A2)-1));
BB3=B.*(1./(exp(A3)-1));

figure(1),clf
plot(lambda,BB1,lambda,BB2,lambda,BB3)