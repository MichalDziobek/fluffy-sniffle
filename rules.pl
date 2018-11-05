% ?- X = 0, Y = 0.

poi(cinema1) :- type(cinema),
                distance(far).


poi(restaurant1) :- type(restaurant),
                    distance(near),
                    food(mexican),
                    food(vegan),
                    food(vegetarian),
                    drink(red_wine),                    
                    price(expensive).
                    % distance(X,Y, 10,20,R).

activity(drinking) :- drink(_).
activity(eating) :- food(_).
activity(resting) :- type(spa).
activity(sightseeing) :- type(museum).
activity(sightseeing) :- type(art_gallery).
activity(entertainment).

adjcetive(fun) :- activity(drinking), price(cheap).
adjective(fun) :- activity(entertainment).
adjective(snobbish) :- drink(wine), price(expensive).
adjective(snobbish) :- activity(sightseeing). 
              
type(cinema).
type(restaurant).

food(mexican).
food(vegan).
food(vegetarian).

drink(red_wine).
drink(white_wine).
drink(wine) :- drink(red_wine).
drink(wine) :- drink(white_wine).

price(expensive).

distance(far).
distance(near).
distance(not_so_far).

restaurant(mexican) :- type(restaurant),
                       food(mexican).

distance(X1,Y1,X2,Y2, R) :- R is sqrt((X2-X1)^2 + (Y2-Y1)^2).

% location(X,Y).
% far(X1,Y1,X2,Y2) :- (dist1) - dist2 > 100.
