function [dynThrust] = thrustFinder(RPM, pitch, diam)
velocity = 1:30;
dynThrust = 1:30;
for i = 1 : 30
    dynThrust(i) = 1.134 * ((pi * diam^2)/4) * ...
        ((RPM * pitch * (1/60))^2 - (RPM * pitch * ...
        (1/60)) * velocity(i)) * (diam/(3.29546 * pitch))^1.5;
end

end
