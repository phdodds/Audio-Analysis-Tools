function [ Center_Time ] = getCenterTime( Audio_Data, f_sampl )
%[ Center_Time ] = getCenterTime( Audio_Data, f_sampl )
%
%getCenterTime calculates the center time of an impulse response in
%seconds.
%
%
%   getCenterTime takes in Audio_Data and a sampling frequency and computes
%   the center time by identifying the last sample for which the sum of the
%   energy before that point is less than the sum of the energy after that
%   point.

Energy = Audio_Data.^2; %convert pressure to Energy
Time_Length = length(Energy); %find length of file in samples
Energy_Sum = 0;
Addition_Vct = zeros(1,Time_Length);

%% CALCULATE TOTAL ENERGY IN THE WAVE
for idx = 1:Time_Length
    
    Energy_Sum = Energy_Sum+Energy(idx);
    Addition_Vct(idx) = Energy_Sum;
    
end

%% FIND THE HALF-ENERGY AMOUNT
Middle_Energy = Energy_Sum/2;

%% FIND THE POINT IN THE WAVE IN TIME EQUAL TO HALF ENERGY
for idx_mid = 1:Time_Length
    if Addition_Vct(idx_mid) >= Middle_Energy
        break
    else
        Center_Point = idx_mid;
    end
end

%% COMPUTER CENTER TIME IN SECONDS
Center_Time = Center_Point/f_sampl;

%%  VALIDATE THE RESULTS
Before = sum(Energy(1:Center_Point));
After = sum(Energy((Center_Point+1):Time_Length));

Test = Before/After; %Test should be very close to 1;

end
