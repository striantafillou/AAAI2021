dataset(X) :- datasets(N), X = 1..N.
node(X) :- nodes(N), X = 1..N.

{ arrow(X,Y) } :- node(X), node(Y), X != Y.
:- arrow(X,Y), arrow(Y,X).
%-arrow(X,Y) :- not arrow(X,Y), node(X), node(Y), X != Y.

ancestor(X,Y) :- arrow(X,Y).
ancestor(X,Y) :- ancestor(X,W), ancestor(W,Y), X != Y.
:- ancestor(X,Y), arrow(Y,X).
-ancestor(X,Y) :- not ancestor(X,Y), node(X), node(Y), X != Y.

{ latent(X,Y) } :- node(X), node(Y), X < Y.
latent(Y,X) :- latent(X,Y).
-latent(X,Y) :- not latent(X,Y), node(X), node(Y), X < Y.

{ selected(X,D) } :- node(X), dataset(D).
-selected(X,D) :- not selected(X,D), dataset(D), node(X).

{ manipulated(X,D) } :- node(X), dataset(D).
-manipulated(X,D) :- not manipulated(X,D), dataset(D), node(X).

{ error(X,D) } :- node(X), dataset(D).
-error(X,D) :- not error(X,D), node(X), dataset(D).

outside_set(X,Z) :- not inside_set(X,Z), node(X), condset(Z).

dconn(X,Y,context(Z,D)) :- outside_set(X,Z), outside_set(Y,Z), into(X,Y,context(Z,D)), X < Y.
dconn(X,Y,context(Z,D)) :- outside_set(X,Z), outside_set(Y,Z), outof(X,Y,context(Z,D)), X < Y.

noncollideropen(X,context(Z,D)) :- outside_set(X,Z), context(Z,D).
noncollideropen(X,context(Z,D)) :- error(X,D), context(Z,D).
collideropen(X,context(Z,D)) :- inside_set(X,Z), context(Z,D).
collideropen(X,context(Z,D)) :- selected(X,D), context(Z,D).

into(X,Y,context(Z,D)) :- arrow(X,Y), noncollideropen(X,context(Z,D)), not manipulated(Y,D).
into(X,Y,context(Z,D)) :- latent(X,Y), noncollideropen(X,context(Z,D)), not manipulated(X,D), not manipulated(Y,D).
outof(X,Y,context(Z,D)) :- arrow(Y,X), noncollideropen(Y,context(Z,D)), not manipulated(X,D).
outof(X,Y,context(Z,D)) :- selected(X,D), selected(Y,D), noncollideropen(X,context(Z,D)), noncollideropen(Y,context(Z,D)), X != Y.
into(X,W,context(Z,D)) :- into(X,Y,context(Z,D)), arrow(Y,W), noncollideropen(Y,context(Z,D)), not manipulated(Y,D), not manipulated(W,D).
outof(X,W,context(Z,D)) :- into(X,Y,context(Z,D)), arrow(W,Y), collideropen(Y,context(Z,D)), not manipulated(Y,D).
into(X,W,context(Z,D)) :- into(X,Y,context(Z,D)), latent(Y,W), collideropen(Y,context(Z,D)), not manipulated(Y,D), not manipulated(W,D).
into(X,W,context(Z,D)) :- outof(X,Y,context(Z,D)), arrow(Y,W), noncollideropen(Y,context(Z,D)), not manipulated(W,D).
into(X,W,context(Z,D)) :- outof(X,Y,context(Z,D)), latent(Y,W), noncollideropen(Y,context(Z,D)), not manipulated(Y,D), not manipulated(W,D).
outof(X,W,context(Z,D)) :- outof(X,Y,context(Z,D)), arrow(W,Y), noncollideropen(Y,context(Z,D)), not manipulated(Y,D).