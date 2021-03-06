nodes(5).
set(0).
outside_set(1,0).
outside_set(2,0).
outside_set(3,0).
outside_set(4,0).
outside_set(5,0).
node(1).
node(2).
node(3).
node(4).
node(5).
:-arrow(2,1),arrow(1,2).
:-arrow(3,1),arrow(1,3).
:-arrow(4,1),arrow(1,4).
:-arrow(5,1),arrow(1,5).
:-arrow(1,2),arrow(2,1).
:-arrow(3,2),arrow(2,3).
:-arrow(4,2),arrow(2,4).
:-arrow(5,2),arrow(2,5).
:-arrow(1,3),arrow(3,1).
:-arrow(2,3),arrow(3,2).
:-arrow(4,3),arrow(3,4).
:-arrow(5,3),arrow(3,5).
:-arrow(1,4),arrow(4,1).
:-arrow(2,4),arrow(4,2).
:-arrow(3,4),arrow(4,3).
:-arrow(5,4),arrow(4,5).
:-arrow(1,5),arrow(5,1).
:-arrow(2,5),arrow(5,2).
:-arrow(3,5),arrow(5,3).
:-arrow(4,5),arrow(5,4).
ancestor(2,1):-arrow(2,1).
ancestor(3,1):-arrow(3,1).
ancestor(4,1):-arrow(4,1).
ancestor(5,1):-arrow(5,1).
ancestor(1,2):-arrow(1,2).
ancestor(3,2):-arrow(3,2).
ancestor(4,2):-arrow(4,2).
ancestor(5,2):-arrow(5,2).
ancestor(1,3):-arrow(1,3).
ancestor(2,3):-arrow(2,3).
ancestor(4,3):-arrow(4,3).
ancestor(5,3):-arrow(5,3).
ancestor(1,4):-arrow(1,4).
ancestor(2,4):-arrow(2,4).
ancestor(3,4):-arrow(3,4).
ancestor(5,4):-arrow(5,4).
ancestor(1,5):-arrow(1,5).
ancestor(2,5):-arrow(2,5).
ancestor(3,5):-arrow(3,5).
ancestor(4,5):-arrow(4,5).
ancestor(3,1):-ancestor(2,1),ancestor(3,2).
ancestor(4,1):-ancestor(2,1),ancestor(4,2).
ancestor(5,1):-ancestor(2,1),ancestor(5,2).
ancestor(2,1):-ancestor(3,1),ancestor(2,3).
ancestor(4,1):-ancestor(3,1),ancestor(4,3).
ancestor(5,1):-ancestor(3,1),ancestor(5,3).
ancestor(2,1):-ancestor(4,1),ancestor(2,4).
ancestor(3,1):-ancestor(4,1),ancestor(3,4).
ancestor(5,1):-ancestor(4,1),ancestor(5,4).
ancestor(2,1):-ancestor(5,1),ancestor(2,5).
ancestor(3,1):-ancestor(5,1),ancestor(3,5).
ancestor(4,1):-ancestor(5,1),ancestor(4,5).
ancestor(3,2):-ancestor(1,2),ancestor(3,1).
ancestor(4,2):-ancestor(1,2),ancestor(4,1).
ancestor(5,2):-ancestor(1,2),ancestor(5,1).
ancestor(1,2):-ancestor(3,2),ancestor(1,3).
ancestor(4,2):-ancestor(3,2),ancestor(4,3).
ancestor(5,2):-ancestor(3,2),ancestor(5,3).
ancestor(1,2):-ancestor(4,2),ancestor(1,4).
ancestor(3,2):-ancestor(4,2),ancestor(3,4).
ancestor(5,2):-ancestor(4,2),ancestor(5,4).
ancestor(1,2):-ancestor(5,2),ancestor(1,5).
ancestor(3,2):-ancestor(5,2),ancestor(3,5).
ancestor(4,2):-ancestor(5,2),ancestor(4,5).
ancestor(2,3):-ancestor(1,3),ancestor(2,1).
ancestor(4,3):-ancestor(1,3),ancestor(4,1).
ancestor(5,3):-ancestor(1,3),ancestor(5,1).
ancestor(1,3):-ancestor(2,3),ancestor(1,2).
ancestor(4,3):-ancestor(2,3),ancestor(4,2).
ancestor(5,3):-ancestor(2,3),ancestor(5,2).
ancestor(1,3):-ancestor(4,3),ancestor(1,4).
ancestor(2,3):-ancestor(4,3),ancestor(2,4).
ancestor(5,3):-ancestor(4,3),ancestor(5,4).
ancestor(1,3):-ancestor(5,3),ancestor(1,5).
ancestor(2,3):-ancestor(5,3),ancestor(2,5).
ancestor(4,3):-ancestor(5,3),ancestor(4,5).
ancestor(2,4):-ancestor(1,4),ancestor(2,1).
ancestor(3,4):-ancestor(1,4),ancestor(3,1).
ancestor(5,4):-ancestor(1,4),ancestor(5,1).
ancestor(1,4):-ancestor(2,4),ancestor(1,2).
ancestor(3,4):-ancestor(2,4),ancestor(3,2).
ancestor(5,4):-ancestor(2,4),ancestor(5,2).
ancestor(1,4):-ancestor(3,4),ancestor(1,3).
ancestor(2,4):-ancestor(3,4),ancestor(2,3).
ancestor(5,4):-ancestor(3,4),ancestor(5,3).
ancestor(1,4):-ancestor(5,4),ancestor(1,5).
ancestor(2,4):-ancestor(5,4),ancestor(2,5).
ancestor(3,4):-ancestor(5,4),ancestor(3,5).
ancestor(2,5):-ancestor(1,5),ancestor(2,1).
ancestor(3,5):-ancestor(1,5),ancestor(3,1).
ancestor(4,5):-ancestor(1,5),ancestor(4,1).
ancestor(1,5):-ancestor(2,5),ancestor(1,2).
ancestor(3,5):-ancestor(2,5),ancestor(3,2).
ancestor(4,5):-ancestor(2,5),ancestor(4,2).
ancestor(1,5):-ancestor(3,5),ancestor(1,3).
ancestor(2,5):-ancestor(3,5),ancestor(2,3).
ancestor(4,5):-ancestor(3,5),ancestor(4,3).
ancestor(1,5):-ancestor(4,5),ancestor(1,4).
ancestor(2,5):-ancestor(4,5),ancestor(2,4).
ancestor(3,5):-ancestor(4,5),ancestor(3,4).
:-arrow(2,1),ancestor(1,2).
:-arrow(3,1),ancestor(1,3).
:-arrow(4,1),ancestor(1,4).
:-arrow(5,1),ancestor(1,5).
:-arrow(1,2),ancestor(2,1).
:-arrow(3,2),ancestor(2,3).
:-arrow(4,2),ancestor(2,4).
:-arrow(5,2),ancestor(2,5).
:-arrow(1,3),ancestor(3,1).
:-arrow(2,3),ancestor(3,2).
:-arrow(4,3),ancestor(3,4).
:-arrow(5,3),ancestor(3,5).
:-arrow(1,4),ancestor(4,1).
:-arrow(2,4),ancestor(4,2).
:-arrow(3,4),ancestor(4,3).
:-arrow(5,4),ancestor(4,5).
:-arrow(1,5),ancestor(5,1).
:-arrow(2,5),ancestor(5,2).
:-arrow(3,5),ancestor(5,3).
:-arrow(4,5),ancestor(5,4).
head(2,1):-arrow(2,1).
head(3,1):-arrow(3,1).
head(4,1):-arrow(4,1).
head(5,1):-arrow(5,1).
head(1,2):-arrow(1,2).
head(3,2):-arrow(3,2).
head(4,2):-arrow(4,2).
head(5,2):-arrow(5,2).
head(1,3):-arrow(1,3).
head(2,3):-arrow(2,3).
head(4,3):-arrow(4,3).
head(5,3):-arrow(5,3).
head(1,4):-arrow(1,4).
head(2,4):-arrow(2,4).
head(3,4):-arrow(3,4).
head(5,4):-arrow(5,4).
head(1,5):-arrow(1,5).
head(2,5):-arrow(2,5).
head(3,5):-arrow(3,5).
head(4,5):-arrow(4,5).
head(1,2):-latentedge(1,2).
head(1,3):-latentedge(1,3).
head(2,3):-latentedge(2,3).
head(1,4):-latentedge(1,4).
head(2,4):-latentedge(2,4).
head(3,4):-latentedge(3,4).
head(1,5):-latentedge(1,5).
head(2,5):-latentedge(2,5).
head(3,5):-latentedge(3,5).
head(4,5):-latentedge(4,5).
head(2,1):-latentedge(1,2).
head(3,1):-latentedge(1,3).
head(3,2):-latentedge(2,3).
head(4,1):-latentedge(1,4).
head(4,2):-latentedge(2,4).
head(4,3):-latentedge(3,4).
head(5,1):-latentedge(1,5).
head(5,2):-latentedge(2,5).
head(5,3):-latentedge(3,5).
head(5,4):-latentedge(4,5).
into(1,2,0):-head(1,2).
into(1,3,0):-head(1,3).
into(1,4,0):-head(1,4).
into(1,5,0):-head(1,5).
into(2,1,0):-head(2,1).
into(2,3,0):-head(2,3).
into(2,4,0):-head(2,4).
into(2,5,0):-head(2,5).
into(3,1,0):-head(3,1).
into(3,2,0):-head(3,2).
into(3,4,0):-head(3,4).
into(3,5,0):-head(3,5).
into(4,1,0):-head(4,1).
into(4,2,0):-head(4,2).
into(4,3,0):-head(4,3).
into(4,5,0):-head(4,5).
into(5,1,0):-head(5,1).
into(5,2,0):-head(5,2).
into(5,3,0):-head(5,3).
into(5,4,0):-head(5,4).
outof(2,1,0):-arrow(1,2).
outof(3,1,0):-arrow(1,3).
outof(4,1,0):-arrow(1,4).
outof(5,1,0):-arrow(1,5).
outof(1,2,0):-arrow(2,1).
outof(3,2,0):-arrow(2,3).
outof(4,2,0):-arrow(2,4).
outof(5,2,0):-arrow(2,5).
outof(1,3,0):-arrow(3,1).
outof(2,3,0):-arrow(3,2).
outof(4,3,0):-arrow(3,4).
outof(5,3,0):-arrow(3,5).
outof(1,4,0):-arrow(4,1).
outof(2,4,0):-arrow(4,2).
outof(3,4,0):-arrow(4,3).
outof(5,4,0):-arrow(4,5).
outof(1,5,0):-arrow(5,1).
outof(2,5,0):-arrow(5,2).
outof(3,5,0):-arrow(5,3).
outof(4,5,0):-arrow(5,4).
outof(2,3,0):-arrow(3,1),outof(2,1,0).
outof(2,4,0):-arrow(4,1),outof(2,1,0).
outof(2,5,0):-arrow(5,1),outof(2,1,0).
outof(3,4,0):-arrow(4,1),outof(3,1,0).
outof(3,5,0):-arrow(5,1),outof(3,1,0).
outof(4,5,0):-arrow(5,1),outof(4,1,0).
outof(1,3,0):-arrow(3,2),outof(1,2,0).
outof(1,4,0):-arrow(4,2),outof(1,2,0).
outof(1,5,0):-arrow(5,2),outof(1,2,0).
outof(3,4,0):-arrow(4,2),outof(3,2,0).
outof(3,5,0):-arrow(5,2),outof(3,2,0).
outof(4,5,0):-arrow(5,2),outof(4,2,0).
outof(1,2,0):-arrow(2,3),outof(1,3,0).
outof(1,4,0):-arrow(4,3),outof(1,3,0).
outof(1,5,0):-arrow(5,3),outof(1,3,0).
outof(2,4,0):-arrow(4,3),outof(2,3,0).
outof(2,5,0):-arrow(5,3),outof(2,3,0).
outof(4,5,0):-arrow(5,3),outof(4,3,0).
outof(1,2,0):-arrow(2,4),outof(1,4,0).
outof(1,3,0):-arrow(3,4),outof(1,4,0).
outof(1,5,0):-arrow(5,4),outof(1,4,0).
outof(2,3,0):-arrow(3,4),outof(2,4,0).
outof(2,5,0):-arrow(5,4),outof(2,4,0).
outof(3,5,0):-arrow(5,4),outof(3,4,0).
outof(1,2,0):-arrow(2,5),outof(1,5,0).
outof(1,3,0):-arrow(3,5),outof(1,5,0).
outof(1,4,0):-arrow(4,5),outof(1,5,0).
outof(2,3,0):-arrow(3,5),outof(2,5,0).
outof(2,4,0):-arrow(4,5),outof(2,5,0).
outof(3,4,0):-arrow(4,5),outof(3,5,0).
into(2,3,0):-head(1,3),outof(2,1,0).
into(2,4,0):-head(1,4),outof(2,1,0).
into(2,5,0):-head(1,5),outof(2,1,0).
into(3,4,0):-head(1,4),outof(3,1,0).
into(3,5,0):-head(1,5),outof(3,1,0).
into(4,5,0):-head(1,5),outof(4,1,0).
into(1,3,0):-head(2,3),outof(1,2,0).
into(1,4,0):-head(2,4),outof(1,2,0).
into(1,5,0):-head(2,5),outof(1,2,0).
into(3,4,0):-head(2,4),outof(3,2,0).
into(3,5,0):-head(2,5),outof(3,2,0).
into(4,5,0):-head(2,5),outof(4,2,0).
into(1,2,0):-head(3,2),outof(1,3,0).
into(1,4,0):-head(3,4),outof(1,3,0).
into(1,5,0):-head(3,5),outof(1,3,0).
into(2,4,0):-head(3,4),outof(2,3,0).
into(2,5,0):-head(3,5),outof(2,3,0).
into(4,5,0):-head(3,5),outof(4,3,0).
into(1,2,0):-head(4,2),outof(1,4,0).
into(1,3,0):-head(4,3),outof(1,4,0).
into(1,5,0):-head(4,5),outof(1,4,0).
into(2,3,0):-head(4,3),outof(2,4,0).
into(2,5,0):-head(4,5),outof(2,4,0).
into(3,5,0):-head(4,5),outof(3,4,0).
into(1,2,0):-head(5,2),outof(1,5,0).
into(1,3,0):-head(5,3),outof(1,5,0).
into(1,4,0):-head(5,4),outof(1,5,0).
into(2,3,0):-head(5,3),outof(2,5,0).
into(2,4,0):-head(5,4),outof(2,5,0).
into(3,4,0):-head(5,4),outof(3,5,0).
into(1,3,0):-arrow(2,3),into(1,2,0).
into(1,4,0):-arrow(2,4),into(1,2,0).
into(1,5,0):-arrow(2,5),into(1,2,0).
into(1,2,0):-arrow(3,2),into(1,3,0).
into(1,4,0):-arrow(3,4),into(1,3,0).
into(1,5,0):-arrow(3,5),into(1,3,0).
into(1,2,0):-arrow(4,2),into(1,4,0).
into(1,3,0):-arrow(4,3),into(1,4,0).
into(1,5,0):-arrow(4,5),into(1,4,0).
into(1,2,0):-arrow(5,2),into(1,5,0).
into(1,3,0):-arrow(5,3),into(1,5,0).
into(1,4,0):-arrow(5,4),into(1,5,0).
into(2,3,0):-arrow(1,3),into(2,1,0).
into(2,4,0):-arrow(1,4),into(2,1,0).
into(2,5,0):-arrow(1,5),into(2,1,0).
into(2,4,0):-arrow(3,4),into(2,3,0).
into(2,5,0):-arrow(3,5),into(2,3,0).
into(2,3,0):-arrow(4,3),into(2,4,0).
into(2,5,0):-arrow(4,5),into(2,4,0).
into(2,3,0):-arrow(5,3),into(2,5,0).
into(2,4,0):-arrow(5,4),into(2,5,0).
into(3,4,0):-arrow(1,4),into(3,1,0).
into(3,5,0):-arrow(1,5),into(3,1,0).
into(3,4,0):-arrow(2,4),into(3,2,0).
into(3,5,0):-arrow(2,5),into(3,2,0).
into(3,5,0):-arrow(4,5),into(3,4,0).
into(3,4,0):-arrow(5,4),into(3,5,0).
into(4,5,0):-arrow(1,5),into(4,1,0).
into(4,5,0):-arrow(2,5),into(4,2,0).
into(4,5,0):-arrow(3,5),into(4,3,0).
dconn(1,2,0):-into(1,2,0).
dconn(1,3,0):-into(1,3,0).
dconn(1,4,0):-into(1,4,0).
dconn(1,5,0):-into(1,5,0).
dconn(2,3,0):-into(2,3,0).
dconn(2,4,0):-into(2,4,0).
dconn(2,5,0):-into(2,5,0).
dconn(3,4,0):-into(3,4,0).
dconn(3,5,0):-into(3,5,0).
dconn(4,5,0):-into(4,5,0).
dconn(1,2,0):-outof(1,2,0).
dconn(1,3,0):-outof(1,3,0).
dconn(2,3,0):-outof(2,3,0).
dconn(1,4,0):-outof(1,4,0).
dconn(2,4,0):-outof(2,4,0).
dconn(3,4,0):-outof(3,4,0).
dconn(1,5,0):-outof(1,5,0).
dconn(2,5,0):-outof(2,5,0).
dconn(3,5,0):-outof(3,5,0).
dconn(4,5,0):-outof(4,5,0).
notarrow(2,1):-not arrow(2,1).
notarrow(3,1):-not arrow(3,1).
notarrow(4,1):-not arrow(4,1).
notarrow(5,1):-not arrow(5,1).
notarrow(1,2):-not arrow(1,2).
notarrow(3,2):-not arrow(3,2).
notarrow(4,2):-not arrow(4,2).
notarrow(5,2):-not arrow(5,2).
notarrow(1,3):-not arrow(1,3).
notarrow(2,3):-not arrow(2,3).
notarrow(4,3):-not arrow(4,3).
notarrow(5,3):-not arrow(5,3).
notarrow(1,4):-not arrow(1,4).
notarrow(2,4):-not arrow(2,4).
notarrow(3,4):-not arrow(3,4).
notarrow(5,4):-not arrow(5,4).
notarrow(1,5):-not arrow(1,5).
notarrow(2,5):-not arrow(2,5).
notarrow(3,5):-not arrow(3,5).
notarrow(4,5):-not arrow(4,5).
directedge(2,1):-arrow(2,1).
directedge(3,1):-arrow(3,1).
directedge(4,1):-arrow(4,1).
directedge(5,1):-arrow(5,1).
directedge(1,2):-arrow(1,2).
directedge(3,2):-arrow(3,2).
directedge(4,2):-arrow(4,2).
directedge(5,2):-arrow(5,2).
directedge(1,3):-arrow(1,3).
directedge(2,3):-arrow(2,3).
directedge(4,3):-arrow(4,3).
directedge(5,3):-arrow(5,3).
directedge(1,4):-arrow(1,4).
directedge(2,4):-arrow(2,4).
directedge(3,4):-arrow(3,4).
directedge(5,4):-arrow(5,4).
directedge(1,5):-arrow(1,5).
directedge(2,5):-arrow(2,5).
directedge(3,5):-arrow(3,5).
directedge(4,5):-arrow(4,5).
directedge(2,1):-arrow(2,1).
directedge(3,1):-arrow(3,1).
directedge(4,1):-arrow(4,1).
directedge(5,1):-arrow(5,1).
directedge(1,2):-arrow(1,2).
directedge(3,2):-arrow(3,2).
directedge(4,2):-arrow(4,2).
directedge(5,2):-arrow(5,2).
directedge(1,3):-arrow(1,3).
directedge(2,3):-arrow(2,3).
directedge(4,3):-arrow(4,3).
directedge(5,3):-arrow(5,3).
directedge(1,4):-arrow(1,4).
directedge(2,4):-arrow(2,4).
directedge(3,4):-arrow(3,4).
directedge(5,4):-arrow(5,4).
directedge(1,5):-arrow(1,5).
directedge(2,5):-arrow(2,5).
directedge(3,5):-arrow(3,5).
directedge(4,5):-arrow(4,5).
notdirectedge(1,2):-not directedge(1,2).
notdirectedge(1,3):-not directedge(1,3).
notdirectedge(2,3):-not directedge(2,3).
notdirectedge(1,4):-not directedge(1,4).
notdirectedge(2,4):-not directedge(2,4).
notdirectedge(3,4):-not directedge(3,4).
notdirectedge(1,5):-not directedge(1,5).
notdirectedge(2,5):-not directedge(2,5).
notdirectedge(3,5):-not directedge(3,5).
notdirectedge(4,5):-not directedge(4,5).
notlatentedge(1,2):-not latentedge(1,2).
notlatentedge(1,3):-not latentedge(1,3).
notlatentedge(2,3):-not latentedge(2,3).
notlatentedge(1,4):-not latentedge(1,4).
notlatentedge(2,4):-not latentedge(2,4).
notlatentedge(3,4):-not latentedge(3,4).
notlatentedge(1,5):-not latentedge(1,5).
notlatentedge(2,5):-not latentedge(2,5).
notlatentedge(3,5):-not latentedge(3,5).
notlatentedge(4,5):-not latentedge(4,5).
notselection(1).
notselection(2).
notselection(3).
notselection(4).
notselection(5).
edge(1,2):-directedge(1,2).
edge(1,3):-directedge(1,3).
edge(2,3):-directedge(2,3).
edge(1,4):-directedge(1,4).
edge(2,4):-directedge(2,4).
edge(3,4):-directedge(3,4).
edge(1,5):-directedge(1,5).
edge(2,5):-directedge(2,5).
edge(3,5):-directedge(3,5).
edge(4,5):-directedge(4,5).
edge(1,2):-latentedge(1,2).
edge(1,3):-latentedge(1,3).
edge(2,3):-latentedge(2,3).
edge(1,4):-latentedge(1,4).
edge(2,4):-latentedge(2,4).
edge(3,4):-latentedge(3,4).
edge(1,5):-latentedge(1,5).
edge(2,5):-latentedge(2,5).
edge(3,5):-latentedge(3,5).
edge(4,5):-latentedge(4,5).
notedge(1,2):-not edge(1,2).
notedge(1,3):-not edge(1,3).
notedge(2,3):-not edge(2,3).
notedge(1,4):-not edge(1,4).
notedge(2,4):-not edge(2,4).
notedge(3,4):-not edge(3,4).
notedge(1,5):-not edge(1,5).
notedge(2,5):-not edge(2,5).
notedge(3,5):-not edge(3,5).
notedge(4,5):-not edge(4,5).
notancestor(2,1):-not ancestor(2,1).
notancestor(3,1):-not ancestor(3,1).
notancestor(4,1):-not ancestor(4,1).
notancestor(5,1):-not ancestor(5,1).
notancestor(1,2):-not ancestor(1,2).
notancestor(3,2):-not ancestor(3,2).
notancestor(4,2):-not ancestor(4,2).
notancestor(5,2):-not ancestor(5,2).
notancestor(1,3):-not ancestor(1,3).
notancestor(2,3):-not ancestor(2,3).
notancestor(4,3):-not ancestor(4,3).
notancestor(5,3):-not ancestor(5,3).
notancestor(1,4):-not ancestor(1,4).
notancestor(2,4):-not ancestor(2,4).
notancestor(3,4):-not ancestor(3,4).
notancestor(5,4):-not ancestor(5,4).
notancestor(1,5):-not ancestor(1,5).
notancestor(2,5):-not ancestor(2,5).
notancestor(3,5):-not ancestor(3,5).
notancestor(4,5):-not ancestor(4,5).
#count{0,arrow(2,1):arrow(2,1)}.
#count{0,arrow(3,1):arrow(3,1)}.
#count{0,arrow(4,1):arrow(4,1)}.
#count{0,arrow(5,1):arrow(5,1)}.
#count{0,arrow(1,2):arrow(1,2)}.
#count{0,arrow(3,2):arrow(3,2)}.
#count{0,arrow(4,2):arrow(4,2)}.
#count{0,arrow(5,2):arrow(5,2)}.
#count{0,arrow(1,3):arrow(1,3)}.
#count{0,arrow(2,3):arrow(2,3)}.
#count{0,arrow(4,3):arrow(4,3)}.
#count{0,arrow(5,3):arrow(5,3)}.
#count{0,arrow(1,4):arrow(1,4)}.
#count{0,arrow(2,4):arrow(2,4)}.
#count{0,arrow(3,4):arrow(3,4)}.
#count{0,arrow(5,4):arrow(5,4)}.
#count{0,arrow(1,5):arrow(1,5)}.
#count{0,arrow(2,5):arrow(2,5)}.
#count{0,arrow(3,5):arrow(3,5)}.
#count{0,arrow(4,5):arrow(4,5)}.
#count{0,latentedge(1,2):latentedge(1,2)}.
#count{0,latentedge(1,3):latentedge(1,3)}.
#count{0,latentedge(2,3):latentedge(2,3)}.
#count{0,latentedge(1,4):latentedge(1,4)}.
#count{0,latentedge(2,4):latentedge(2,4)}.
#count{0,latentedge(3,4):latentedge(3,4)}.
#count{0,latentedge(1,5):latentedge(1,5)}.
#count{0,latentedge(2,5):latentedge(2,5)}.
#count{0,latentedge(3,5):latentedge(3,5)}.
#count{0,latentedge(4,5):latentedge(4,5)}.
#show notselection/1.
#show selection/1.
#show arrow/2.
#show directedge/2.
#show edge/2.
#show latentedge/2.
#show notarrow/2.
#show notdirectedge/2.
#show notlatentedge/2.
