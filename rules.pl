has_attribute(AttributeName,Value,Place):- 
    poi(Place,List), 
    member(AttributeName,List),
    compound(AttributeName),
    AttributeName =.. [_Functor|ListWithinList],member(Values,ListWithinList),member(Value,Values).

poi(cinema1,
[
    type([cinema]),
    distance([far]),
    payment([credit_card, cash]),
    food([cheese]),
    price([cheap])
]).

poi(restaurant1,
[
    type([restaurant]),
    distance([near]),
    payment([cash]),
    food([mexican,vegan,vegetarian]),
    price([cheap])
]).

poi(spa1,
[
    type([spa]),
    distance([in_hotel]),
    payment([cash]),
    drink([champagne,whiskey, vodka, bourbon]),
    price([expensive])
]).

poi(amarylis,
    [
        type([restaurant]),
        distance([near]),
        price([expensive]),
        accessibility([wheelchair]),
        payment([cash,card]),
        ambiance([cosy]),
        food([european, modern]),
        amenity([fireplace,wifi]),
        drink([beer,wine])
    ]).

poi(eco_plant,
    [
        type([spa]),
        distance([far]),
        price([expensive]),
        payment([cash,card]),
        ambiance([cosy]),
        amenity([jakuzzi,sauna])
    ]).

poi(bagatela,
    [
        type([theater]),
        distance([far]),
        price([moderate]),
        accessibility([wheelchair]),
        payment([cash,card])
    ]).

poi(manggha,
    [
        type([museum,cafe]),
        distance([far]),
        price([cheap]),
        accessibility([wheelchair]),
        payment([cash,card]),
        food(dessert,breakfast),
        drink(tea),
        theme([japanese])
    ]).

poi(camelot,
    [
        type([cafe]),
        distance([not_far]),
        price([cheap]),
        accessibility([wheelchair]),
        payment([cash,card]),
        ambiance([cosy]),
        food([cake, dessert, breakfast]),
        amenity([wifi]),
        drink([coffee,tea, beer, drinks])
    ]).

poi(m22,
    [
        type([restaurant]),
        distance([not_far]),
        price([moderate]),
        payment([cash,card]),
        ambiance([casual]),
        food([burger]),
        drink([beer,soda])
    ]).

poi(warsztat-cafe-restaurant,
[
    type([cafe,restaurant]),
    distance([near]),
    accessibility([]),
    payment([cash,card]),
    ambiance([classical]),
    food([sandwich, pizza,italian,traditional]),
    amenity([wifi]),
    drink([coffee,beer,wine,vodka,rum,whisky,gin,tea,coffe,coctail]), 
    price([cheap])
]).

poi(museum-galicja,
[
    type([museum]),
    distance([not_far]),
    payment([cash,card]),
    ambiance([classical]),
    price([moderate]),
    theme([jewish, holocaust])
]).

poi(locked-up,
[
    type([excape_room]),
    distance([not_far]),
    payment([cash,card]),
    price([moderate]),
    theme([mars,nuclear,oriental,acient_mystery])
]).

poi(etnographic-museum,
[
    type([museum]),
    distance([not_far]),
    payment([cash,card]),
    price([cheap]),
    theme([etnographic])
]).
poi(museum-municipal-engineering,
[
    type([museum]),
    distance([not_far]),
    payment([cash,card]),
    price([cheap]),
    theme([industrail])
]).

poi(warsztat-cafe-restaurant,
[
    type([cafe,restaurant]),
    distance([near]),
    payment([cash,card]),
    ambiance([kids_friendly,cosy]),
    food([sandwich, pizza,italian,traditional]),
    amenity([wifi]),
    drink([coffee,tea,lemonade,juice,rum,whisky,gin,tea,coffe,coctail]), 
    price([cheap])
]).

drink(X,Y) :- has_attribute(drink(_),X,Y).
food(X,Y) :- has_attribute(food(_),X,Y).
payment(X,Y) :- has_attribute(payment(_),X,Y).
distance(X,Y) :- has_attribute(distance(_),X,Y).%in_hotel,near,not_far,far
type(X,Y) :- has_attribute(type(_),X,Y).
price(X,Y) :- has_attribute(price(_),X,Y).%cheap,moderate,expensive
accessibility(X,Y) :- has_attribute(accessibility(_),X,Y).
amenity(X,Y) :- has_attribute(amenity(_),X,Y).
ambiance(X,Y) :- has_attribute(ambiance(_),X,Y).
theme(X,Y) :- has_attribute(theme(_),X,Y).


activity(drinking, Y) :- drink(_, Y).
activity(eating, Y) :- food(_, Y).
activity(resting, Y) :- type(spa, Y).
activity(sightseeing, Y) :- type(museum, Y).
activity(sightseeing, Y) :- type(art_gallery, Y).

adjcetive(fun, Y) :- activity(drinking, Y), price(cheap, Y).
adjective(fun, Y) :- activity(entertainment, Y).
adjective(snobbish, Y) :- drink(wine, Y), price(expensive, Y).
adjective(snobbish, Y) :- activity(sightseeing, Y). 
adjective(creative,Y) :- type(theater,Y).
adjective(creative,Y) :- type(museum,Y).
adjective(creative,Y) :- type(cafe,Y), activity(reading,Y).
adjective(relaxing,Y) :- type(spa,Y).
adjective(relaxing,Y) :- type(cafe,Y).
adjective(relaxing,Y) :- type(cinema,Y).
              
restaurant(japanese, Y) :- type(restaurant, Y), food(sushi, Y).
restaurant(japanese, Y) :- type(restaurant, Y), food(ramen, Y).
restaurant(japanese, Y) :- type(restaurant, Y), food(takoyaki, Y).
restaurant(polish,Y) :- type(restaurant, Y), food(pierogi,Y).
restaurant(polish,Y) :- type(restaurant, Y), food(schabowy,Y).

distance(X1,Y1,X2,Y2, R) :- R is sqrt((X2-X1)^2 + (Y2-Y1)^2).

% location(X,Y).
% far(X1,Y1,X2,Y2) :- (dist1) - dist2 > 100.
