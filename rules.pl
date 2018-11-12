% ?- X = 0, Y = 0.

attribute(type, [cinema,spa,restaurant]).
attribute(distance, [far,near,in_hotel]).
attribute(food, [mexican,vegan,vegetarian]).

             
poi(cinema1, 
    [cinema],                   %type
    [far],                      %distance
    [credit_card,cash],         %payments
    [cheese],
    []                    
).

poi(restaurant1,
    [restaurant],
    [near],
    [credit_card,cash],
    [mexican,vegan,vegetarian],
    []).

poi(spa1,
    [spa],
    [in_hotel],
    [cash],
    [champagne,whiskey, vodka, bourbon]).

drink(X, Y) :- poi(Y,_,_,_,_,T), contains(X,T).
food(X, Y) :- poi(Y,_,_,_,T,_), contains(X,T).
payment(X, Y) :- poi(Y,_,_,T,_,_), contains(X,T).
distance(X, Y) :- poi(Y,_,T,_,_,_), contains(X,T).
type(X, Y) :- poi(Y,T,_,_,_,_), contains(X,T).

cheap_cheese(Y) :- food(cheese,Y), payment(cash,Y). 

contains(Item,[Item|_]).  /* is my target item on the list */
contains(Item,[_|Tail]) :- contains(Item,Tail).

activity(drinking, Y) :- drink(_, Y).
activity(eating, Y) :- food(_, Y).
activity(resting, Y) :- type(spa, Y).
activity(sightseeing, Y) :- type(museum, Y).
activity(sightseeing, Y) :- type(art_gallery, Y).

%adjcetive(fun, Y) :- activity(drinking, Y), price(cheap, Y).
adjective(fun, Y) :- activity(entertainment, Y).
%adjective(snobbish, Y) :- drink(wine, Y), price(expensive, Y).
adjective(snobbish, Y) :- activity(sightseeing, Y). 
              
% drink(wine, Y) :- drink(red_wine, Y).
% drink(wine, Y) :- drink(white_wine, Y).

restaurant(mexican, Y) :- type(restaurant, Y),
                       food(mexican, Y).

distance(X1,Y1,X2,Y2, R) :- R is sqrt((X2-X1)^2 + (Y2-Y1)^2).

% location(X,Y).
% far(X1,Y1,X2,Y2) :- (dist1) - dist2 > 100.
