% -*- mode: s-lang; mode: fold -*-
% next_article.sl - go to next unreaded article in group mode

% Copyright © 2014- Piotr Rogoża

% License: GNU GPL
% This file may be redistributed and / or modified under the terms of the
% GNU General Public License, version 3 and later, as published by the Free Software
% Foundation.
% 

#iffalse % Documentation %{{{
To install this macro set;

1. Save a copy of this file as "next_article.sl" somewhere so slrn can find it.
Your home directory will do if you don't have a better place for it.

2. Append the following lines to your slrn.rc ($HOME/.slrnrc on Unix) to
make slrn load this file:

interpret "next_article.sl"
setkey group next_article "n"

4. Quit and restart slrn.  slrn will tell you it has loaded this file.
#endif %}}}

define next_article () { %{{{
    if (is_group_mode) {
        select_group();
        call ("next");
    }
} %}}}
