%% Input
nodes(3).

% Conditioning Sets
condset(0). outside_set((1;2;3),0).
condset(1). outside_set((1;3),1). inside_set(2,1).

% Datasets
dataset(1).

% Manipulated
%notmanipulated((1;2;3),1).

% Selected
%notselected((1;2;3),1).

% Dataset + Conditioning Set
context(0,1).
context(1,1).

%-selected(1,1).
%-selected(2,1).
%-selected(3,1).
%-manipulated(1,1).
%-manipulated(2,1).
%-manipulated(3,1).
%-notancestor(1,2).
%-notancestor(3,2).
%:- not ancestor(1,2).
%:- not ancestor(3,2).
%causes(1,2).
%causes(3,2).

:- not dconn(1,2,context(0,1)).
:- not dconn(2,3,context(0,1)).
:- not dconn(1,3,context(1,1)).
:- dconn(1,3,context(0,1)).

%dep(1,2,context(0,1)).
%dep(2,3,context(0,1)).
%dep(1,3,context(1,1)).
%indep(1,3,context(0,1)).

%#show into/3.
%#show outof/3.
%#show dconn/3.
