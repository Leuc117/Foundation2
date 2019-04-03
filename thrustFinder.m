function [dynThrust] = thrustFinder(RPM, pitch, diam, velocity)
dynThrust = 1.134 * ((pi * diam^2)/4) * ((RPM * pitch * (1/60))^2 - (RPM * pitch * (1/60) * velocity)) * (diam / (3.29546 * pitch))^1.5;

end
