 function [Filtered_AudioC, Filtered_AudioL, Filtered_AudioU] =... 
     ButterFilter( Audio_Data, f_sampl, Center_Freq, Type_Switch, User_Order )
%[Filtered_Audio_C, Filtered_AudioL, Filtered_Audiou] =... 
%     ButterFilter( Audio_Data, f_sampl, Center_Freq, Type_Switch, User_Order )
%   
%   Creates an Octave or Third Octave Bandpass Butterworth filter for a 
%   given frequency.
%
%   'ButterFilter' takes in a sound file 'Audio_Data' with its respective
%   sampling frequency and creates an octave or third octave bandpass 
%   filter around the selected center frequency. The 'Type_Switch' is a
%   a string of 'Octave' or 'Third'. The function returns the filter 
%   coefficients 'B' and 'A' as well as the filtered sound file.

 %% TYPE SWITCH

 Octave = strcmpi(Type_Switch, 'Octave');
 Third = strcmpi(Type_Switch, 'Third'); 
    
  if Octave == 1
    Switch = 1;
  elseif Third == 1
    Switch = 2;
  end
    
    if Switch == 2 

        fd_Third = (2^(1/6));
        Lower_Upper = Center_Freq.*fd_Third;
        Lower_Lower = Center_Freq./fd_Third;
        Center_Center = Lower_Upper.*fd_Third;
        Center_Upper = Center_Center.*fd_Third;
        Upper_Center = Center_Upper.*fd_Third;
        Upper_Upper = Upper_Center.*fd_Third;
       
        Nyquist = f_sampl/2;
        Window_Lower = [Lower_Lower/Nyquist Lower_Upper/Nyquist];
        Window_Center = [Lower_Upper/Nyquist Center_Upper/Nyquist];
        Window_Upper = [Center_Upper/Nyquist Upper_Upper/Nyquist];
    end
    
    if Switch == 1
        fd_Oct = (2^0.5);
        f_Upper = Center_Freq .* fd_Oct;
        f_Lower = Center_Freq ./ fd_Oct;
        Nyquist = f_sampl/2;
        Window = [f_Lower/Nyquist f_Upper/Nyquist];

    end
    
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
    
        
%% FILTER
if Switch == 1;
[B,A]=butter(Order, Window);
Filtered_AudioC = filter(B,A,Audio_Data);
Filtered_AudioL = 0;
Filtered_AudioU = 0;

end

if Switch == 2;
  [BL,AL]=butter(Order, Window_Lower);
  Filtered_AudioL = filter(BL,AL,Audio_Data);

  [BC,AC]=butter(Order, Window_Center);
  Filtered_AudioC = filter(BC,AC,Audio_Data);
  
    [BU,AU]=butter(Order, Window_Upper);
  Filtered_AudioU = filter(BU,AU,Audio_Data);




end


end

