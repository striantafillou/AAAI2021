%% Input
nodes(4).

set(0).
outside_set((1;2;3;4),0).

dep(1,4,0).
dep(1,3,0).
indep(1,2,0).

dep(2,4,0).
dep(2,3,0).
indep(2,1,0).

set(1).
outside_set((3;4),1).
inside_set((1;2),1).

dep(4,1,1).
dep(4,2,1).
dep(4,3,1).

set(2).
outside_set((1;2;4),2).
inside_set(3,2).

indep(3,1,2).
indep(3,2,2).
dep(3,4,2).