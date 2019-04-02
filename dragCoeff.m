function [dragCoeff1, dragCoeff2] = dragCoeff(avgChordWing, ...
    lengthWing, thickWing, avgChordVertTail,  ...
    thickVertTail, avgChordHorTail,  ...
    lengthHorTail, thickHorTail, lengthFuse, diamFuse)
%calculates drag coefficients 

%dragCoeff1         coefficient for drag that will be multiplied by v^2
%dragCoeff2         coefficient for drag that will be multiplied by 1/v^2

%largeChordxxx      chord at base of wing
%smallChordxxx      chord at tip of wing
%lengthxxx          distance from base to tip
%thickxxx           depth of wing
%lengthFuse         distance on fuselage from tip to tail
%diamFuse           width of fuselage sideways while looking down at drone

%% Zero lift drag
%Precalculated coefficients of friction
coeffFricWings = (0.455) / (4.556 ^ 2.58);
coeffFricFuse = (0.455) / (5.26 ^ 2.58);

%main wings
theoAreaWing = 2 * lengthWing * avgChordWing;
actAreaWing = theoAreaWing - (avgChordWing * diamFuse);
ffWing = 1 + 2 * (thickWing / avgChordWing) + 60 * ...
    ((thickWing / avgChordWing) ^ 4);
zeroLDragWing = (coeffFricWings * ffWing * actAreaWing) / theoAreaWing;

%horizontal tail
theoAreaHorTail = 2 * lengthHorTail * avgChordHorTail;
actAreaHorTail = theoAreaHorTail - (largeChordHorTail * diamFuse);
ffHorTail = 1 + 2 * (thickHorTail / avgChordHorTail) + 60 * ...
    ((thickHorTail / avgChordHorTail) ^ 4);
zeroLDragHorTail = (coeffFricWings * ffHorTail * ...
    actAreaHorTail) / theoAreaHorTail;

%vertical tail
ffVertTail = 1 + 2 * (thickVertTail / avgChordVertTail) + 60 * ...
    ((thickVertTail / avgChordVertTail) ^ 4);
zeroLDragVertTail = (coeffFricWings * ffVertTail);

%fuselage
theoAreaFuse = 2 * pi * (diamFuse / 2) * lengthFuse + ...
    2 * pi * ((diamFuse / 2) ^ 2);
actAreaFuse = theoAreaFuse - diamFuse * (largeChordWing + largeChordHorTail);
ffFuse = 1 + 1.5 * ((diamFuse / lengthFuse) ^ (3 / 2)) + 7 *...
    ((diamFuse / lengthFuse) ^ 3);
zeroLDragFuse = (coeffFricFuse * ffFuse * actAreaFuse) / theoAreaFuse;

ZLDragCoeff = zeroLDragWing + zeroLDragHorTail + zeroLDragVertTail +...
    zeroLDragFuse;

%% Induced Drag
aspectRatio = (lengthWing ^ 2) / theoAreaWing;
liftCoeff = (2 * mass) / (1.134 * theoAreaWing);
IDragCoeff = (liftCoeff ^ 2) / (pi * 0.85 * aspectRatio);

%% Final drag coefficients
dragCoeff1 = (1 / 2) * 1.134 * (theoAreaWing + theoAreaHorTail +...
    theoAreaVertTail + theoAreaFuse) * ZLDragCoeff;
dragCoeff2 = (1 / 2) * 1.134 * (theoAreaWing + theoAreaHorTail +...
    theoAreaVertTail + theoAreaFuse) * IDragCoeff;
