has_attribute(AttributeName,Value,Place):- poi(Place,List), member(AttributeName,List),compound(AttributeName),AttributeName =.. [_Functor|ListWithinList],member(Values,ListWithinList),member(Value,Values).

poi(cinema1,[type([cinema]),distance([far]),payment([credit_card,cash]),food([cheese])]).
poi(restaurant1,[type([restaurant]),distance([near]),payment([cash]),food([mexican,vegan,vegetarian])]).
poi(spa1,[type([spa]),distance([in_hotel]),payment([cash]),drink([champagne,whiskey, vodka, bourbon])]).



drink(X,Y) :- has_attribute(drink(_),X,Y).
food(X,Y) :- has_attribute(food(_),X,Y).
payment(X,Y) :- has_attribute(payment(_),X,Y).
distance(X,Y) :- has_attribute(distance(_),X,Y).
type(X,Y) :- has_attribute(type(_),X,Y).
cheap_cheese(Y) :- food(cheese,Y), payment(cash,Y). 


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
