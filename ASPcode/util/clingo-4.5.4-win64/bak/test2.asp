nodes(5).
set(-1).
expset(-1).
outside_set((1;2;3;4;5),-1).
set(1).
condset(1).
context(1,-1).
outside_set((1;2;3;4;5),1).
dep(1,2,context(1,-1)).
dep(1,3,context(1,-1)).
dep(1,4,context(1,-1)).
dep(1,5,context(1,-1)).
dep(2,3,context(1,-1)).
dep(2,4,context(1,-1)).
dep(2,5,context(1,-1)).
dep(3,4,context(1,-1)).
dep(3,5,context(1,-1)).
dep(4,5,context(1,-1)).
set(2).
condset(2).
context(2,-1).
inside_set((3),2).
outside_set((1;2;4;5),2).
dep(1,2,context(2,-1)).
set(3).
condset(3).
context(3,-1).
inside_set((4),3).
outside_set((1;2;3;5),3).
dep(1,2,context(3,-1)).
set(4).
condset(4).
context(4,-1).
inside_set((5),4).
outside_set((1;2;3;4),4).
dep(1,2,context(4,-1)).
set(5).
condset(5).
context(5,-1).
inside_set((2),5).
outside_set((1;3;4;5),5).
dep(1,3,context(5,-1)).
dep(1,3,context(3,-1)).
dep(1,3,context(4,-1)).
dep(1,5,context(5,-1)).
set(6).
condset(6).
context(6,-1).
inside_set((1),6).
outside_set((2;3;4;5),6).
dep(2,4,context(6,-1)).
dep(2,4,context(4,-1)).
dep(2,4,context(2,-1)).
dep(3,5,context(6,-1)).
dep(3,5,context(3,-1)).
indep(1,4,context(5,-1)).
indep(1,5,context(2,-1)).
indep(2,3,context(6,-1)).
indep(2,5,context(6,-1)).
indep(3,4,context(6,-1)).
indep(4,5,context(5,-1)).