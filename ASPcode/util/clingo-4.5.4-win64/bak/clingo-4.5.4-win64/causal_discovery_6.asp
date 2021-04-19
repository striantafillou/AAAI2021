% nodes
node(X) :- nodes(N), X = 1..N.

% edges
{ arrow(X,Y) } :- node(X), node(Y), X != Y.

% At most one edge between two nodes
:- arrow(X,Y), arrow(Y,X).

% Enforce acyclicity
ancestor(X,Y) :- arrow(X,Y), X != Y.
ancestor(X,Y) :- ancestor(X,W), ancestor(W,Y), X != Y, X != W, Y != W.
:- ancestor(X,Y), arrow(Y,X).

% Set stuff (NOTE: probably not necessary if all sets are given explicitly as input)
:- outside_set(X,S), inside_set(X,S).

% Convert input constraints s.t. X < Y always (valid, as dep/indep are symmetric).
% This allows to always assume X < Y, dramatically reducing the number of constraints, as well as avoiding performing inferences multiple times.
%indep_ord(X,Y,Z) :- indep(X,Y,Z), X < Y.
%indep_ord(Y,X,Z) :- indep(X,Y,Z), X > Y.
%dep_ord(X,Y,Z) :- dep(X,Y,Z), X < Y.
%dep_ord(Y,X,Z) :- dep(X,Y,Z), X > Y.

% Input constraints must be satisfied
:- dep(X,Y,C), not dconn(X,Y,C).
:- indep(X,Y,C), dconn(X,Y,C).

% End-points
head(X,Y) :- arrow(X,Y), X != Y.
%tail(Y,X) :- arrow(X,Y), X != Y.

dconn(X,Y,C) :- into(X,Y,C), X < Y.
dconn(X,Y,C) :- outof(X,Y,C), X < Y.

noncollideropen(X,Z) :- outside_set(X,Z), condset(Z).
collideropen(X,Z) :- inside_set(X,Z), condset(Z).

into(X,Y,context(Z,E)) :- condset(Z), expset(E), notmanipulated(Y,E), head(X,Y), noncollideropen(X,Z), X != Y. % Case 0a
outof(X,Y,context(Z,E)) :- condset(Z), expset(E), arrow(Y,X), noncollideropen(Y,Z), X != Y.  % Case 0b
into(X,C,context(Z,E)) :- into(X,Y,context(Z,E)), condset(Z), expset(E), noncollideropen(Y,Z), arrow(Y,C), X != Y, Y != C, X < C. % Case 1
outof(X,P,context(Z,E)) :- into(X,Y,context(Z,E)), condset(Z), expset(E), collideropen(Y,Z), notmanipulated(Y,E), arrow(P,Y), X != Y, Y != P, X < P. % Case 2
into(X,C,context(Z,E)) :- outof(X,Y,context(Z,E)), condset(Z), expset(E), noncollideropen(Y,Z), head(Y,C), X != Y, Y != C, X < C. % Case 3
outof(X,P,context(Z,E)) :- outof(X,Y,context(Z,E)), condset(Z), expset(E), noncollideropen(Y,Z), notmanipulated(Y,E), arrow(P,Y), X != Y, Y != P, X < P. % Case 4

% Measurement Error
%{ haserror(X) } :- nodes(N), node(X).
%noerror(X) :- nodes(N), not haserror(X), node(X).
%noncollideropen(X,Z) :- haserror(X), condset(Z).
%#show noerror/1.
%#show haserror/1.

% Latent variables
%{ latentedge(X,Y) } :- node(X), node(Y), X < Y.
%head(X,Y) :- latentedge(X,Y), X != Y.
%head(Y,X) :- latentedge(X,Y), X != Y.
%into(X,P,context(Z,E)) :- into(X,Y,context(Z,E)), condset(Z), expset(E), collideropen(Y,Z), notmanipulated(Y,E), head(P,Y), head(Y,P), X != Y, Y != P, X < P. % Case 2a
%#show latentedge/2.
%#show notlatentedge/2.

% Selection
%{ selection(X) } :- node(X).
%collideropen(X,Z) :- selection(X), condset(Z).
%notselection(X) :- not selection(X), node(X).
%#show selection/1.
%#show notselection/1.

% Experimental
{ manipulated(X,E) } :- node(X), expset(E).
notmanipulated(X,E) :- not manipulated(X,E), expset(E), node(X).
%manipulated(X,E) :- inside_set(X,E), expset(E).
%notmanipulated(X,E) :- outside_set(X,E), expset(E).
#show manipulated/2.
#show notmanipulated/2.

%%% Things to output %%%

% Direct arrow
notarrow(X,Y) :- not arrow(X,Y), node(X), node(Y), X != Y.

% Direct edge
directedge(X,Y) :- arrow(X,Y).
directedge(Y,X) :- arrow(X,Y).
notdirectedge(X,Y) :- not directedge(X,Y), node(X), node(Y), X < Y.

% Latent connections
notlatentedge(X,Y) :- not latentedge(X,Y), node(X), node(Y), X < Y.

% Any connection
edge(X,Y) :- directedge(X,Y), X < Y.
edge(X,Y) :- latentedge(X,Y), X < Y.
notedge(X,Y) :- not edge(X,Y), node(X), node(Y), X < Y.

% Ancestral relations
notancestor(X,Y) :- not ancestor(X,Y), node(X), node(Y), X != Y.

% show results
#show arrow/2.
#show notarrow/2.
%#show directedge/2.
%#show notdirectedge/2.
#show edge/2.
%#show head/2.
%#show tail/2.
%#show ancestor/2.
%#show notancestor/2.