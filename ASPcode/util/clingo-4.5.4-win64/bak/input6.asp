%% Input
nodes(3).

set(0). 
outside_set((1..3),0).

set(1). 
outside_set((1;3),1). 
inside_set(2,1).

dep(1,2,0).
dep(1,3,0).
dep(2,3,0).
indep(1,3,1).
head(1,2).