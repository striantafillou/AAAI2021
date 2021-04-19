%% Input
nodes(3).

set(0). condset(0). outside_set((1;2;3),0).
set(1). condset(1). outside_set((1;3),1). inside_set(2,1).
expset(-1). outside_set((1;2;3),-1).
context(0,-1).
context(1,-1).

dep(1,2,context(0,-1)).
dep(1,3,context(0,-1)).
dep(2,3,context(0,-1)).
indep(1,3,context(1,-1)).

%dep(1,2,0).
%dep(2,3,0).
%indep(1,3,0).
%dconn(1,3,0).
%dconn(1,3,0).
%dep(1,3,1).
