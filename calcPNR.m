function [ PNR, SNR, peakFactor ] = calcPNR( TimeSignal, noiseLength)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

%% CALCULATE PEAK FACTOR

peak = max(TimeSignal);
rms = sqrt(mean(TimeSignal.^2));

peakFactor = peak/rms;

%% CALCULATE PEAK TO NOISE RATIO
if nargin <2
    noiseLen = 10000;
end
%% CALCULATE SIGNAL TO NOISE RATIO
len = length(TimeSignal);
Noise = mean(TimeSignal(len-noiseLength)); %find avg. noise at end of data
SignalPower = sum(abs(TimeSignal).*abs(TimeSignal))/len;
NoisePower = sum(abs(Noise).*abs(Noise))/len;
SNR = 10*(log10(SignalPower/NoisePower));

%% CALCULATE PEAK TO NOISE RATIO

Energy = TimeSignal.*TimeSignal;
energyPeak = max(Energy);

NoiseAvg = 0;
for idx_Noise_Block = 1:noiseLength   %cycle through the number of samples of the noise floor
    NoiseAvg = NoiseAvg + Energy(length(Energy)-noiseLength);   %Add the ETF of each value for each block.
end

energyNoise = NoiseAvg/noiseLength;

PNR = 10*log10(energyPeak/energyNoise);

end

