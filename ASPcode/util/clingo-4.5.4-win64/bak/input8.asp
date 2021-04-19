%% Input
nodes(2).

set(0). condset(0). outside_set((1;2),0).
expset(-1). outside_set((1;2),-1).
expset(-2). outside_set((1;2),-2).
context(0,-1).
context(0,-2).

selection(1).
selection(2).
%dep(1,2,context(0,-1)).

%dep(1,2,context(0,-1)).
%dep(1,3,context(0,-1)).
%dep(2,3,context(0,-1)).
%indep(1,3,context(1,-1)).

%dep(1,2,0).
%dep(2,3,0).
%indep(1,3,0).
%dconn(1,3,0).
%dconn(1,3,0).
%dep(1,3,1).
