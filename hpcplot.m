function [s_plot] = hpcplot(varargin)
%Plots spectrogram of HPC.
%Scale on vertical
%time or samples on horizontal
%Red blue colormap

if nargin == 2
    t=varargin{2};
    imagesc('XData',t,'CData',varargin{1},[-1 1]);
    xlabel('Time (s)','fontweight','bold'); 
else
    imagesc('CData',varargin{1},[-1 1]);
    xlabel('Sample','fontweight','bold'); 
end

axis xy; 
axis tight; 
ylabel('Scale','fontweight','bold');


colormap(redblue);
colorbar;


end

