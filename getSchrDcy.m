function [ SchrDcy_Curve, SchrInt ] = getSchrDcy( ETF_Vector, int_limit )
%[ SchrDcy_Curve, SchrInt ] = getSchrDcy( ETF_Vector )
%
%getSchrDcy takes in an ETF_Vector (non-logrithmic ETF calculation) and
%returns the Schroeder Integration vector and the Schroeder Decay Curve
%Vector.
%   'ETF_Vector' is the non-logarithmic vector of ETF values. The
%   'int_limit' defines an upper limit of integration as a percentage of
%   the total length of the wave. Eg. an int_limit of 0.90 would have the
%   curve calculated for 90% of the ETF vector.

ETF_Len = length(ETF_Vector);          %Define length variable
temp=0;                                %Define temporary variable
buildUp = zeros(1,ETF_Len);            %Initialize buildUp vector

if nargin < 2
    dataCut = ETF_Len;
else
    dataCut= floor(ETF_Len*int_limit);
end


for idx_time = 1:dataCut               %Cycle through each data point in the ETF_Vector
    
    temp = temp+ETF_Vector(idx_time);  %temp
    
    buildUp(idx_time)= temp;
    
    
end

buildUp = buildUp/temp;

SchrInt = 1-buildUp;

SchrDcy_Curve = 10*log10(SchrInt);

end

