%% Input
nodes(3).

set(-1). expset(-1). notmanipulated((1;2;3),-1).
set(0). condset(0). outside_set((1;2;3),0).
set(1). condset(1). outside_set((1;3),1). inside_set(2,1).
context(0,-1).
context(1,-1).

dep(1,2,context(0,-1)).
dep(1,3,context(0,-1)).
dep(2,3,context(0,-1)).
indep(1,3,context(1,-1)).

set(-2). expset(-2). % outside_set((1;3),-2). inside_set(2,-2).
context(0,-2).
indep(1,2,context(0,-2)).
indep(1,3,context(0,-2)).
dep(2,3,context(0,-2)).
