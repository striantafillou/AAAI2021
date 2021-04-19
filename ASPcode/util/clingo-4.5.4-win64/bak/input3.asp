%% Input
nodes(4).

set(0). 
outside_set((1..4),0).
set(1). 
outside_set((1;2;4),1). 
inside_set(3,1).

indep(1,2,0).
dep(1,3,0).
dep(2,3,0).
dep(1,4,0).
dep(2,4,0).
dep(3,4,0).
dep(1,2,1).
% dep(3,4,0).
indep(1,4,1).
indep(2,4,1).
%latentedge(1,3).