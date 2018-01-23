function [ Normalized_Con ] = BRIRConvolver( Impulse_Response, Anechoic_Signal)
%[ Normalized_Con ] = BRIRConvolver( Impulse_wav, Anechoic_Signal_wav)
%
%BRIRConvolver takes a binaural room inpulse response and convolves it with
%a stereo anechoic recording.
%
%   'Impulse_Response' must be a binaural signal and the Anechoic_Signal
%   must be two channel as well. The two inputs MUST have the same sample
%   rate.




conL = conv(Impulse_Response(:,1),Anechoic_Signal(:,1)); %Convolve the left channel IR and Signal
conR = conv(Impulse_Response(:,2),Anechoic_Signal(:,2)); %Convolve the right channel IR and Signal
con_Total = [conL,conR];  %Recombine convolved left and right signal

Normalized_Con = con_Total/max(max(abs(con_Total))); %Normalize the convolved signal to prevent clipping

end

