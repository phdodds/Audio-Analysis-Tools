function [ RT_Metric ] = getRT( SchrDcy_Curve, Decay_Amount, ETFRate,  LSEPlot)
%[ RT_Metric ] = getRT( SchrDcy_Curve, Decay_Amount, ETFRate,  LSEPlot)
%
%getRT gets a Reverb time of a Schroeder Curve.
%   The EDT is calculated from the logarithmic Schroeder decay vector with
%   the limits -0.05 and -10. To calculate the EDT, the Decay_Amount should
%   be the string 'EDT'. he T_N is then calculated with the limits -5 to 
%   -N. To calculate the T_N, the Decay_Amount is equal to N.
% 

if nargin  < 4
     LSEPlot = 0;
else
     LSEPlot = 1;
end
 
if Decay_Amount == 'EDT'
    limit1_dB = -0.05;
    limit2_dB = -10;
else
    limit1_dB = -5;
    limit2_dB = -Decay_Amount-5;
end


[ idx1, idx2 ] = getLimits( SchrDcy_Curve, limit1_dB, limit2_dB );
[coef_b, coef_a] = LeastSqFit(SchrDcy_Curve(idx1:idx2),ETFRate, LSEPlot);


RT_Metric = -60/coef_b/ETFRate;

end

