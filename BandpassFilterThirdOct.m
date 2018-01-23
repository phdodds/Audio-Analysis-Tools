function [ FilteredAudio ] = BandpassFilterThirdOct( AudioData, f_sampl, CenterFreq, User_Order)
%[ FilteredAudio ] = BandpassFilter( AudioData, f_sampl, LowFreq, HighFreq, Order)
%
%BandpassFilter creates a bandpass filter that filters all data between the
%cutoff frequencies.
%   The user inputs a vector of audio data, the sampling rate (f_sampl),
%   the cutoff frequency in Hz, and a filter order.

LowFreq = CenterFreq/2^(1/6);
HighFreq = CenterFreq*2^(1/6);

    %% FILTER ORDER
    if nargin >3
        Order = User_Order;
    elseif CenterFreq <= 249
        Order = 2;
    elseif CenterFreq >= 250 && CenterFreq <= 999
        Order = 3;
    elseif CenterFreq >= 1000
        Order = 4;
    end

[B,A] = butter(Order, [LowFreq HighFreq]/f_sampl/2, 'bandpass');

FilteredAudio = filter(B,A,AudioData);


end

