function c = blue2yellow(m)

if nargin < 1, m = size(get(gcf,'colormap'),1); end

C = makecform('srgb2lab');
C2 = makecform('lab2lch');
b = applycform([0 0 1], C);
y = applycform([1 1 0], C);
b = applycform(b, C2);
y = applycform(y, C2);

step = (y-b)/(m-1);
for k=0:m-1
c(k+1, :) = b+step*k;
end

C = makecform('lab2srgb');
C2 = makecform('lch2lab');
c = applycform(c, C2);
c = applycform(c, C);
