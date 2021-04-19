% Nodes
node(X) :- nodes(N), X = 1..N.

% Directed Edges
{ arrow(X,Y) } :- node(X), node(Y), X != Y.
:- arrow(X,Y), arrow(Y,X).
notarrow(X,Y) :- not arrow(X,Y), node(X), node(Y), X != Y.
%:- arrow(X,Y), notarrow(X,Y).
#show arrow/2.
#show notarrow/2.

% Ancestral Relations
ancestor(X,Y) :- arrow(X,Y).
ancestor(X,Y) :- ancestor(X,W), ancestor(W,Y), X != Y.
:- ancestor(X,Y), arrow(Y,X).
notancestor(X,Y) :- not ancestor(X,Y), node(X), node(Y), X != Y.
%:- ancestor(X,Y), notancestor(X,Y).
#show ancestor/2.
#show notancestor/2.

% Input Constraints
%:- dep(X,Y,C), not dconn(X,Y,C).
%:- indep(X,Y,C), dconn(X,Y,C).
%:- causes(X,Y), not ancestor(X,Y).
%:- notcauses(X,Y), ancestor(X,Y).

% D-connections
dconn(X,Y,context(Z,D)) :- outside_set(X,Z), outside_set(Y,Z), into(X,Y,context(Z,D)), X < Y.
dconn(X,Y,context(Z,D)) :- outside_set(X,Z), outside_set(Y,Z), outof(X,Y,context(Z,D)), X < Y.

noncollideropen(X,context(Z,D)) :- outside_set(X,Z), context(Z,D).
%noncollideropen(X,context(Z,D)) :- haserror(X,D), context(Z,D).
collideropen(X,context(Z,D)) :- inside_set(X,Z), context(Z,D).
collideropen(X,context(Z,D)) :- selected(X,D), context(Z,D).

% Direct connections
into(X,Y,context(Z,D)) :- arrow(X,Y), noncollideropen(X,context(Z,D)), not manipulated(Y,D). % Case 0a
into(X,Y,context(Z,D)) :- latent(X,Y), noncollideropen(X,context(Z,D)), not manipulated(X,D), not manipulated(Y,D). % Case 0b
outof(X,Y,context(Z,D)) :- arrow(Y,X), noncollideropen(Y,context(Z,D)), not manipulated(X,D). % Case 0c
outof(X,Y,context(Z,D)) :- selected(X,D), selected(Y,D), noncollideropen(X,context(Z,D)), noncollideropen(Y,context(Z,D)), X != Y. % Case 0d

% Indirect connections
into(X,W,context(Z,D)) :- into(X,Y,context(Z,D)), arrow(Y,W), noncollideropen(Y,context(Z,D)), not manipulated(Y,D), not manipulated(W,D).%, X < W. % Case 1
outof(X,W,context(Z,D)) :- into(X,Y,context(Z,D)), arrow(W,Y), collideropen(Y,context(Z,D)), not manipulated(Y,D).%, X < W. % Case 2a
into(X,W,context(Z,D)) :- into(X,Y,context(Z,D)), latent(Y,W), collideropen(Y,context(Z,D)), not manipulated(Y,D), not manipulated(W,D).%, X < W. % Case 2b
into(X,W,context(Z,D)) :- outof(X,Y,context(Z,D)), arrow(Y,W), noncollideropen(Y,context(Z,D)), not manipulated(W,D).%, X < W. % Case 3a
into(X,W,context(Z,D)) :- outof(X,Y,context(Z,D)), latent(Y,W), noncollideropen(Y,context(Z,D)), not manipulated(Y,D), not manipulated(W,D).%, X < W. % Case 3b
outof(X,W,context(Z,D)) :- outof(X,Y,context(Z,D)), arrow(W,Y), noncollideropen(Y,context(Z,D)), not manipulated(Y,D).%, X < W. % Case 4

% Measurement Error
{ haserror(X,D) } :- node(X), dataset(D).
noerror(X,D) :- not haserror(X,D), node(X), dataset(D).
%:- error(X,D), noerror(X,D).
#show noerror/2.
#show haserror/2.

% Latent variables
{ latent(X,Y) } :- node(X), node(Y), X < Y.
latent(Y,X) :- latent(X,Y).
notlatent(X,Y) :- not latent(X,Y), node(X), node(Y), X < Y.
%:- latent(X,Y), notlatent(X,Y).
#show latent/2.
#show notlatent/2.

% Selection
{ selected(X,D) } :- node(X), dataset(D).
notselected(X,D) :- not selected(X,D), dataset(D), node(X).
%:- selected(X,D), notselected(X,D).
#show selected/2.
#show notselected/2.

% Manipulations
{ manipulated(X,D) } :- node(X), dataset(D).
notmanipulated(X,D) :- not manipulated(X,D), dataset(D), node(X).
:- manipulated(X,D), notmanipulated(X,D).
#show manipulated/2.
#show notmanipulated/2.

%%% Things to output %%%
%connected(X,Y) :- arrow(X,Y), X < Y.
%connected(Y,X) :- arrow(X,Y), Y < X.
%connected(X,Y) :- arrow(Y,X), X < Y.
%connected(X,Y) :- arrow(Y,X), Y < X.
%connected(X,Y) :- latent(X,Y), X < Y.
%notconnected(X,Y) :- not connected(X,Y), node(X), node(Y), X < Y.
%#show connected/2.
%#show notconnected/2.