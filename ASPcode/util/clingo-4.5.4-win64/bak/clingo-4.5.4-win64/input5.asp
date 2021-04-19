%% Input
nodes(3).

%-arrow(1,2).
%-arrow(2,1).
%-arrow(2,3).
%-arrow(3,2).

set(0).
inside_set(2,0).
outside_set((1;3),0).
indep(1,3,0).

set(1).
outside_set((1;2;3),1).
dep(1,3,1).