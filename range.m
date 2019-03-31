function [range] = range(eStar, massBatt, massTot, liftAtMaxV, dragAtMaxV)
%calculates range

%eStar          batterySpecific energy
%massBatt       mass of the battery
%massTot        total mass of the drone + battery
%liftAtMaxV     lift a maximum velocity
%dragAtMaxV     drag at maximum velocity

range = eStar * (massBatt / massTot) * ...
    (1 / 9.8) * (liftAtMaxV / dragAtMaxV) * 0.8;
end