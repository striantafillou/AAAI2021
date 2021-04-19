node(X) :- nodes(N), X = 1..N.
{ directed(X,Y) } :- node(X), node(Y), X!=Y.
{ bidirected(X,Y) } :- node(X), node(Y), X < Y.

%bidirected(X, Y):-bidirected(Y, X).
bidir(X, Y):-bidirected(X, Y), X!=Y.
bidir(X, Y):-bidirected(Y, X), X!=Y.

edge(X, Y):-directed(X, Y).
edge(X, Y):-bidirected(X, Y).
edge(X, Y):-directed(Y, X).

% Ancestral relation
ancestor(X,Y) :- directed(X,Y).
ancestor(X,Y) :- ancestor(X,W), ancestor(W,Y), X != Y, X != W, Y != W.
ancestor(X, Y):- X==Y, node(X).
% No cycle or almost cycle
:- ancestor(X,Y), directed(Y,X).
% negation
%notancestor(X,Y) :- not ancestor(X,Y), node(X), node(Y), X != Y.

:- anc(X, Y), not ancestor(X, Y).
:- nanc(X, Y), ancestor(X, Y).

% ancestors
ancestors(Z, X, Y):-ancestor(Z, X), node(Y).
ancestors(Z, X, Y):-ancestors(Z, Y, X).

h(X, Z, Y ) :- directed(X, Z), ancestors(Z, X, Y), X!=Y.
h(X, Z, Y ) :- bidir(X, Z), ancestors(Z, X, Y),X!=Y.
h(X, Z, Y ) :- h(X, U, Y ), bidir(Z, U), ancestors(Z, X, Y ),X!=Y.
t(X, Z, Y ) :- h(X, U, Y ), directed(Z, U), ancestors(Z, X, Y ),X!=Y.


indc(X, Y):-h(X,Y,Y).
indc(X, Y):-t(X,Y,Y).
indc(X,Y):-directed(Y, X).
%indc(X, Y):-bidir(X, Y).
%indc(X, Y):-directed(X, Y).
indc(X, Y):-indc(Y, X).
nindc(X, Y):-not indc(X, Y), node(X), node(Y), X!=Y.

% collider
collider(X, Y, Z):-h(X, Y, Y),h(Z, Y, Y), X!=Z.
collider(X, Y, Z):-collider(Z, Y, X). % symmetry
notcollider(X, Y, Z):-not collider(X, Y, Z), node(X), node(Y), node(Z), X!=Z, Y!=Z, X!=Y.

ucol(X, Y, Z):-indc(X, Y), indc(Y, Z), nindc(X, Z), collider(X, Y, Z).
udnc(X, Y,Z):-indc(X, Y), indc(Y, Z), nindc(X, Z), notcollider(X, Y, Z).

:-inducing(X, Y), not indc(X,Y).
:-ninducing(X, Y), indc(X, Y).
:-unshielded(X, Y, Z), not unshld(X,Y, Z).
:-dnc(X, Y, Z), collider(X, Y, Z).
:-col(X, Y, Z), not collider(X, Y, Z).