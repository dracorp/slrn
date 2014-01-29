% Detach slrn in a screen session    % -*- mode: s-lang; mode: fold -*-
% Copyright © 2014 Piotr Rogoża
% Title: screen.sl
% Author: Piotr Rogoża
% Version: 1.0
% License: GNU GPL
% 

#iffalse % Documentation                                                %{{{
% To install this macro set;
%
% 1. Save a copy of this file as "scren.sl" somewhere so slrn can
%     find it.  Your home directory will do if you don't have a better place
%     for it.
%
% (2) Append the following lines to your slrn.rc ($HOME/.slrnrc on Unix) to
%     make slrn load this file:
%
%        interpret "screen.sl"
%        setkey group screen->detach "q"
%
% (3) Quit and restart slrn.  slrn will tell you it has loaded this file.
%
#endif %}}}

implements ("screen");

static define detach ()
{
    % send 'ctrl-a d' to the screen
    variable cmd = "screen -d";
    if (getenv ("TERM") == "screen")
       () = system (cmd);
}

