function [Band_Vct, Mag_Vct, Mag_Calc_Vct ] = OctFilter(Audio_Freq_Range,... 
          Audio_Amplitude, Center_Freq, f_sampl, Plot_Switch )
%UNTITLED Summary of this function goes here
%
%
%   Detailed explanation goes here

Freq_Spectrum = length(Audio_Freq_Range);

%% CACULATE THE FREQUENCY LIMITS OF THE CHOSEN BAND
fcentre = Center_Freq;
fd = (2^0.5);
f_Upper = fcentre .* fd;
f_Lower = fcentre ./ fd;
Band_idx = 1;
Freq_Spectrum = length(Audio_Freq_Range);
Nyquist = f_sampl/2;

Mag_idx = 1;

%% CALCULATE THE FREQUENCIES IN THE BAND 
for freq_idx = 1:Freq_Spectrum
    
    if Audio_Freq_Range(freq_idx) >= f_Lower && Audio_Freq_Range(freq_idx) <= f_Upper
        
         Band_Vct(Band_idx) = Audio_Freq_Range(freq_idx);
         Band_idx = Band_idx+1;
         
         %CALCULATE THE INDEX VALUE FOR EACH OF THE FREQUENCIES IN THE BAND
         %and place them in vector Mag_Calc_Vct
         Mag_Calc_Vct(Mag_idx) = freq_idx;
         Mag_idx = Mag_idx+1;
    end
    
    if Audio_Freq_Range(freq_idx) >=(f_Lower+Nyquist) && Audio_Freq_Range(freq_idx)<=(f_Upper+Nyquist)
        Band_Vct(Band_idx) = Audio_Freq_Range(freq_idx);
         Band_idx = Band_idx+1;
         
         %CALCULATE THE INDEX VALUE FOR EACH OF THE FREQUENCIES IN THE BAND
         %and place them in vector Mag_Calc_Vct
         Mag_Calc_Vct(Mag_idx) = freq_idx;
         Mag_idx = Mag_idx+1;
    end
end

%% CALCULATE THE MAGNITUDE FOR EACH OF THE FREQUENCIES CALCULATED ABOVE
Mag_Vct = zeros(length(Mag_Calc_Vct),2);

for Mag_Calc = 1:length(Mag_Vct)
    
    Mag_Vct(Mag_Calc,1) = Audio_Amplitude(Mag_idx,1);
    Mag_Vct(Mag_Calc,2) = Audio_Amplitude(Mag_idx,2);
    Mag_idx = Mag_idx+1;
end

Mag_Vct = Mag_Vct';

%% PLOT SWITCH
if nargin > 4
    
    if Plot_Switch == 'Y'
    Switch = 1;
    else
    Switch = 0;
    end
    
    if Switch > 0 
        
        plot(Band_Vct,Mag_Vct)
        xlabel('Frequency (Hz)')
        ylabel('Power')
        title(['Frequency response of the ', num2str(Center_Freq),' Hz Octave Band'])
    
end
end

