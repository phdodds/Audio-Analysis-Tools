function [ EstimatedVolume ] = estimateVolume( AudioData, f_sampl, RT )
%[ EstimatedVolume ] = estimateVolume( AudioData, f_sampl, RT )
%
%estimatedVolume calculated the estimated volume (in cubic meters) of an 
%enclosure from the impulse response of a room. If filtering the impulse
%response, volume estimation is most accurate above 500 Hz.
%
%   estimateVolume takes in an impulse response 'AudioData', sampling
%   frequency 'f_sampl', and the T60 from the getRT function and returns
%   the estimated volume in cubic meters.


%% CALCULATE INDEX POINT OF BEGINNING OF IMPULSE
time_length = length(AudioData);
ptsIn1ms = floor(f_sampl/1000);
NoiseFloor = 0.1*max(AudioData);
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



soundSpeed = 343; %speed of sound

S2RDistance = last_zero_idx/f_sampl*soundSpeed;%S2R distance (m)

%% CALCULATE DIRECT SOUND ENERGY
Energy = AudioData.^2;


DirSound = mean(Energy(last_zero_idx-ptsIn1ms:last_zero_idx+(1.5*ptsIn1ms),1));
ReverbSound = mean(Energy(last_zero_idx+(1.5*ptsIn1ms)+1:time_length,1));

EstimatedVolume = (DirSound/ReverbSound)*((4*pi*S2RDistance^2*soundSpeed*RT)...
    /6*log(10))*exp((-S2RDistance*6*log(10))/(soundSpeed*RT));

end

