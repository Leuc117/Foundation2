function [endurance] = endurance(eAvail, dragAtMaxV, maxV)
%calculates endurance

%eAvail             energy available from battery
%dragAtMaxV         drag at maximum velocity
%maxV               maximum velocity

endurance = ((eAvail * 0.8) / (dragAtMaxV * maxV));
end