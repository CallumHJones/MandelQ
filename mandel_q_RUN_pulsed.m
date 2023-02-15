%% mandel_q_RUN_pulsed.m
%
% Runs the function mandel_q_func.m to calculate the Mandel Q parameter 
% 'Q' with standard deviation 'stdev_Q' at integration times 'delt_t'
% Input data as column arrays of timestamp values in picoseconds
% 'your_data_channel_1' and 'your_data_channel_2'
% Integration times are multiples of the pulse repetition period
%

%% Input parameters
% Mandel Q params
J = 10;					% Number of Q(delt_t) points
t_rep = 1e5;			% Pulse repetition period (in ps)
delt_t = zeros(1,J);    % Integration time array (in ps)
for j = 1:J
    delt_t(j) = j * t_rep;
end

Kmax = 1e7;				% Max number of integration time intervals used to 
						%   calculate each Q(delt_t) value
Mmax = 10;				% Max number of repeats of Q(delt_t) to calculate 
						%   mean value and error bars

% input timestamp data arrays (in ps)
C1 = your_data_channel_1;
C2 = your_data_channel_2;

% total measurment time (in ps)
T = max(max([C1' C2']));

%% Run function mandel_q_func.m
[delt_t, Q, stdev_Q] = mandel_q_func(T,delt_t,J,Kmax,Mmax,C1,C2);

%% Plotting
figure;
errorbar(delt_t*1e-3,Q,stdev_Q,'k.')		% delt_t rescaled to ns
set(gca,'xscale','log');
xlabel('Integration Time, T / ns');
ylabel('Mandel Parameter Q(T)');
yline(0,'k--');