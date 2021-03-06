%http://rhythmiclight.com/archives/ideas/colorscales.html
%http://linaker-wall.net/Colour/Dynamic_Fmt/Swatch_rgb_percent.htm

%http://colorizer.org/
%scriabine
scriabine=[[1,0,0];...
            [0.54,0.41,0.80];...
            [1,1,0];...
            [0.73,0.73,0.73];...
            [0,0.50,1];...
            [0.55,0,0];...
            [0.54,0.17,0.89];...
            [0.94,0.66,0.020];...
            [0.53,0.12,0.47];...
            [0,0.39,0];...
            [0.43,0.48,0.55];...
            [0,0.25,0.53]];

colormap(scriabine)
colorbar

RimskiKorsakov=[[1,1,1];...
            [0,0,0.2];...
            [1,1,0];...
            [0.18,0.31,0.31];...
            [0,0.5,1];...
            [0.30,0.74,0.2];...
            [0.18,0.55,0.34];...
            [0.93,0.71,0.1];...
            [0.51,0.40,0.53];...
            [0.83,0.75,0.81];...
            [0,0,0];...
            [0,0,0.55]];
        
        
colormap(RimskiKorsakov)
colorbar

CycleQuinte1=[[1,0,0];...
            [0,0.5,1];...
            [1,1,0];...
            [0.5,0,1];...
            [0,1,0];...
            [1,0,0.5];...
            [0,1,1];...
            [1,0.5,0];...
            [0,0,1];...
            [0.5,1,0];...
            [1,0,1];...
            [0,1,0.5]];
        
        
colormap(CycleQuinte1)
colorbar

Brightness=4;
CycleQuinte2=[[1,0,0];...
            [0,0.5,1]./Brightness;...
            [1,1,0];...
            [0.5,0,1]./Brightness;...
            [0,1,0];...
            [1,0,0.5];...
            [0,1,1]./Brightness;...
            [1,0.5,0];...
            [0,0,1]./Brightness;...
            [0.5,1,0];...
            [1,0,1]./Brightness;...
            [0,1,0.5]];

        
colormap(CycleQuinte2)
colorbar