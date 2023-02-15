%% mandel_q_RUN_CW.m
%
% Runs the function mandel_q_func.m to calculate the Mandel Q parameter 
% 'Q' with standard deviation 'stdev_Q' at integration times 'delt_t'
% Input data as column arrays of timestamp values in picoseconds
% 'your_data_channel_1' and 'your_data_channel_2'
%

%% Input parameters
% Mandel Q params
J = 21;					% Number of Q(delt_t) points
t_min = 1e4;			% Min integration time (in ps)
t_max = 1e8;			% Max integration time (in ps)
delt_t = logspace(log10(t_min),log10(t_max),J);
						% Array of integration times (1xJ)

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