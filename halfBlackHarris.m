function [ WindowedData ] = halfBlackHarris(AudioData, f_sampl,PlateauLen )

%[ HalfWindow ] = halfBlackHarris(AudioData,f_sampl, PlateauLen )
%
%'halfBlackHarris' returns a right half Blackman Harris window. The user
%specifies the time signal 'AudioData' that the window will be applied to
%(for sizing) and specifies the length of the plateau to be added as a 
%percentage of the window (eg. 10 = length of 10% of window);

[~, columns] = size(AudioData);

for FileIdx = 1:columns
    %% CALCULATE INDEX POINT OF BEGINNING AND END OF IMPULSE
    time_length = length(AudioData);
    last_zero_idx = 0;
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

    HilbData=hilbert(AudioData);
    Envelope=abs(HilbData);
    NoiseFloor = max(Envelope)/100000;
        
    for idx = last_zero_idx+1:time_length
        if Envelope(idx) <= NoiseFloor
            break;
        else
            NoiseIdx = idx;
        end
    end
    
    if NoiseIdx > 0.33*time_length
        %If NoiseIdx cannot be caught easily, set idx pos to 500 ms after
        %start of impulse
        NoiseIdx = last_zero_idx+(500*(f_sampl/1000));
    end


    %% ADD FUNCTIONALITY FOR DATA and STARTPOINT
    len = 2*NoiseIdx-last_zero_idx+200; %determine length of full window

    PlatLen = 0.01*PlateauLen; %make plateau length a percentage

    WinLen = floor(len-len*PlatLen); %create the length of the window function

    Window = blackmanharris(WinLen); %create window function

    HalfWindow = Window(round(WinLen/2):WinLen); % take the right half of window

    Plateau = ones(floor(PlatLen*length(HalfWindow))-1, 1); %add the plateau to the beginning

    DropPoint = 0;

    HalfWindow = [DropPoint; Plateau; HalfWindow]; 

    WindowStart = last_zero_idx-200;

    WindowedData(:,FileIdx) = AudioData(WindowStart:WindowStart+length(HalfWindow)-1,FileIdx).*HalfWindow;
end

