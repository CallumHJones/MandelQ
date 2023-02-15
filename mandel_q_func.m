function [delt_t, Q, stdev_Q] = mandel_q_func(T,delt_t,J,Kmax,Mmax,C1,C2)
% Calculates Mandel Q parameter 'Q' with standard deviation 'stdev_Q' at
%   integration times 'delt_t'
% Multiple runs for each Q(delt_t) point to calculate error bars

tic

% T: acquisition time / ps
% J: number of Q(delt_t) points
% delt_t: integration time array / ps

M = round(T./(delt_t));
M(M>=Mmax) = Mmax;			% Mmax: max number of Q values averaged
K = round(T./(delt_t.*M));
K(K>=Kmax) = Kmax;          % Kmax: max number of time bins averaged per integration time

% C1: channel 1 timestamps variable / ps
% C2: channel 2 timestamps variable / ps

t = sort([C1' C2']);        % ascending list of all timestamps

N = zeros(J,max(K),max(M)); % initialise (J x Kmax x Mmax) array for number of photons
edges = zeros(J,max(K)+1);  % initialise array for time bin edges

for j = 1:J                 % loop through each integration time
    for m = 1:M             % repeat M times at a given integration time
        edges(j,1:K(j)+1) = [0:delt_t(j):K(j)*delt_t(j)] + (m-1)*K(j)*delt_t(j);    % define time bin edges, spaced by integration time delt_t(j)
        N(j,1:K(j),m) = histcounts(t,edges(j,1:K(j)+1));                            % count the number of photons in each time bin using histcounts()
        if K(j)<Kmax
            N(j,K(j)+1:Kmax,m) = NaN;       % all unused elements of N are defined NaN so they can be removed later
        end
    end
end

mean_N = mean(N,2,'omitnan');                           % average photon number over all time bins with the same integration time
mean_Nsq = mean(N.^2,2,'omitnan');                      % average photon number squared
deltsq_N = (Kmax/(Kmax-1))*(mean_Nsq - mean_N.^2);      % photon number variance; result is a J x M array (M repeats for each integration time)

Qm = deltsq_N./mean_N - 1;                              % calculate Q parameter; result is a J x M array

Q = zeros(J,1);
stdev_Q = zeros(J,1);

for j = 1:J
    Q(j,:) = mean(Qm(j,:,1:M(j)),3);                    % calculate mean and standard deviation of the Q parameter
    stdev_Q(j,:) = std(Qm(j,:,1:M(j)),0,3);             % using M repeat values; result is a J x 1 array
end

% Final output values: Q, stdev_Q

toc
end