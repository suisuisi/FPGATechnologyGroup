function doFFTplot(fs,signals,signalLabels,decFactor,figNum,w_type)
%  Plot a scaled fft
%  'fs' is the sampling frequency in Hertz
%  'signals' is a matrix comprising all the signal vectors whose FFTs are to be
%  calculated and plotted.  
%  'signalLabels' contains strings that correspond to each signal vector in the
%  'signals' matrix.  Each string must be the same length, so padding with
%  spaces may be necessary before calling the function.
%  'decFactor' is the decimation factor and is an OPTIONAL ARGUMENT
%  'figNum' is the number you want to attach to the figure and is an OPTIONAL ARGUMENT
%  Do not pass in a value for figNum if you want to overlay plots
%  Example: If 3 signals, x; y and z are to be
%  plotted and the sampling frequency is 100MHz, then this function will be
%  called as follows:
%  doFFTplot(100e6,[x,y,z],['labelX';'labelY';labelZ'])
%  The components that make up 'signals' must be vectors
%  Author: G.Stephen
%  Date:30/03/2006
%  FFT plotting code adapted from:
%  http://www.mathworks.com/support/tech-notes/1700/1702.html
%-------------------------------------------------------------
% Modification to incorporate window selection.
% Author: L. Crockett
% Date:   20/07/2007
% A further parameter is added to the function to allow the user
% to specify a windowing function for FFT plotting. Choices are:
% HANN
% HAMMING
% BLACKMAN
% and the default is RECTANGULAR (i.e. no explicit window).
% 'w_type' is the window type and is an OPTIONAL ARGUMENT.
%-------------------------------------------------------------
% Modification to 20*log10(abs(fft(x)))
% Author: L. Crockett
% Date:   7/7/08
%-------------------------------------------------------------

% check if a decimation factor has been supplied
if nargin < 4 
   decFactor = 1; 
end 

% check if a figure number has been supplied
if nargin > 4 
   figure(figNum); 
end 

% assign default window if none supplied
if nargin < 6
    w_type = 'rect';
end    
    

numSamples = length(signals(:,1));

%the number of FFTs to be plotted
numVectors = length(signals(1,:));

% Use next highest power of 2 greater than or equal to 
% length of signal to calculate FFT. 
N = 2^(nextpow2(length(signals(:,1))));

if strncmpi(w_type,'hann',4)
    w = hann(N)';
elseif strncmpi(w_type,'hamming',4)
    w = hamming(N)';
elseif strncmpi(w_type,'blackman',4)
    w = blackman(N)';
elseif strncmpi(w_type,'rect',4)
    w = ones(1,N);
else
    w = ones(1,N);                      
end



% Calculate the number of unique points 
numUniquePts = ceil((N+1)/2);

% This is an evenly spaced frequency vector with 
% NumUniquePts points. 
f = (0:numUniquePts-1)*fs/N; 

mag = zeros(numUniquePts,numVectors);

for i=1:numVectors
    
    % create zero padded array for this signal
    sig_vec(i,1:N) = zeros;
    sig_vec(i,1:length(signals(:,i))) = signals(:,i);
    
    % perform windowing on the zero padded signal
    sig_window = sig_vec(i,1:N) .* w;
    
    
    % Take fft, padding with zeros so that length(FFT) is equal to N
    FFTvec = fft(decFactor*sig_window,N);
    
    % FFT is symmetric, throw away second half 
    FFTvec = FFTvec(1:numUniquePts);
    
    % Take the magnitude of fft of x.
    mag(:,i)= abs(FFTvec);

    % Generate the plot and labels.
    plot(f,20*log10(mag)); 
    
    if(i==1)
        hold;
    end
    
end

legend(signalLabels,0);
xlabel('Frequency (Hz)'); 
ylabel('Magnitude (dB)'); 
grid;

