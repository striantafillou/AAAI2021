node(X) :- nodes(N), X = 1..N.
set(X):-sets(N), X=0..2**(N-2)-1.
ismember(M,Z) :- set(M), node(Z), M & (2**(Z-2-1)) != 0.
% core variables.
{ directed(X,Y) } :- node(X), node(Y), X!=Y.
{ bidirected(X,Y) } :- node(X), node(Y), X < Y.

%bidirected(X, Y):-bidirected(Y, X).
bidir(X, Y):-bidirected(X, Y), node(X), node(Y), X!=Y.
bidir(X, Y):-bidirected(Y, X), node(X), node(Y), X!=Y.


not directed(X,Y):-nconnected(X, Y), node(X), node(Y).
not directed(Y, X):-nconnected(X, Y), node(X), node(Y).
not bidir(X, Y):-nconnected(X, Y), node(X), node(Y).
nconnected(X, Y):-nconnected(X,Y), node(X), node(Y).

% Ancestral relation
ancestor(X,Y) :- directed(X,Y).
ancestor(X,Y) :- ancestor(X,W), ancestor(W,Y), X != Y, X != W, Y != W.
ancestor(X, Y):- X==Y, node(X).
% No cycle or almost cycle
:- ancestor(X,Y), directed(Y,X).
% negation
notancestor(X,Y) :- not ancestor(X,Y), node(X), node(Y), X != Y.

:- anc(X, Y), not ancestor(X, Y).
%:- nanc(X, Y), ancestor(X, Y).

% ancestors
ancestors(Z, X, Y):-ancestor(Z, X), node(Y).
ancestors(Z, X, Y):-ancestors(Z, Y, X).

% inducing
h(X, Z, Y ) :- directed(X, Z), ancestors(Z, X, Y), X!=Y.
h(X, Z, Y ) :- bidir(X, Z), ancestors(Z, X, Y),X!=Y.
h(X, Z, Y ) :- h(X, U, Y ), bidir(Z, U), ancestors(Z, X, Y ),X!=Y.
t(X, Z, Y ) :- h(X, U, Y ), directed(Z, U), ancestors(Z, X, Y ),X!=Y.
indc(X, Y):-h(X,Y,Y).
indc(X, Y):-t(X,Y,Y).
indc(X,Y):-directed(Y, X).
indc(X, Y):-indc(Y, X).
nindc(X, Y):-not indc(X, Y), node(X), node(Y), X!=Y.

% collider
collider(X, Y, Z):-h(X, Y, Y),h(Z, Y, Y), X!=Z.
collider(X, Y, Z):-collider(Z, Y, X). % symmetry
notcollider(X, Y, Z):-not collider(X, Y, Z), node(X), node(Y), node(Z), X!=Z, Y!=Z, X!=Y.


% is adjustment set, condition a.
inCP12(W):-ancestor(1, W), ancestor(W, 2),  W!=1, W!=2. %lies on a path from 1 to 2.
notconda(Z):-inCP12(W), ismember(Z, Q), ancestor(W,Q), node(W), node(Q),  set(Z).
conda(Z):- not notconda(Z), set(Z).

% directed in proper backdoor graph
firstOnPCP(Y):-directed(1, Y), ancestor(Y, 2), node(Y). % is the first node on a (proper) causal path from 1 to 2.
ndirectedPG(X, Y):- node(X), X==1, firstOnPCP(Y), node(Y).
directedPG(X, Y):- directed(X, Y),  not ndirectedPG(X, Y), node(X), node(Y).

dconnPG(X,Y,Z) :- not ismember(Z, X), not ismember(Z, Y), into(X,Y,Z), X < Y.
dconnPG(X,Y,Z) :- not ismember(Z, X), not ismember(Z, Y), outof(X,Y,Z), X < Y.

% Basic Bayes-Ball algorithm without latent variables or selection bias.
outof(X,X,Z) :- not ismember(Z, X), node(X), set(Z).
into(X,W,Z) :- outof(X,Y,Z), not ismember(Z, Y), directedPG(Y,W). %
outof(X,W,Z) :- outof(X,Y,Z), not ismember(Z, Y), directedPG(W,Y).%, not notPG(Y), not W==1. % cannot go through a proper causal edge
outof(X,W,Z) :- into(X,Y,Z), ismember(Z, Y), directedPG(W,Y).
into(X,W,Z) :- into(X,Y,Z), not ismember(Z, Y), directedPG(Y,W).

% Bayes-Ball with latent variables.
into(X,W,Z) :- outof(X,Y,Z), not ismember(Z, Y), bidir(Y,W).
into(X,W,Z) :- into(X,Y,Z), ismember(Z, Y), bidir(Y,W).
dconnPG12(Z):-dconnPG(1, 2, Z), set(Z).
dconnPG12(Z):-dconnPG(2, 1, Z), set(Z).
condb(Z):-not dconnPG(1, 2, Z), set(Z).% condition b: Z d-separates 1 and 2 in the proper backdoor graph.

% adjustment set: condition a, condition b.
adjSet12(Z):-conda(Z), condb(Z).

:-inducing(X, Y), not indc(X,Y).
:-ninducing(X, Y), indc(X, Y).
%:-unshielded(X, Y, Z), not unshld(X,Y, Z).
:-dnc(X, Y, Z), collider(X, Y, Z).
:-col(X, Y, Z), not collider(X, Y, Z).
:-anc(X, Y), not ancestor(X, Y).
%:-dep(X, Y, Z), not dconn(X, Y, Z).
%:-ind(X, Y, Z), dconn(X, Y, Z).
:-isadjset(Z), not adjSet12(Z).
:-nisadjset(Z), adjSet12(Z).


% % m-separation
% %connected
% connected(X,Y) :- directed(X,Y).
% connected(X, Y):- bidirected(X, Y).
% connected(X,Y) :- connected(Y,X).
% notconnected(X,Y) :- not connected(X,Y), node(X), node(Y), X != Y.
% notbidir(X,Y) :- not bidirected(X,Y), node(X), node(Y), X < Y.
% 
% % dconn
% dconn(X,Y,Z) :- not ismember(Z, X), not ismember(Z, Y), into(X,Y,Z), X < Y. % opposite from Yorgos because I want to use dsep(2, 1)
% dconn(X,Y,Z) :- not ismember(Z, X), not ismember(Z, X), outof(X,Y,Z), X < Y.
% 
% 
% % Basic Bayes-Ball algorithm without latent variables or selection bias.
% outof(X,X,Z) :- not ismember(X,Z), node(X), set(Z).
% into(X,W,Z) :- outof(X,Y,Z), not ismember(Z, Y), directed(Y,W). %
% outof(X,W,Z) :- outof(X,Y,Z), not ismember(Z, Y), directed(W,Y).%, not notPG(Y), not W==1. % cannot go through a proper causal edge
% outof(X,W,Z) :- into(X,Y,Z), ismember(Z, Y), directed(W,Y).
% into(X,W,Z) :- into(X,Y,Z), not ismember(Z, Y), directed(Y,W).
% 
% % Bayes-Ball with latent variables.
% into(X,W,Z) :- outof(X,Y,Z), not ismember(Z, Y), bidir(Y,W).
% into(X,W,Z) :- into(X,Y,Z), ismember(Z, Y), bidir(Y,W).

