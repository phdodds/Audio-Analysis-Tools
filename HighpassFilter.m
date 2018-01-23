function [ FilteredAudio ] = HighpassFilter( AudioData, f_sampl, Cutoff_Freq, User_Order)
%[ FilteredAudio ] = HighpassFilter( AudioData, f_sampl, Cutoff_Freq, User_Order)
%
%HighpassFilter creates a highpass filter that filters all data below the
%cutoff frequency.
%   The user inputs a vector of audio data, the sampling rate (f_sampl),
%   the cutoff frequency in Hz, and, optionally, a filter order. If no
%   order is input the order will be assigned automatically based on the
%   cutoff frequency.

%% FILTER ORDER
if nargin >3
    Order = User_Order;
elseif Cutoff_Freq <= 249
    Order = 2;
elseif Cutoff_Freq >= 250 && Cutoff_Freq <= 999
    Order = 3;
elseif Cutoff_Freq >= 1000
    Order = 4;
end

Window = Cutoff_Freq/f_sampl/2;
[B,A] = butter(Order, Window, 'high');

FilteredAudio = filter(B,A,AudioData);


end

