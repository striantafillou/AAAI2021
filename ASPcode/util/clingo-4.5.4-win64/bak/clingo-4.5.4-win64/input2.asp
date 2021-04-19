%% Input
nodes(50).

set(0). 
outside_set((1;2;3;4),0).
outside_set((5..50),0).

set(1). 
outside_set((1;2;3),1). 
inside_set(4,1).
outside_set((5..50),1).

indep(1,2,0).
dep(1,4,0).
dep(2,4,0).
dep(1,3,0).
indep(1,3,1).	
dep(2,3,0).
indep(2,3,1).
