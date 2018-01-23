function [ ETF, ETF_Vector, ETFRate, Block_Amount] = getETF(Audio_Data, f_sampl, User_Resolution)
%[ ETF, ETF_Vector, ETFRate, Block_Amount] = getETF(Audio_Data, f_sampl, User_Resolution)
%
%getETF takes in Audio_Data, a sampling rate, and a user defined resolution and
%outputs the ETF vector, a logarithmic energy time function (ETF), the ETF
%adujusted sampling rate, and the amount of blocks for the data.
% 'Block_Quantity' is the amount of blocks for your data in MS.
%It can be adjusted to give more or less blocks by inputing a resolution as
%the third argument. The 'User_Resolution' is the milliseconds per block.
%'ETFRate' is the number of blocks per second.

%Mathematical definition ETF=10*log10(energy./max(energy);

%% DETERMINES USER SPECFIED RESOLUTION OR DEFAULT RESOLUTION
if nargin < 3
    resolution = 1;
else
    resolution = User_Resolution;
end

%% ESTALBISHES ENERGY AND LENGTHS
energy = Audio_Data.^2;                                                %Energy is the audio data squared.
data_len = length(energy);                                       %Find length of energy signal
data_lenMS = length(energy)/(f_sampl/1000);                      %puts the length of the data in milliseconds


%% AMOUNT OF BLOCKS AND SAMPLES PER BLOCK AND TIME PER BLOCK
Block_Amount = floor(data_lenMS/resolution);                    %user set amount of blocks 
Points_perBlock = floor(data_len/Block_Amount);                 %Samples per block
ETFRate = f_sampl/Points_perBlock;



%% CALCULATE THE ETF
ETF_Vector = zeros(1,Block_Amount);                            %Total energy summed per block


for idx_Block = 1:Block_Amount                                 %Cycle through each block
   
    
    for idx_Energy = 1:Points_perBlock                           %cycle through points in each block
            ETF_Vector(idx_Block)= ETF_Vector(idx_Block)+energy((idx_Block-1)*Points_perBlock+idx_Energy);    %Sums energy of each block
       
    end
    ETF_Vector = ETF_Vector;
                             
end

%Normalze each block of energy by the maximum block energy log plot the Energy Decay Curve.
ETF = 10 * log10(ETF_Vector/max(ETF_Vector));
                                                     
                                        
                                             

 

end

