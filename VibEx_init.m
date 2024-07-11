% Initialize the VibEx toolbox.
% Usage: VibEx_init
%
% Run this function before using the toolkit.
% This function needs to be run from within the VibEx
% folder. It adds all necessary folders from the VibEx toolkit
% to the Matlab path.
function VibEx_init()
sep = filesep;
add_subdirs_to_path ([pwd], sep);
if strcmp(version('-release'),'13')
    warning off MATLAB:m_warning_end_without_block
end
set_graphics_defaults

disp(' ');
    disp(['  Vibration Exploratory']);
    disp(['        VibEx 1.1 (C)  7/13/2024, Petr Krysl.']);
    % disp(['        VibEx 1.0 (C)  7/13/2014, Petr Krysl.']);
    disp('  Please report problems and/or bugs to: pkrysl@ucsd.edu');
    disp(' ');
    disp('  Help is available: use the command "<a href="matlab:doc VibEx">doc VibEx</a>"');
    disp('  ')

% Illustralab initialization
% addpath (['C:\Documents and Settings\pkrysl\My Documents\Matlab_folder\Illustralab'], sep);
Illustralab_init;

return;

function add_subdirs_to_path(d, sep)
dl=dir(d);
for i=1:length(dl)
    if (dl(i).isdir)
        if      (~strcmp(dl(i).name,'.')) & ...
                (~strcmp(dl(i).name,'..')) & ...
                (~strcmp(dl(i).name,'CVS')) & ...
                (~strcmp(dl(i).name,'cvs')) & ...
                (~strcmp(dl(i).name(1),'@'))
            addpath([d sep dl(i).name])
            add_subdirs_to_path([d sep dl(i).name], sep);
        end
    end
end
return;



