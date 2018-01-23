function [ C50, C80, D50, TS] = getClarity(Audio_Data, f_sampl)
%[ C50, C80, D50, TS ] = getClarity(Energy, f_sampl)
%
%getClarity takes the Energy, time vector, and sample rate of the sound file for its inputs and
%outputs the C_50, C_80, and D_50.
%   'Audio_Data' of a sound file.'f_sampl' is the sample rate of the sound 
%   file (44.1kHz, etc.)  


%% CALCULATE INDEX POINT OF BEGINNING OF IMPULSE
time_length = length(Audio_Data);
last_zero_idx = 0;
NoiseFloor = 0.1*max(Audio_Data);
for zero_idx = 1:length(AudioData)            
    if AudioData(zero_idx) >= NoiseFloor %<--This number may need to change 
                                            %   depending on Noise Floor
        break;
    else
        last_zero_idx = zero_idx;
    end
end
if last_zero_idx < 1
    last_zero_idx = 1;
end

%% TOTAL ENERGY
Energy = Audio_Data.^2;
total_Energy = sum(Energy(:,1));

%% D50 NUMERATOR
fifty_ms = last_zero_idx+(f_sampl*0.05); %idx point 50ms after impulse
D50_numerator = sum(Energy(last_zero_idx:fifty_ms));

%% D50
D50 = D50_numerator/total_Energy;

%% D80 NUMERATOR
eighty_ms = last_zero_idx+(f_sampl*0.08); %idx point 80ms after impulse
D80_numerator = sum(Energy(last_zero_idx:eighty_ms));

%% D80

D80 = D80_numerator/total_Energy;

%% CENTER TIME
center_num = 0;
for centerTime = last_zero_idx:time_length
    center_num = center_num+(((centerTime-last_zero_idx+1)/f_sampl)*Energy(centerTime,1));
end

TS = center_num/total_Energy;


%% CLARITY for 50ms
C50 = 10*log10(D50/(1-D50));


%% CLARITY for 80ms
C80 = 10*log10(D80/(1-D80));
end




