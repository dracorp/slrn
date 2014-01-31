% -*- mode: s-lang; mode: fold -*-
% screen.sl - detach slrn in a screen sessios

% Copyright © 2014- Piotr Rogoża
% set_preference() mechanism borrowed from J.B. Nicholson-Owens

% License: GNU GPL
% This file may be redistributed and / or modified under the terms of the
% GNU General Public License, version 3 and later, as published by the Free Software
% Foundation.
% 

#iffalse % Documentation %{{{
To install this macro set;

1. Save a copy of this file as "scren.sl" somewhere so slrn can find it.
Your home directory will do if you don't have a better place for it.

2. Append the following lines to your slrn.rc ($HOME/.slrnrc on Unix) to
make slrn load this file:

interpret "screen.sl"
setkey group screen->detach "q"

3. You can use the set_preference() function to customize the behaviour of
the simple interface. To do this, put calls to this function in a file and
load it after this file is loaded. The following examples show the default
values:

Confirm exit without a screen session:
screen->set_preference("confirm exit"), 1);

Confirm exit in a screen session:
screen->set_preference("confirm screen exit"), 0);

4. Quit and restart slrn.  slrn will tell you it has loaded this file.
#endif %}}}

implements ("screen");

private variable
    prefs = Assoc_Type[];

% Set preferences %{{{
prefs["confirm exit"] = 1;
prefs["confirm screen exit"] = 0;
%}}}

static define set_preference (preference, value) %{{{
{
   !if (assoc_key_exists (prefs, preference))
     error ("Preference does not exist: " + string (preference));
   variable desired_type = typeof (prefs[preference]);
   if (typeof (value) != desired_type)
     verror ("Wrong type for %s: This preference wants %s not %s",
             string (preference),
             string (desired_type),
             string (typeof (value)));
   prefs[preference] = value;
}
%}}}
static define detach () %{{{
{
    % send 'ctrl-a d' to the screen
    variable cmd = "screen -d";
    if (getenv ("TERM") == "screen") {
        if (prefs["confirm screen exit"]) {
            set_integer_variable ("confirm_actions", 31);
        }
        () = system (cmd);
    } else {
        % Confirm quitting slrn.
        if (prefs["confirm exit"]) {
            set_integer_variable ("confirm_actions", 31);
        }
        call ("quit");
    }
}
%}}}
