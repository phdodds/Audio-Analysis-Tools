function [ FilteredAudio ] = BandpassFilter( AudioData, f_sampl, LowFreq, HighFreq, User_Order)
%[ FilteredAudio ] = BandpassFilter( AudioData, f_sampl, LowFreq, HighFreq, Order)
%
%BandpassFilter creates a bandpass filter that filters all data between the
%cutoff frequencies.
%   The user inputs a vector of audio data, the sampling rate (f_sampl),
%   the cutoff frequency in Hz, and a filter order.


    %% FILTER ORDER
    if nargin >4
        Order = User_Order;
    elseif Center_Freq <= 249
        Order = 2;
    elseif Center_Freq >= 250 && Center_Freq <= 999
        Order = 3;
    elseif Center_Freq >= 1000
        Order = 4;
    end

[B,A] = butter(Order, [LowFreq HighFreq]/f_sampl/2, 'bandpass');

FilteredAudio = filter(B,A,AudioData);


end

