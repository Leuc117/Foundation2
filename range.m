function [range] = range(eStar, massBatt, massDrone, dragAtMaxV)
%calculates range

%eStar          batterySpecific energy
%massBatt       mass of the battery
%massTot        total mass of the drone + battery
%liftAtMaxV     lift a maximum velocity
%dragAtMaxV     drag at maximum velocity

range = (eStar * (massBatt / massDrone) * ...
    (1 / 9.8) * ((massDrone * 9.8) / dragAtMaxV) * 0.8) / 1000;
end