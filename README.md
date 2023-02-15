# MandelQ
Matlab scripts for calculating the time-dependent Mandel Q parameter, used in the manuscript "Time-dependent Mandel Q parameter analysis for a hexagonal boron nitride single photon source."

##################################

Written using MATLAB R2019a

February 2023

Callum Jones, University of Exeter

##################################

Time-dependent Mandel Q parameter is defined:
Q(T) = (var(N) / mean(N)) - 1,
where N is the photon number during an integration time T.

mandel_q_RUN_CW.m runs mandel_q_func.m to calculate and plot Q(T) for integration times T evenly distributed on a log scale for CW timestamp data.

mandel_q_RUN_pulsed.m runs mandel_q_func.m to calculate and plot Q(T) for integration times T multiples of the pulse repetition period for pulsed timestamp data.

Input data is timestamp data (photon detection times) from two detectors, so that data from a Hanbury Brown and Twiss setup can be used directly. Enter timestamp data as two (Ndata x 1) column arrays of timestamp values in picoseconds. Our raw data was timestamp data from an IDQ Time Controller ID900.
