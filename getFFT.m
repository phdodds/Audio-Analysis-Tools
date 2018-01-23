function [ Audio_Freq_Range, Energy, Audio_FFT] = getFFT( Audio_Data, f_sampl, Plot_Switch, Type, Shift)
%[ Audio_Freq_Range, Audio_Power ] = getFFT( Audio_Data, f_sampl, Plot_Switch, Type, Shift)
%
%getFFT calculates the Fast Fourier Transform of an audio file and returns
%the frequency ranges and the power per frequency. It also gives the user
%the ability to plot the FFT on a periodogram. 
%
%   The getFFT function can take in any audio data (from an audioread
%   function) as the 'Audio_Data'. 'f_sampl' is the sampling frequency of
%   the data. The 'Plot_Switch' is a STRING of either 'Y' or 'N'.These must be input as strings. 
%   If 'Y' is typed, getFFT will plot the FFT on a periodogram. If 'N' is 
%   typed, getFFT will not plot the FFT. The optional parameter 'Shift"
%   allows for the periodogram to be centered around the zero frequency
%   component.

%% CALCULATE FFT

Audio_TransLen = length(Audio_Data);  % Transform length

Audio_FFT = fft(Audio_Data, Audio_TransLen)/Audio_TransLen; % DFT

Audio_Freq_Range = (0:Audio_TransLen-1)*(f_sampl/Audio_TransLen); % Frequency Range

Audio_Amplitude = abs(Audio_FFT);

Audio_Power = Audio_FFT.*conj(Audio_FFT)/Audio_TransLen; % Power of the DFT

Shifted_Range = fftshift(Audio_Freq_Range);


%% PLOT FFT

if Plot_Switch == 'Y'
Switch = 1;
else
Switch = 0;
end

Energy = Audio_Amplitude;

%% PLOT SWITCH
if  Switch > 0
    
    
    if nargin > 3 %TYPE OF PLOT SWITCH
        
    Type1 = strcmpi(Type,'Amplitude');
    Type2 = strcmpi(Type,'Power');
    if Type1 == 1
    Energy = Energy;
    elseif Type2 == 1
        Energy = Audio_Power;
    else Type2 == 0
        error('Type input must be either ''Amplitude'' or ''Power''.');
    end
    
  
    end 
    
    plot(Audio_Freq_Range, Energy);
    xlim([-inf (f_sampl/2)])
    xlabel('Frequency (Hz)')
    ylabel('Power')
    title('{\bf Periodogram of Impulse Response}')
  
end


if nargin > 4
Shifter = strcmpi(Shift,'shift');


if Shifter > 0
    plot(Shifted_Range,Audio_Amplitude);
    xlabel('Frequency (Hz)')
    ylabel('Power')
    title('{\bf Periodogram of Impulse Response}')
end
end
end

