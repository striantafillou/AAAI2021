condset(1).
context(1,1).
:- not dconn(1,2,context(1,1)).
:- not dconn(2,3,context(1,1)).
condset(2).
inside_set(2,2).
context(2,1).
:- not dconn(1,3,context(2,1)).
:- dconn(1,3,context(1,1)).
arrow(3,2).