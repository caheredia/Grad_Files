clear, clc
h = 6.626e-34;% (*J/s*);
c = 2.9978e8;% (*m/s*);
k = 1.3807e-23;% (*J/K*);
T = 5723; % K 
bk = 5.670400e-8 %Boltzman coefficient 
Tair = 300; %K
s =6.8e-5; %assuming a solid angle of 6.8e-5 steradian for the source (the solar disk).
Trange = (300:1:1100);

filename = 'AM1.5.csv'; %this pulls NREL data into arrays. 
M = csvread(filename);
wave = M(:,1);
Ir = M(:,2);
lambda = wave*10^(-9); 


%Planck's Law  http://en.wikipedia.org/wiki/Planck%27s_law
E = h*c./(k*T*lambda'); %one temperature 
A = 2*h*c*c./(lambda').^5; %numerator 
B = exp(E)-1; %den

P = 10^(-9)*s*A./B;

%If we integrate the Solar Spectrum Density over all wavelengths we get
Pinc = trapz(wave,Ir);
%900 which is in accordance to the accepted value of 900W/m^2 
%http://pveducation.org/pvcdrom/appendicies/standard-solar-spectra

figure(1)
plot(wave, P, wave, Ir)
title('black body radiation and AM1.5, P = 900 W / m^2')
ylabel('Spectral radiance (W/ m^{-2} /nm^{-1})')
xlabel('Wavelength (nm)')
axis ([min(wave(:)) max(wave(:)) 0 1.8])


espectrum = 1240./flipud(wave); %defines the energy spectrum, E = 1240ev/nm
flipIr = flipud(Ir); % flips solar spectrum to match espectrum 

figure(2) %Plots P vs Eg
plot(espectrum, flipIr)
title('black body radiation and AM1.5, P = 900 W / m^2')
ylabel('Spectral radiance (W /m^{-2} /eV)')
xlabel('Energy (eV)')
axis ([min(espectrum(:)) max(espectrum(:)) 0 1.8])

%Need to define a function that integrates power over a given range,
%essentially from 280 nm (or 4.428 eV) to new value of band gap as
%described by Eg(T) = Eg(0) - AT^2/(B+T) where A is 4.37e-4eV/K and 635 K and
%Eg(0) = 1.155 eV


%Now, let's plot the moving band gap 
Eg0 = 1.155; AE = 4.73e-4; BE = 635;
EgT = Eg0 - AE.*Trange.^2./(BE+Trange);

figure(3) %Plots Eg vs T
plot(Trange, EgT)
title(['Moving band gap as a function of T, Eg_{min}=', num2str(min(EgT(:)))])
ylabel('Eg (eV)')
xlabel('T (K)')
axis ([min(Trange(:)) max(Trange(:)) .75 1.15])

%an algorithm to find closest value of wavelength in Ir spectrum and it's index 
newE = EgT(1100-299)%for 1100K, remember Trange starts at 300K
newlamda = 1240/newE % Gives newE in terms of nm
[d index] = min(abs(wave-newlamda))
closestValues = wave(index) % Finds the closest value in wave 

%Finds the integrated power from EgT
IntPower = trapz(wave(1:index),Ir(1:index))

%A for loop to generate power absorbed at different T 
for m = 1:length(Trange)%Steps through all the temperature values
newl = 1240/EgT(m); % Gives newE in terms of nm
[d index] = min(abs(wave-newl));
closestValues = wave(index); % Finds the closest value in wave 

%Finds the integrated power from EgT
PowerT(m) = trapz(wave(1:index),Ir(1:index));
end 

figure(4) %Plots PowerT vs T
plot(Trange, PowerT)
title('Solar Spectrum Power absorbable as a function of T')
ylabel('P (W/m^2)')
xlabel('T (K)')
axis ([min(Trange(:)) max(Trange(:)) 715 815])

%Now we'll plot the efficiencies against each other 
Ecarnot = 1-Tair./Trange;
Ebb = (100*Pinc - bk*Trange.^4)/(100*Pinc);
Ebbc = Ebb.*Ecarnot;
Esa = (100*PowerT - (.5)*bk*Trange.^4)/(100*PowerT);
Esac = Esa.*Ecarnot;

figure(5) %Plots Ebb and Esa vs T
plot(Trange, Esac, Trange, Ebbc)
title('Si Selective Absorber beats Blackbody')
ylabel( '\eta')
xlabel('T (K)')
axis ([min(Trange(:)) max(Trange(:)) 0 1])