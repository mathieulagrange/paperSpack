function cmap = generateColormap (nbTracks)
% returns a colormap with randomly chosen colors somewhat evenly spread in
% the color spectrum, to be used for the graphical representations of a
% synthesized scene.

% Background sounds will have a saturation of .3, foreground sounds of 1
% Value is always let to .5, since modifying it would erroneously suggest
% a difference of intensity

% nbTracks = length(sceneObjects);

% Colors for figures
% Choosing color hues evenly spread in the color spectrum, then randomizing their order
rng(0);
hues = (0:1/nbTracks:1);
hues = hues(1:nbTracks);
hues = hues(randperm(nbTracks));
% Generate a colormap:
for c=1:nbTracks
%     if (sceneObjects(c).background)
%         cmap(c,:) = hsl2rgb([hues(c), .3, .5]);
%     else
        cmap(c,:) = hsv2rgb([hues(c), 1, .8]);
%     end
end


end