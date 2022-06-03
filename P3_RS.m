%%%%%
%% Practical 3 Part 1: Implementing FIR filter
%% Rahul Seth - 17302557


% loading in original speech file
[x, Fs] = audioread('speech_26.wav');


%play
play = audioplayer(x, Fs); 
playblocking(play) 

info = audioinfo('speech_26.wav');
t = 0:seconds(1/Fs):seconds(info.Duration);
t = t(1:end-1);

%plotting orignal signal
figure();
plot(t,x)
title('Orignal Signal')
xlabel('Time')
ylabel('x(t)')

%plot noise tone
nfft = 2^10;
X = fft(x, nfft);
fstep = Fs/nfft;
fvec = fstep*(0: nfft/2-1);
figure();
plot(fvec, 2*abs(X(1:nfft/2)))
title('Single-Sided Amplitude Spectrum of x(t) (orignal signal)')
xlabel('Frequency (Hz)')
ylabel('|X(f)|')

%max freq
[max_val, max_freq] = max(2*abs(X(1:nfft/2)));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%using filter designed hp_fir1
%hp_fir1 = full precision fir filter
%hp_fir2 = quantised fir filter

y = filter(hp_fir1,x);
%y = filter(hp_fir2,x);

%play again - fileterd speech
play2 = audioplayer(y, Fs);
playblocking(play2);

%save new audio
audiowrite('filetred_speech26.wav', y, Fs)
%audiowrite('quant_filetred_speech26.wav', y, Fs)

%%using filter designed hp_fir1
%plot again
nfft = 2^10;
X = fft(y, nfft);
fstep = Fs/nfft;
fvec = fstep*(0: nfft/2-1);
figure();
plot(fvec, 2*abs(X(1:nfft/2)))
%plot filtered file
title('Single-Sided Amplitude Spectrum of y(t) Filtered')
xlabel('Frequency (Hz)')
ylabel('|Y(f)|')

%get cost of filter made
cost_fir1 = cost(hp_fir1);
cost_fir2 = cost(hp_fir2);
%%%%%%%%%%%%%%%%%%%%%%%%%

%plot filtered signal against time
t = 0:seconds(1/Fs):seconds(info.Duration);
t = t(1:end-1);
figure();
plot(t,y)
title('Filtered Audio')
xlabel('Time')
ylabel('y(t)')

%plotting filtered signal
figure();
plot(t,y)
title('Filtered Signal')
xlabel('Time')
ylabel('x(t)')

%%%%%%%%%%%%%%%%%%%%%%%%%%%
%comapre input and filtered
plot(t,x)
hold on
plot(t,y)
xlabel('Time')
ylabel('Amplitude')
legend('Input Data','Filtered Data')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%EOF

 