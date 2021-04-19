condset(1).
context(1,1).
condset(2).
inside_set(2,2).
context(2,1).
arrow(1,2).
datasets(1).
nodes(3).
node(1):-nodes(3).
node(2):-nodes(3).
node(3):-nodes(3).
outside_set(1,1):-condset(1),node(1).
outside_set(2,1):-condset(1),node(2).
outside_set(3,1):-condset(1),node(3).
outside_set(1,2):-condset(2),node(1).
outside_set(3,2):-condset(2),node(3).
noncollideropen(1,context(1,1)):-context(1,1),outside_set(1,1).
noncollideropen(2,context(1,1)):-context(1,1),outside_set(2,1).
noncollideropen(3,context(1,1)):-context(1,1),outside_set(3,1).
noncollideropen(1,context(2,1)):-context(2,1),outside_set(1,2).
noncollideropen(3,context(2,1)):-context(2,1),outside_set(3,2).
dataset(1):-datasets(1).
noncollideropen(2,context(2,1)):-context(2,1),haserror(2,1).
into(1,2,context(1,1)):-noncollideropen(1,context(1,1)),arrow(1,2),not manipulated(2,1).
into(1,3,context(1,1)):-noncollideropen(1,context(1,1)),arrow(1,3),not manipulated(3,1).
into(2,1,context(1,1)):-noncollideropen(2,context(1,1)),arrow(2,1),not manipulated(1,1).
into(2,3,context(1,1)):-noncollideropen(2,context(1,1)),arrow(2,3),not manipulated(3,1).
into(3,1,context(1,1)):-noncollideropen(3,context(1,1)),arrow(3,1),not manipulated(1,1).
into(3,2,context(1,1)):-noncollideropen(3,context(1,1)),arrow(3,2),not manipulated(2,1).
into(1,2,context(2,1)):-noncollideropen(1,context(2,1)),arrow(1,2),not manipulated(2,1).
into(1,3,context(2,1)):-noncollideropen(1,context(2,1)),arrow(1,3),not manipulated(3,1).
into(3,1,context(2,1)):-noncollideropen(3,context(2,1)),arrow(3,1),not manipulated(1,1).
into(3,2,context(2,1)):-noncollideropen(3,context(2,1)),arrow(3,2),not manipulated(2,1).
into(2,1,context(2,1)):-noncollideropen(2,context(2,1)),arrow(2,1),not manipulated(1,1).
into(2,3,context(2,1)):-noncollideropen(2,context(2,1)),arrow(2,3),not manipulated(3,1).
latent(2,1):-latent(1,2).
latent(3,1):-latent(1,3).
latent(3,2):-latent(2,3).
latent(1,2):-latent(2,1).
latent(1,3):-latent(3,1).
latent(2,3):-latent(3,2).
into(1,2,context(1,1)):-noncollideropen(1,context(1,1)),latent(1,2),not manipulated(1,1),not manipulated(2,1).
into(1,3,context(1,1)):-noncollideropen(1,context(1,1)),latent(1,3),not manipulated(1,1),not manipulated(3,1).
into(2,3,context(1,1)):-noncollideropen(2,context(1,1)),latent(2,3),not manipulated(2,1),not manipulated(3,1).
into(2,1,context(1,1)):-noncollideropen(2,context(1,1)),latent(2,1),not manipulated(2,1),not manipulated(1,1).
into(3,1,context(1,1)):-noncollideropen(3,context(1,1)),latent(3,1),not manipulated(3,1),not manipulated(1,1).
into(3,2,context(1,1)):-noncollideropen(3,context(1,1)),latent(3,2),not manipulated(3,1),not manipulated(2,1).
into(1,2,context(2,1)):-noncollideropen(1,context(2,1)),latent(1,2),not manipulated(1,1),not manipulated(2,1).
into(1,3,context(2,1)):-noncollideropen(1,context(2,1)),latent(1,3),not manipulated(1,1),not manipulated(3,1).
into(3,1,context(2,1)):-noncollideropen(3,context(2,1)),latent(3,1),not manipulated(3,1),not manipulated(1,1).
into(3,2,context(2,1)):-noncollideropen(3,context(2,1)),latent(3,2),not manipulated(3,1),not manipulated(2,1).
into(2,3,context(2,1)):-noncollideropen(2,context(2,1)),latent(2,3),not manipulated(2,1),not manipulated(3,1).
into(2,1,context(2,1)):-noncollideropen(2,context(2,1)),latent(2,1),not manipulated(2,1),not manipulated(1,1).
collideropen(2,context(2,1)):-context(2,1),inside_set(2,2).
collideropen(1,context(1,1)):-context(1,1),selected(1,1).
collideropen(2,context(1,1)):-context(1,1),selected(2,1).
collideropen(3,context(1,1)):-context(1,1),selected(3,1).
collideropen(1,context(2,1)):-context(2,1),selected(1,1).
collideropen(3,context(2,1)):-context(2,1),selected(3,1).
outof(2,1,context(1,1)):-noncollideropen(1,context(1,1)),arrow(1,2),not manipulated(2,1).
outof(3,1,context(1,1)):-noncollideropen(1,context(1,1)),arrow(1,3),not manipulated(3,1).
outof(1,2,context(1,1)):-noncollideropen(2,context(1,1)),arrow(2,1),not manipulated(1,1).
outof(3,2,context(1,1)):-noncollideropen(2,context(1,1)),arrow(2,3),not manipulated(3,1).
outof(1,3,context(1,1)):-noncollideropen(3,context(1,1)),arrow(3,1),not manipulated(1,1).
outof(2,3,context(1,1)):-noncollideropen(3,context(1,1)),arrow(3,2),not manipulated(2,1).
outof(2,1,context(2,1)):-noncollideropen(1,context(2,1)),arrow(1,2),not manipulated(2,1).
outof(3,1,context(2,1)):-noncollideropen(1,context(2,1)),arrow(1,3),not manipulated(3,1).
outof(1,3,context(2,1)):-noncollideropen(3,context(2,1)),arrow(3,1),not manipulated(1,1).
outof(2,3,context(2,1)):-noncollideropen(3,context(2,1)),arrow(3,2),not manipulated(2,1).
outof(1,2,context(2,1)):-noncollideropen(2,context(2,1)),arrow(2,1),not manipulated(1,1).
outof(3,2,context(2,1)):-noncollideropen(2,context(2,1)),arrow(2,3),not manipulated(3,1).
outof(1,2,context(1,1)):-noncollideropen(2,context(1,1)),noncollideropen(1,context(1,1)),selected(2,1),selected(1,1).
outof(1,3,context(1,1)):-noncollideropen(3,context(1,1)),noncollideropen(1,context(1,1)),selected(3,1),selected(1,1).
outof(1,2,context(2,1)):-noncollideropen(2,context(2,1)),noncollideropen(1,context(2,1)),selected(2,1),selected(1,1).
outof(1,3,context(2,1)):-noncollideropen(3,context(2,1)),noncollideropen(1,context(2,1)),selected(3,1),selected(1,1).
outof(2,1,context(1,1)):-noncollideropen(1,context(1,1)),noncollideropen(2,context(1,1)),selected(1,1),selected(2,1).
outof(2,3,context(1,1)):-noncollideropen(3,context(1,1)),noncollideropen(2,context(1,1)),selected(3,1),selected(2,1).
outof(2,1,context(2,1)):-noncollideropen(1,context(2,1)),noncollideropen(2,context(2,1)),selected(1,1),selected(2,1).
outof(2,3,context(2,1)):-noncollideropen(3,context(2,1)),noncollideropen(2,context(2,1)),selected(3,1),selected(2,1).
outof(3,1,context(1,1)):-noncollideropen(1,context(1,1)),noncollideropen(3,context(1,1)),selected(1,1),selected(3,1).
outof(3,2,context(1,1)):-noncollideropen(2,context(1,1)),noncollideropen(3,context(1,1)),selected(2,1),selected(3,1).
outof(3,1,context(2,1)):-noncollideropen(1,context(2,1)),noncollideropen(3,context(2,1)),selected(1,1),selected(3,1).
outof(3,2,context(2,1)):-noncollideropen(2,context(2,1)),noncollideropen(3,context(2,1)),selected(2,1),selected(3,1).
outof(2,2,context(1,1)):-noncollideropen(1,context(1,1)),arrow(2,1),outof(2,1,context(1,1)),not manipulated(1,1).
outof(2,3,context(1,1)):-noncollideropen(1,context(1,1)),arrow(3,1),outof(2,1,context(1,1)),not manipulated(1,1).
outof(3,2,context(1,1)):-noncollideropen(1,context(1,1)),arrow(2,1),outof(3,1,context(1,1)),not manipulated(1,1).
outof(3,3,context(1,1)):-noncollideropen(1,context(1,1)),arrow(3,1),outof(3,1,context(1,1)),not manipulated(1,1).
outof(1,1,context(1,1)):-noncollideropen(2,context(1,1)),arrow(1,2),outof(1,2,context(1,1)),not manipulated(2,1).
outof(1,3,context(1,1)):-noncollideropen(2,context(1,1)),arrow(3,2),outof(1,2,context(1,1)),not manipulated(2,1).
outof(3,1,context(1,1)):-noncollideropen(2,context(1,1)),arrow(1,2),outof(3,2,context(1,1)),not manipulated(2,1).
outof(3,3,context(1,1)):-noncollideropen(2,context(1,1)),arrow(3,2),outof(3,2,context(1,1)),not manipulated(2,1).
outof(1,1,context(1,1)):-noncollideropen(3,context(1,1)),arrow(1,3),outof(1,3,context(1,1)),not manipulated(3,1).
outof(1,2,context(1,1)):-noncollideropen(3,context(1,1)),arrow(2,3),outof(1,3,context(1,1)),not manipulated(3,1).
outof(2,1,context(1,1)):-noncollideropen(3,context(1,1)),arrow(1,3),outof(2,3,context(1,1)),not manipulated(3,1).
outof(2,2,context(1,1)):-noncollideropen(3,context(1,1)),arrow(2,3),outof(2,3,context(1,1)),not manipulated(3,1).
outof(2,2,context(2,1)):-noncollideropen(1,context(2,1)),arrow(2,1),outof(2,1,context(2,1)),not manipulated(1,1).
outof(2,3,context(2,1)):-noncollideropen(1,context(2,1)),arrow(3,1),outof(2,1,context(2,1)),not manipulated(1,1).
outof(3,2,context(2,1)):-noncollideropen(1,context(2,1)),arrow(2,1),outof(3,1,context(2,1)),not manipulated(1,1).
outof(3,3,context(2,1)):-noncollideropen(1,context(2,1)),arrow(3,1),outof(3,1,context(2,1)),not manipulated(1,1).
outof(1,1,context(2,1)):-noncollideropen(3,context(2,1)),arrow(1,3),outof(1,3,context(2,1)),not manipulated(3,1).
outof(1,2,context(2,1)):-noncollideropen(3,context(2,1)),arrow(2,3),outof(1,3,context(2,1)),not manipulated(3,1).
outof(2,1,context(2,1)):-noncollideropen(3,context(2,1)),arrow(1,3),outof(2,3,context(2,1)),not manipulated(3,1).
outof(2,2,context(2,1)):-noncollideropen(3,context(2,1)),arrow(2,3),outof(2,3,context(2,1)),not manipulated(3,1).
outof(1,1,context(2,1)):-noncollideropen(2,context(2,1)),arrow(1,2),outof(1,2,context(2,1)),not manipulated(2,1).
outof(1,3,context(2,1)):-noncollideropen(2,context(2,1)),arrow(3,2),outof(1,2,context(2,1)),not manipulated(2,1).
outof(3,1,context(2,1)):-noncollideropen(2,context(2,1)),arrow(1,2),outof(3,2,context(2,1)),not manipulated(2,1).
outof(3,3,context(2,1)):-noncollideropen(2,context(2,1)),arrow(3,2),outof(3,2,context(2,1)),not manipulated(2,1).
into(2,2,context(1,1)):-noncollideropen(1,context(1,1)),latent(1,2),outof(2,1,context(1,1)),not manipulated(1,1),not manipulated(2,1).
into(2,3,context(1,1)):-noncollideropen(1,context(1,1)),latent(1,3),outof(2,1,context(1,1)),not manipulated(1,1),not manipulated(3,1).
into(3,2,context(1,1)):-noncollideropen(1,context(1,1)),latent(1,2),outof(3,1,context(1,1)),not manipulated(1,1),not manipulated(2,1).
into(3,3,context(1,1)):-noncollideropen(1,context(1,1)),latent(1,3),outof(3,1,context(1,1)),not manipulated(1,1),not manipulated(3,1).
into(1,3,context(1,1)):-noncollideropen(2,context(1,1)),latent(2,3),outof(1,2,context(1,1)),not manipulated(2,1),not manipulated(3,1).
into(1,1,context(1,1)):-noncollideropen(2,context(1,1)),latent(2,1),outof(1,2,context(1,1)),not manipulated(2,1),not manipulated(1,1).
into(3,3,context(1,1)):-noncollideropen(2,context(1,1)),latent(2,3),outof(3,2,context(1,1)),not manipulated(2,1),not manipulated(3,1).
into(3,1,context(1,1)):-noncollideropen(2,context(1,1)),latent(2,1),outof(3,2,context(1,1)),not manipulated(2,1),not manipulated(1,1).
into(1,1,context(1,1)):-noncollideropen(3,context(1,1)),latent(3,1),outof(1,3,context(1,1)),not manipulated(3,1),not manipulated(1,1).
into(1,2,context(1,1)):-noncollideropen(3,context(1,1)),latent(3,2),outof(1,3,context(1,1)),not manipulated(3,1),not manipulated(2,1).
into(2,1,context(1,1)):-noncollideropen(3,context(1,1)),latent(3,1),outof(2,3,context(1,1)),not manipulated(3,1),not manipulated(1,1).
into(2,2,context(1,1)):-noncollideropen(3,context(1,1)),latent(3,2),outof(2,3,context(1,1)),not manipulated(3,1),not manipulated(2,1).
into(2,2,context(2,1)):-noncollideropen(1,context(2,1)),latent(1,2),outof(2,1,context(2,1)),not manipulated(1,1),not manipulated(2,1).
into(2,3,context(2,1)):-noncollideropen(1,context(2,1)),latent(1,3),outof(2,1,context(2,1)),not manipulated(1,1),not manipulated(3,1).
into(3,2,context(2,1)):-noncollideropen(1,context(2,1)),latent(1,2),outof(3,1,context(2,1)),not manipulated(1,1),not manipulated(2,1).
into(3,3,context(2,1)):-noncollideropen(1,context(2,1)),latent(1,3),outof(3,1,context(2,1)),not manipulated(1,1),not manipulated(3,1).
into(1,1,context(2,1)):-noncollideropen(3,context(2,1)),latent(3,1),outof(1,3,context(2,1)),not manipulated(3,1),not manipulated(1,1).
into(1,2,context(2,1)):-noncollideropen(3,context(2,1)),latent(3,2),outof(1,3,context(2,1)),not manipulated(3,1),not manipulated(2,1).
into(2,1,context(2,1)):-noncollideropen(3,context(2,1)),latent(3,1),outof(2,3,context(2,1)),not manipulated(3,1),not manipulated(1,1).
into(2,2,context(2,1)):-noncollideropen(3,context(2,1)),latent(3,2),outof(2,3,context(2,1)),not manipulated(3,1),not manipulated(2,1).
into(1,3,context(2,1)):-noncollideropen(2,context(2,1)),latent(2,3),outof(1,2,context(2,1)),not manipulated(2,1),not manipulated(3,1).
into(1,1,context(2,1)):-noncollideropen(2,context(2,1)),latent(2,1),outof(1,2,context(2,1)),not manipulated(2,1),not manipulated(1,1).
into(3,3,context(2,1)):-noncollideropen(2,context(2,1)),latent(2,3),outof(3,2,context(2,1)),not manipulated(2,1),not manipulated(3,1).
into(3,1,context(2,1)):-noncollideropen(2,context(2,1)),latent(2,1),outof(3,2,context(2,1)),not manipulated(2,1),not manipulated(1,1).
outof(1,1,context(1,1)):-collideropen(2,context(1,1)),arrow(1,2),into(1,2,context(1,1)),not manipulated(2,1).
outof(1,3,context(1,1)):-collideropen(2,context(1,1)),arrow(3,2),into(1,2,context(1,1)),not manipulated(2,1).
outof(1,1,context(1,1)):-collideropen(3,context(1,1)),arrow(1,3),into(1,3,context(1,1)),not manipulated(3,1).
outof(1,2,context(1,1)):-collideropen(3,context(1,1)),arrow(2,3),into(1,3,context(1,1)),not manipulated(3,1).
outof(2,2,context(1,1)):-collideropen(1,context(1,1)),arrow(2,1),into(2,1,context(1,1)),not manipulated(1,1).
outof(2,3,context(1,1)):-collideropen(1,context(1,1)),arrow(3,1),into(2,1,context(1,1)),not manipulated(1,1).
outof(2,1,context(1,1)):-collideropen(3,context(1,1)),arrow(1,3),into(2,3,context(1,1)),not manipulated(3,1).
outof(2,2,context(1,1)):-collideropen(3,context(1,1)),arrow(2,3),into(2,3,context(1,1)),not manipulated(3,1).
outof(3,2,context(1,1)):-collideropen(1,context(1,1)),arrow(2,1),into(3,1,context(1,1)),not manipulated(1,1).
outof(3,3,context(1,1)):-collideropen(1,context(1,1)),arrow(3,1),into(3,1,context(1,1)),not manipulated(1,1).
outof(3,1,context(1,1)):-collideropen(2,context(1,1)),arrow(1,2),into(3,2,context(1,1)),not manipulated(2,1).
outof(3,3,context(1,1)):-collideropen(2,context(1,1)),arrow(3,2),into(3,2,context(1,1)),not manipulated(2,1).
outof(1,1,context(2,1)):-collideropen(2,context(2,1)),arrow(1,2),into(1,2,context(2,1)),not manipulated(2,1).
outof(1,3,context(2,1)):-collideropen(2,context(2,1)),arrow(3,2),into(1,2,context(2,1)),not manipulated(2,1).
outof(1,1,context(2,1)):-collideropen(3,context(2,1)),arrow(1,3),into(1,3,context(2,1)),not manipulated(3,1).
outof(1,2,context(2,1)):-collideropen(3,context(2,1)),arrow(2,3),into(1,3,context(2,1)),not manipulated(3,1).
outof(3,2,context(2,1)):-collideropen(1,context(2,1)),arrow(2,1),into(3,1,context(2,1)),not manipulated(1,1).
outof(3,3,context(2,1)):-collideropen(1,context(2,1)),arrow(3,1),into(3,1,context(2,1)),not manipulated(1,1).
outof(3,1,context(2,1)):-collideropen(2,context(2,1)),arrow(1,2),into(3,2,context(2,1)),not manipulated(2,1).
outof(3,3,context(2,1)):-collideropen(2,context(2,1)),arrow(3,2),into(3,2,context(2,1)),not manipulated(2,1).
outof(2,2,context(2,1)):-collideropen(1,context(2,1)),arrow(2,1),into(2,1,context(2,1)),not manipulated(1,1).
outof(2,3,context(2,1)):-collideropen(1,context(2,1)),arrow(3,1),into(2,1,context(2,1)),not manipulated(1,1).
outof(2,1,context(2,1)):-collideropen(3,context(2,1)),arrow(1,3),into(2,3,context(2,1)),not manipulated(3,1).
outof(2,2,context(2,1)):-collideropen(3,context(2,1)),arrow(2,3),into(2,3,context(2,1)),not manipulated(3,1).
into(2,2,context(1,1)):-noncollideropen(1,context(1,1)),arrow(1,2),outof(2,1,context(1,1)),not manipulated(2,1).
into(2,3,context(1,1)):-noncollideropen(1,context(1,1)),arrow(1,3),outof(2,1,context(1,1)),not manipulated(3,1).
into(3,2,context(1,1)):-noncollideropen(1,context(1,1)),arrow(1,2),outof(3,1,context(1,1)),not manipulated(2,1).
into(3,3,context(1,1)):-noncollideropen(1,context(1,1)),arrow(1,3),outof(3,1,context(1,1)),not manipulated(3,1).
into(1,1,context(1,1)):-noncollideropen(2,context(1,1)),arrow(2,1),outof(1,2,context(1,1)),not manipulated(1,1).
into(1,3,context(1,1)):-noncollideropen(2,context(1,1)),arrow(2,3),outof(1,2,context(1,1)),not manipulated(3,1).
into(3,1,context(1,1)):-noncollideropen(2,context(1,1)),arrow(2,1),outof(3,2,context(1,1)),not manipulated(1,1).
into(3,3,context(1,1)):-noncollideropen(2,context(1,1)),arrow(2,3),outof(3,2,context(1,1)),not manipulated(3,1).
into(1,1,context(1,1)):-noncollideropen(3,context(1,1)),arrow(3,1),outof(1,3,context(1,1)),not manipulated(1,1).
into(1,2,context(1,1)):-noncollideropen(3,context(1,1)),arrow(3,2),outof(1,3,context(1,1)),not manipulated(2,1).
into(2,1,context(1,1)):-noncollideropen(3,context(1,1)),arrow(3,1),outof(2,3,context(1,1)),not manipulated(1,1).
into(2,2,context(1,1)):-noncollideropen(3,context(1,1)),arrow(3,2),outof(2,3,context(1,1)),not manipulated(2,1).
into(2,2,context(2,1)):-noncollideropen(1,context(2,1)),arrow(1,2),outof(2,1,context(2,1)),not manipulated(2,1).
into(2,3,context(2,1)):-noncollideropen(1,context(2,1)),arrow(1,3),outof(2,1,context(2,1)),not manipulated(3,1).
into(3,2,context(2,1)):-noncollideropen(1,context(2,1)),arrow(1,2),outof(3,1,context(2,1)),not manipulated(2,1).
into(3,3,context(2,1)):-noncollideropen(1,context(2,1)),arrow(1,3),outof(3,1,context(2,1)),not manipulated(3,1).
into(1,1,context(2,1)):-noncollideropen(3,context(2,1)),arrow(3,1),outof(1,3,context(2,1)),not manipulated(1,1).
into(1,2,context(2,1)):-noncollideropen(3,context(2,1)),arrow(3,2),outof(1,3,context(2,1)),not manipulated(2,1).
into(2,1,context(2,1)):-noncollideropen(3,context(2,1)),arrow(3,1),outof(2,3,context(2,1)),not manipulated(1,1).
into(2,2,context(2,1)):-noncollideropen(3,context(2,1)),arrow(3,2),outof(2,3,context(2,1)),not manipulated(2,1).
into(1,1,context(2,1)):-noncollideropen(2,context(2,1)),arrow(2,1),outof(1,2,context(2,1)),not manipulated(1,1).
into(1,3,context(2,1)):-noncollideropen(2,context(2,1)),arrow(2,3),outof(1,2,context(2,1)),not manipulated(3,1).
into(3,1,context(2,1)):-noncollideropen(2,context(2,1)),arrow(2,1),outof(3,2,context(2,1)),not manipulated(1,1).
into(3,3,context(2,1)):-noncollideropen(2,context(2,1)),arrow(2,3),outof(3,2,context(2,1)),not manipulated(3,1).
into(1,3,context(1,1)):-collideropen(2,context(1,1)),latent(2,3),into(1,2,context(1,1)),not manipulated(2,1),not manipulated(3,1).
into(1,1,context(1,1)):-collideropen(2,context(1,1)),latent(2,1),into(1,2,context(1,1)),not manipulated(2,1),not manipulated(1,1).
into(1,1,context(1,1)):-collideropen(3,context(1,1)),latent(3,1),into(1,3,context(1,1)),not manipulated(3,1),not manipulated(1,1).
into(1,2,context(1,1)):-collideropen(3,context(1,1)),latent(3,2),into(1,3,context(1,1)),not manipulated(3,1),not manipulated(2,1).
into(2,2,context(1,1)):-collideropen(1,context(1,1)),latent(1,2),into(2,1,context(1,1)),not manipulated(1,1),not manipulated(2,1).
into(2,3,context(1,1)):-collideropen(1,context(1,1)),latent(1,3),into(2,1,context(1,1)),not manipulated(1,1),not manipulated(3,1).
into(2,1,context(1,1)):-collideropen(3,context(1,1)),latent(3,1),into(2,3,context(1,1)),not manipulated(3,1),not manipulated(1,1).
into(2,2,context(1,1)):-collideropen(3,context(1,1)),latent(3,2),into(2,3,context(1,1)),not manipulated(3,1),not manipulated(2,1).
into(3,2,context(1,1)):-collideropen(1,context(1,1)),latent(1,2),into(3,1,context(1,1)),not manipulated(1,1),not manipulated(2,1).
into(3,3,context(1,1)):-collideropen(1,context(1,1)),latent(1,3),into(3,1,context(1,1)),not manipulated(1,1),not manipulated(3,1).
into(3,3,context(1,1)):-collideropen(2,context(1,1)),latent(2,3),into(3,2,context(1,1)),not manipulated(2,1),not manipulated(3,1).
into(3,1,context(1,1)):-collideropen(2,context(1,1)),latent(2,1),into(3,2,context(1,1)),not manipulated(2,1),not manipulated(1,1).
into(1,3,context(2,1)):-collideropen(2,context(2,1)),latent(2,3),into(1,2,context(2,1)),not manipulated(2,1),not manipulated(3,1).
into(1,1,context(2,1)):-collideropen(2,context(2,1)),latent(2,1),into(1,2,context(2,1)),not manipulated(2,1),not manipulated(1,1).
into(1,1,context(2,1)):-collideropen(3,context(2,1)),latent(3,1),into(1,3,context(2,1)),not manipulated(3,1),not manipulated(1,1).
into(1,2,context(2,1)):-collideropen(3,context(2,1)),latent(3,2),into(1,3,context(2,1)),not manipulated(3,1),not manipulated(2,1).
into(3,2,context(2,1)):-collideropen(1,context(2,1)),latent(1,2),into(3,1,context(2,1)),not manipulated(1,1),not manipulated(2,1).
into(3,3,context(2,1)):-collideropen(1,context(2,1)),latent(1,3),into(3,1,context(2,1)),not manipulated(1,1),not manipulated(3,1).
into(3,3,context(2,1)):-collideropen(2,context(2,1)),latent(2,3),into(3,2,context(2,1)),not manipulated(2,1),not manipulated(3,1).
into(3,1,context(2,1)):-collideropen(2,context(2,1)),latent(2,1),into(3,2,context(2,1)),not manipulated(2,1),not manipulated(1,1).
into(2,2,context(2,1)):-collideropen(1,context(2,1)),latent(1,2),into(2,1,context(2,1)),not manipulated(1,1),not manipulated(2,1).
into(2,3,context(2,1)):-collideropen(1,context(2,1)),latent(1,3),into(2,1,context(2,1)),not manipulated(1,1),not manipulated(3,1).
into(2,1,context(2,1)):-collideropen(3,context(2,1)),latent(3,1),into(2,3,context(2,1)),not manipulated(3,1),not manipulated(1,1).
into(2,2,context(2,1)):-collideropen(3,context(2,1)),latent(3,2),into(2,3,context(2,1)),not manipulated(3,1),not manipulated(2,1).
into(1,1,context(1,1)):-noncollideropen(2,context(1,1)),arrow(2,1),into(1,2,context(1,1)),not manipulated(2,1),not manipulated(1,1).
into(1,3,context(1,1)):-noncollideropen(2,context(1,1)),arrow(2,3),into(1,2,context(1,1)),not manipulated(2,1),not manipulated(3,1).
into(1,1,context(1,1)):-noncollideropen(3,context(1,1)),arrow(3,1),into(1,3,context(1,1)),not manipulated(3,1),not manipulated(1,1).
into(1,2,context(1,1)):-noncollideropen(3,context(1,1)),arrow(3,2),into(1,3,context(1,1)),not manipulated(3,1),not manipulated(2,1).
into(2,2,context(1,1)):-noncollideropen(1,context(1,1)),arrow(1,2),into(2,1,context(1,1)),not manipulated(1,1),not manipulated(2,1).
into(2,3,context(1,1)):-noncollideropen(1,context(1,1)),arrow(1,3),into(2,1,context(1,1)),not manipulated(1,1),not manipulated(3,1).
into(2,1,context(1,1)):-noncollideropen(3,context(1,1)),arrow(3,1),into(2,3,context(1,1)),not manipulated(3,1),not manipulated(1,1).
into(2,2,context(1,1)):-noncollideropen(3,context(1,1)),arrow(3,2),into(2,3,context(1,1)),not manipulated(3,1),not manipulated(2,1).
into(3,2,context(1,1)):-noncollideropen(1,context(1,1)),arrow(1,2),into(3,1,context(1,1)),not manipulated(1,1),not manipulated(2,1).
into(3,3,context(1,1)):-noncollideropen(1,context(1,1)),arrow(1,3),into(3,1,context(1,1)),not manipulated(1,1),not manipulated(3,1).
into(3,1,context(1,1)):-noncollideropen(2,context(1,1)),arrow(2,1),into(3,2,context(1,1)),not manipulated(2,1),not manipulated(1,1).
into(3,3,context(1,1)):-noncollideropen(2,context(1,1)),arrow(2,3),into(3,2,context(1,1)),not manipulated(2,1),not manipulated(3,1).
into(1,1,context(2,1)):-noncollideropen(2,context(2,1)),arrow(2,1),into(1,2,context(2,1)),not manipulated(2,1),not manipulated(1,1).
into(1,3,context(2,1)):-noncollideropen(2,context(2,1)),arrow(2,3),into(1,2,context(2,1)),not manipulated(2,1),not manipulated(3,1).
into(1,1,context(2,1)):-noncollideropen(3,context(2,1)),arrow(3,1),into(1,3,context(2,1)),not manipulated(3,1),not manipulated(1,1).
into(1,2,context(2,1)):-noncollideropen(3,context(2,1)),arrow(3,2),into(1,3,context(2,1)),not manipulated(3,1),not manipulated(2,1).
into(3,2,context(2,1)):-noncollideropen(1,context(2,1)),arrow(1,2),into(3,1,context(2,1)),not manipulated(1,1),not manipulated(2,1).
into(3,3,context(2,1)):-noncollideropen(1,context(2,1)),arrow(1,3),into(3,1,context(2,1)),not manipulated(1,1),not manipulated(3,1).
into(3,1,context(2,1)):-noncollideropen(2,context(2,1)),arrow(2,1),into(3,2,context(2,1)),not manipulated(2,1),not manipulated(1,1).
into(3,3,context(2,1)):-noncollideropen(2,context(2,1)),arrow(2,3),into(3,2,context(2,1)),not manipulated(2,1),not manipulated(3,1).
into(2,2,context(2,1)):-noncollideropen(1,context(2,1)),arrow(1,2),into(2,1,context(2,1)),not manipulated(1,1),not manipulated(2,1).
into(2,3,context(2,1)):-noncollideropen(1,context(2,1)),arrow(1,3),into(2,1,context(2,1)),not manipulated(1,1),not manipulated(3,1).
into(2,1,context(2,1)):-noncollideropen(3,context(2,1)),arrow(3,1),into(2,3,context(2,1)),not manipulated(3,1),not manipulated(1,1).
into(2,2,context(2,1)):-noncollideropen(3,context(2,1)),arrow(3,2),into(2,3,context(2,1)),not manipulated(3,1),not manipulated(2,1).
outof(2,1,context(1,1)):-noncollideropen(2,context(1,1)),arrow(1,2),outof(2,2,context(1,1)),not manipulated(2,1).
outof(2,3,context(1,1)):-noncollideropen(2,context(1,1)),arrow(3,2),outof(2,2,context(1,1)),not manipulated(2,1).
outof(3,1,context(1,1)):-noncollideropen(3,context(1,1)),arrow(1,3),outof(3,3,context(1,1)),not manipulated(3,1).
outof(3,2,context(1,1)):-noncollideropen(3,context(1,1)),arrow(2,3),outof(3,3,context(1,1)),not manipulated(3,1).
outof(1,2,context(1,1)):-noncollideropen(1,context(1,1)),arrow(2,1),outof(1,1,context(1,1)),not manipulated(1,1).
outof(1,3,context(1,1)):-noncollideropen(1,context(1,1)),arrow(3,1),outof(1,1,context(1,1)),not manipulated(1,1).
outof(2,1,context(2,1)):-noncollideropen(2,context(2,1)),arrow(1,2),outof(2,2,context(2,1)),not manipulated(2,1).
outof(2,3,context(2,1)):-noncollideropen(2,context(2,1)),arrow(3,2),outof(2,2,context(2,1)),not manipulated(2,1).
outof(3,1,context(2,1)):-noncollideropen(3,context(2,1)),arrow(1,3),outof(3,3,context(2,1)),not manipulated(3,1).
outof(3,2,context(2,1)):-noncollideropen(3,context(2,1)),arrow(2,3),outof(3,3,context(2,1)),not manipulated(3,1).
outof(1,2,context(2,1)):-noncollideropen(1,context(2,1)),arrow(2,1),outof(1,1,context(2,1)),not manipulated(1,1).
outof(1,3,context(2,1)):-noncollideropen(1,context(2,1)),arrow(3,1),outof(1,1,context(2,1)),not manipulated(1,1).
into(2,3,context(1,1)):-noncollideropen(2,context(1,1)),latent(2,3),outof(2,2,context(1,1)),not manipulated(2,1),not manipulated(3,1).
into(2,1,context(1,1)):-noncollideropen(2,context(1,1)),latent(2,1),outof(2,2,context(1,1)),not manipulated(2,1),not manipulated(1,1).
into(3,1,context(1,1)):-noncollideropen(3,context(1,1)),latent(3,1),outof(3,3,context(1,1)),not manipulated(3,1),not manipulated(1,1).
into(3,2,context(1,1)):-noncollideropen(3,context(1,1)),latent(3,2),outof(3,3,context(1,1)),not manipulated(3,1),not manipulated(2,1).
into(1,2,context(1,1)):-noncollideropen(1,context(1,1)),latent(1,2),outof(1,1,context(1,1)),not manipulated(1,1),not manipulated(2,1).
into(1,3,context(1,1)):-noncollideropen(1,context(1,1)),latent(1,3),outof(1,1,context(1,1)),not manipulated(1,1),not manipulated(3,1).
into(2,3,context(2,1)):-noncollideropen(2,context(2,1)),latent(2,3),outof(2,2,context(2,1)),not manipulated(2,1),not manipulated(3,1).
into(2,1,context(2,1)):-noncollideropen(2,context(2,1)),latent(2,1),outof(2,2,context(2,1)),not manipulated(2,1),not manipulated(1,1).
into(3,1,context(2,1)):-noncollideropen(3,context(2,1)),latent(3,1),outof(3,3,context(2,1)),not manipulated(3,1),not manipulated(1,1).
into(3,2,context(2,1)):-noncollideropen(3,context(2,1)),latent(3,2),outof(3,3,context(2,1)),not manipulated(3,1),not manipulated(2,1).
into(1,2,context(2,1)):-noncollideropen(1,context(2,1)),latent(1,2),outof(1,1,context(2,1)),not manipulated(1,1),not manipulated(2,1).
into(1,3,context(2,1)):-noncollideropen(1,context(2,1)),latent(1,3),outof(1,1,context(2,1)),not manipulated(1,1),not manipulated(3,1).
into(2,1,context(1,1)):-noncollideropen(2,context(1,1)),arrow(2,1),outof(2,2,context(1,1)),not manipulated(1,1).
into(2,3,context(1,1)):-noncollideropen(2,context(1,1)),arrow(2,3),outof(2,2,context(1,1)),not manipulated(3,1).
into(3,1,context(1,1)):-noncollideropen(3,context(1,1)),arrow(3,1),outof(3,3,context(1,1)),not manipulated(1,1).
into(3,2,context(1,1)):-noncollideropen(3,context(1,1)),arrow(3,2),outof(3,3,context(1,1)),not manipulated(2,1).
into(1,2,context(1,1)):-noncollideropen(1,context(1,1)),arrow(1,2),outof(1,1,context(1,1)),not manipulated(2,1).
into(1,3,context(1,1)):-noncollideropen(1,context(1,1)),arrow(1,3),outof(1,1,context(1,1)),not manipulated(3,1).
into(2,1,context(2,1)):-noncollideropen(2,context(2,1)),arrow(2,1),outof(2,2,context(2,1)),not manipulated(1,1).
into(2,3,context(2,1)):-noncollideropen(2,context(2,1)),arrow(2,3),outof(2,2,context(2,1)),not manipulated(3,1).
into(3,1,context(2,1)):-noncollideropen(3,context(2,1)),arrow(3,1),outof(3,3,context(2,1)),not manipulated(1,1).
into(3,2,context(2,1)):-noncollideropen(3,context(2,1)),arrow(3,2),outof(3,3,context(2,1)),not manipulated(2,1).
into(1,2,context(2,1)):-noncollideropen(1,context(2,1)),arrow(1,2),outof(1,1,context(2,1)),not manipulated(2,1).
into(1,3,context(2,1)):-noncollideropen(1,context(2,1)),arrow(1,3),outof(1,1,context(2,1)),not manipulated(3,1).
outof(2,1,context(1,1)):-collideropen(2,context(1,1)),arrow(1,2),into(2,2,context(1,1)),not manipulated(2,1).
outof(2,3,context(1,1)):-collideropen(2,context(1,1)),arrow(3,2),into(2,2,context(1,1)),not manipulated(2,1).
outof(3,1,context(1,1)):-collideropen(3,context(1,1)),arrow(1,3),into(3,3,context(1,1)),not manipulated(3,1).
outof(3,2,context(1,1)):-collideropen(3,context(1,1)),arrow(2,3),into(3,3,context(1,1)),not manipulated(3,1).
outof(1,2,context(1,1)):-collideropen(1,context(1,1)),arrow(2,1),into(1,1,context(1,1)),not manipulated(1,1).
outof(1,3,context(1,1)):-collideropen(1,context(1,1)),arrow(3,1),into(1,1,context(1,1)),not manipulated(1,1).
outof(2,1,context(2,1)):-collideropen(2,context(2,1)),arrow(1,2),into(2,2,context(2,1)),not manipulated(2,1).
outof(2,3,context(2,1)):-collideropen(2,context(2,1)),arrow(3,2),into(2,2,context(2,1)),not manipulated(2,1).
outof(3,1,context(2,1)):-collideropen(3,context(2,1)),arrow(1,3),into(3,3,context(2,1)),not manipulated(3,1).
outof(3,2,context(2,1)):-collideropen(3,context(2,1)),arrow(2,3),into(3,3,context(2,1)),not manipulated(3,1).
outof(1,2,context(2,1)):-collideropen(1,context(2,1)),arrow(2,1),into(1,1,context(2,1)),not manipulated(1,1).
outof(1,3,context(2,1)):-collideropen(1,context(2,1)),arrow(3,1),into(1,1,context(2,1)),not manipulated(1,1).
into(2,3,context(1,1)):-collideropen(2,context(1,1)),latent(2,3),into(2,2,context(1,1)),not manipulated(2,1),not manipulated(3,1).
into(2,1,context(1,1)):-collideropen(2,context(1,1)),latent(2,1),into(2,2,context(1,1)),not manipulated(2,1),not manipulated(1,1).
into(3,1,context(1,1)):-collideropen(3,context(1,1)),latent(3,1),into(3,3,context(1,1)),not manipulated(3,1),not manipulated(1,1).
into(3,2,context(1,1)):-collideropen(3,context(1,1)),latent(3,2),into(3,3,context(1,1)),not manipulated(3,1),not manipulated(2,1).
into(1,2,context(1,1)):-collideropen(1,context(1,1)),latent(1,2),into(1,1,context(1,1)),not manipulated(1,1),not manipulated(2,1).
into(1,3,context(1,1)):-collideropen(1,context(1,1)),latent(1,3),into(1,1,context(1,1)),not manipulated(1,1),not manipulated(3,1).
into(2,3,context(2,1)):-collideropen(2,context(2,1)),latent(2,3),into(2,2,context(2,1)),not manipulated(2,1),not manipulated(3,1).
into(2,1,context(2,1)):-collideropen(2,context(2,1)),latent(2,1),into(2,2,context(2,1)),not manipulated(2,1),not manipulated(1,1).
into(3,1,context(2,1)):-collideropen(3,context(2,1)),latent(3,1),into(3,3,context(2,1)),not manipulated(3,1),not manipulated(1,1).
into(3,2,context(2,1)):-collideropen(3,context(2,1)),latent(3,2),into(3,3,context(2,1)),not manipulated(3,1),not manipulated(2,1).
into(1,2,context(2,1)):-collideropen(1,context(2,1)),latent(1,2),into(1,1,context(2,1)),not manipulated(1,1),not manipulated(2,1).
into(1,3,context(2,1)):-collideropen(1,context(2,1)),latent(1,3),into(1,1,context(2,1)),not manipulated(1,1),not manipulated(3,1).
into(2,1,context(1,1)):-noncollideropen(2,context(1,1)),arrow(2,1),into(2,2,context(1,1)),not manipulated(2,1),not manipulated(1,1).
into(2,3,context(1,1)):-noncollideropen(2,context(1,1)),arrow(2,3),into(2,2,context(1,1)),not manipulated(2,1),not manipulated(3,1).
into(3,1,context(1,1)):-noncollideropen(3,context(1,1)),arrow(3,1),into(3,3,context(1,1)),not manipulated(3,1),not manipulated(1,1).
into(3,2,context(1,1)):-noncollideropen(3,context(1,1)),arrow(3,2),into(3,3,context(1,1)),not manipulated(3,1),not manipulated(2,1).
into(1,2,context(1,1)):-noncollideropen(1,context(1,1)),arrow(1,2),into(1,1,context(1,1)),not manipulated(1,1),not manipulated(2,1).
into(1,3,context(1,1)):-noncollideropen(1,context(1,1)),arrow(1,3),into(1,1,context(1,1)),not manipulated(1,1),not manipulated(3,1).
into(2,1,context(2,1)):-noncollideropen(2,context(2,1)),arrow(2,1),into(2,2,context(2,1)),not manipulated(2,1),not manipulated(1,1).
into(2,3,context(2,1)):-noncollideropen(2,context(2,1)),arrow(2,3),into(2,2,context(2,1)),not manipulated(2,1),not manipulated(3,1).
into(3,1,context(2,1)):-noncollideropen(3,context(2,1)),arrow(3,1),into(3,3,context(2,1)),not manipulated(3,1),not manipulated(1,1).
into(3,2,context(2,1)):-noncollideropen(3,context(2,1)),arrow(3,2),into(3,3,context(2,1)),not manipulated(3,1),not manipulated(2,1).
into(1,2,context(2,1)):-noncollideropen(1,context(2,1)),arrow(1,2),into(1,1,context(2,1)),not manipulated(1,1),not manipulated(2,1).
into(1,3,context(2,1)):-noncollideropen(1,context(2,1)),arrow(1,3),into(1,1,context(2,1)),not manipulated(1,1),not manipulated(3,1).
dconn(1,2,context(1,1)):-into(1,2,context(1,1)),outside_set(2,1),outside_set(1,1).
dconn(1,3,context(1,1)):-into(1,3,context(1,1)),outside_set(3,1),outside_set(1,1).
dconn(2,3,context(1,1)):-into(2,3,context(1,1)),outside_set(3,1),outside_set(2,1).
dconn(1,3,context(2,1)):-into(1,3,context(2,1)),outside_set(3,2),outside_set(1,2).
dconn(1,2,context(1,1)):-outof(1,2,context(1,1)),outside_set(2,1),outside_set(1,1).
dconn(1,3,context(1,1)):-outof(1,3,context(1,1)),outside_set(3,1),outside_set(1,1).
dconn(2,3,context(1,1)):-outof(2,3,context(1,1)),outside_set(3,1),outside_set(2,1).
dconn(1,3,context(2,1)):-outof(1,3,context(2,1)),outside_set(3,2),outside_set(1,2).
:-not dconn(1,2,context(1,1)).
:-not dconn(2,3,context(1,1)).
:-not dconn(1,3,context(2,1)).
:-dconn(1,3,context(1,1)).
:-arrow(1,2),arrow(2,1).
:-arrow(2,1),arrow(1,2).
:-arrow(3,1),arrow(1,3).
:-arrow(3,2),arrow(2,3).
:-arrow(1,3),arrow(3,1).
:-arrow(2,3),arrow(3,2).
notarrow(2,1):-node(1),node(2),not arrow(2,1).
notarrow(3,1):-node(1),node(3),not arrow(3,1).
notarrow(3,2):-node(2),node(3),not arrow(3,2).
notarrow(1,3):-node(3),node(1),not arrow(1,3).
notarrow(2,3):-node(3),node(2),not arrow(2,3).
ancestor(1,2):-arrow(1,2).
ancestor(2,1):-arrow(2,1).
ancestor(3,1):-arrow(3,1).
ancestor(3,2):-arrow(3,2).
ancestor(1,3):-arrow(1,3).
ancestor(2,3):-arrow(2,3).
ancestor(3,2):-ancestor(1,2),ancestor(3,1).
ancestor(3,1):-ancestor(2,1),ancestor(3,2).
ancestor(2,1):-ancestor(3,1),ancestor(2,3).
ancestor(2,3):-ancestor(1,3),ancestor(2,1).
ancestor(1,3):-ancestor(2,3),ancestor(1,2).
:-arrow(1,2),ancestor(2,1).
:-arrow(2,1),ancestor(1,2).
:-arrow(3,1),ancestor(1,3).
:-arrow(3,2),ancestor(2,3).
:-arrow(1,3),ancestor(3,1).
:-arrow(2,3),ancestor(3,2).
notancestor(2,1):-node(1),node(2),not ancestor(2,1).
notancestor(3,1):-node(1),node(3),not ancestor(3,1).
notancestor(3,2):-node(2),node(3),not ancestor(3,2).
notancestor(1,3):-node(3),node(1),not ancestor(1,3).
notancestor(2,3):-node(3),node(2),not ancestor(2,3).
notlatent(1,2):-node(2),node(1),not latent(1,2).
notlatent(1,3):-node(3),node(1),not latent(1,3).
notlatent(2,3):-node(3),node(2),not latent(2,3).
notselected(1,1):-node(1),dataset(1),not selected(1,1).
notselected(2,1):-node(2),dataset(1),not selected(2,1).
notselected(3,1):-node(3),dataset(1),not selected(3,1).
notmanipulated(1,1):-node(1),dataset(1),not manipulated(1,1).
notmanipulated(2,1):-node(2),dataset(1),not manipulated(2,1).
notmanipulated(3,1):-node(3),dataset(1),not manipulated(3,1).
:-notmanipulated(1,1),manipulated(1,1).
:-notmanipulated(2,1),manipulated(2,1).
:-notmanipulated(3,1),manipulated(3,1).
noerror(1,1):-dataset(1),node(1),not haserror(1,1).
noerror(2,1):-dataset(1),node(2),not haserror(2,1).
noerror(3,1):-dataset(1),node(3),not haserror(3,1).
notlatent(1,2):-node(2),node(1),not latent(1,2).
notlatent(1,3):-node(3),node(1),not latent(1,3).
notlatent(2,3):-node(3),node(2),not latent(2,3).
#count{0,haserror(1,1):haserror(1,1)}:-dataset(1),node(1).
#count{0,haserror(2,1):haserror(2,1)}:-dataset(1),node(2).
#count{0,haserror(3,1):haserror(3,1)}:-dataset(1),node(3).
#count{0,arrow(2,1):arrow(2,1)}:-node(1),node(2).
#count{0,arrow(3,1):arrow(3,1)}:-node(1),node(3).
#count{0,arrow(1,2):arrow(1,2)}:-node(2),node(1).
#count{0,arrow(3,2):arrow(3,2)}:-node(2),node(3).
#count{0,arrow(1,3):arrow(1,3)}:-node(3),node(1).
#count{0,arrow(2,3):arrow(2,3)}:-node(3),node(2).
#count{0,manipulated(1,1):manipulated(1,1)}:-dataset(1),node(1).
#count{0,manipulated(2,1):manipulated(2,1)}:-dataset(1),node(2).
#count{0,manipulated(3,1):manipulated(3,1)}:-dataset(1),node(3).
#count{0,latent(1,2):latent(1,2)}:-node(2),node(1).
#count{0,latent(1,3):latent(1,3)}:-node(3),node(1).
#count{0,latent(2,3):latent(2,3)}:-node(3),node(2).
#count{0,selected(1,1):selected(1,1)}:-dataset(1),node(1).
#count{0,selected(2,1):selected(2,1)}:-dataset(1),node(2).
#count{0,selected(3,1):selected(3,1)}:-dataset(1),node(3).
#show ancestor/2.
#show arrow/2.
#show collideropen/2.
#show haserror/2.
#show latent/2.
#show manipulated/2.
#show noerror/2.
#show noncollideropen/2.
#show notancestor/2.
#show notarrow/2.
#show notlatent/2.
#show notmanipulated/2.
#show notselected/2.
#show outside_set/2.
#show selected/2.
#show dconn/3.
#show into/3.
#show outof/3.
