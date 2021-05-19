% Базові факти

% всі можливі кольори фігурок
color(white).
color(pink).
color(yellow).
color(orange).
color(red).
color(green).
color(blue).
color(black).

% всі можливі розсташування фігурок
location(loc1).
location(loc2).
location(loc3).
location(loc4).
location(loc5).
location(loc6).
location(loc7).
location(loc8).

% перебір можливих варіантів з вказаними параметрами
% select(?Loc,?Color).
select(Loc, Color):- location(Loc), color(Color).


% L(1) картки

% картка - будь-яке місце
% any_card(?Color, ?Loc)
any_card(Color, Loc):- select(Loc, Color).

% кінець L(1) карток


% L(2) картки

% картка - в правому кутку
% факти для картки
card_right_corner(loc4).
card_right_corner(loc5).
card_right_corner(loc6).
card_right_corner(loc7).
card_right_corner(loc8).
% правило перебору для цієї картки
% right_corner_card(?Color, ?Loc)
right_corner_card(Color, Loc):-
    select(Loc, Color),
    card_right_corner(Loc).

% картка - в лівому кутку
% факти для картки
card_left_corner(loc1).
card_left_corner(loc3).
card_left_corner(loc2).
% правило перебору для цієї картки
% left_corner_card(?Color, ?Loc)
left_corner_card(Color, Loc):-
    select(Loc, Color),
    card_left_corner(Loc).

% картка - зверху або знизу
% факти для картки
card_top_bottom(loc1).
card_top_bottom(loc4).
card_top_bottom(loc5).
% правило перебору для цієї картки
% top_bottom_card(?Color, ?Loc)
top_bottom_card(Color, Loc):-
    select(Loc, Color),
    card_top_bottom(Loc).

% картка - справа або зліва
% факти для картки
card_left_right(loc2).
card_left_right(loc3).
card_left_right(loc6).
card_left_right(loc7).
card_left_right(loc8).
% правило перебору для цієї картки
% left_right_card(?Color, ?Loc)
left_right_card(Color, Loc):-
    select(Loc, Color),
    card_left_right(Loc).

% кінець L(2) карток


% L(3) картки

% карта - біля іншої
% факти для картки
card_next(loc2, loc3).
card_next(loc4, loc5).
card_next(loc6, loc7).
card_next(loc7, loc8).
% якщо а біля б, то і б біля а
card_next_commutative(X, Y) :- card_next(X, Y), !.
card_next_commutative(X, Y) :- card_next(Y, X).
% правило перебору для цієї картки
% next_card(?MyColor, ?PartnerColor, ?MyPlace, ?PartnerPlace)
next_card(MyColor, PartnerColor, MyPlace, PartnerPlace):-
    select(MyPlace, MyColor),
    select(PartnerPlace, PartnerColor),
    card_next_commutative(MyPlace, PartnerPlace).

next_card(MyColor, PartnerColor, MyPlace, PartnerPlace):-
    select(MyPlace, MyColor),
    select(PartnerPlace, PartnerColor),
    MyColor = PartnerColor.

% картка - протилежний бік
% факти для картки
% 1 проти 4 та 5
card_opposite(loc1, loc4).
card_opposite(loc1, loc5).
% 4 та 5 проти 1
card_opposite(loc4, loc1).
card_opposite(loc5, loc1).
% 3 проти 6 та 7, 2 проти 7 та 8
card_opposite(loc3, loc7).
card_opposite(loc3, loc6).
card_opposite(loc2, loc7).
card_opposite(loc2, loc8).
% 6 проти 3, 7 проти 3 та 4, 8 проти 2
card_opposite(loc6, loc3).
card_opposite(loc7, loc3).
card_opposite(loc7, loc4).
card_opposite(loc8, loc2).
% правило перебору для цієї картки
% opposite_card(?MyColor, ?PartnerColor, ?MyPlace, ?PartnerPlace)
opposite_card(MyColor, PartnerColor, MyPlace, PartnerPlace):-
    select(MyPlace, MyColor),
    select(PartnerPlace, PartnerColor),
    card_opposite(MyPlace, PartnerPlace).

opposite_card(MyColor, PartnerColor, MyPlace, PartnerPlace):-
    select(MyPlace, MyColor),
    select(PartnerPlace, PartnerColor),
    MyColor = PartnerColor.

% картка - сусід по кутку
% факти для картки
% 2 та 1, 8 та 1, 3 та 4, 5 та 6
card_next_corner(loc2, loc1).
card_next_corner(loc1, loc8).
card_next_corner(loc3, loc4).
card_next_corner(loc5, loc6).
% якщо а сусід б, то і б сусід а
card_next_corner_commutative(X, Y) :- card_next_corner(X, Y), !.
card_next_corner_commutative(X, Y) :- card_next_corner(Y, X).
% правило перебору для цієї картки
% next_corner_card(?MyColor, ?PartnerColor, ?MyPlace, ?PartnerPlace)
next_corner_card(MyColor, PartnerColor, MyPlace, PartnerPlace):-
    select(MyPlace, MyColor),
    select(PartnerPlace, PartnerColor),
    card_next_corner_commutative(MyPlace, PartnerPlace).

next_corner_card(MyColor, PartnerColor, MyPlace, PartnerPlace):-
    select(MyPlace, MyColor),
    select(PartnerPlace, PartnerColor),
    MyColor = PartnerColor.

% кінець L(3) карток


% L(4) картки

% картка - не сусід і не навпроти
% правило перебору для цієї картки
% next_corner_card(?MyColor, ?PartnerColor, ?MyPlace, ?PartnerPlace)
not_next_or_opposite_card(MyColor, PartnerColor, MyPlace, PartnerPlace):-
    select(MyPlace, MyColor),
    select(PartnerPlace, PartnerColor),
    not(card_next_corner_commutative(MyPlace, PartnerPlace)),
    not(card_next_commutative(MyPlace, PartnerPlace)),
    not(card_opposite(MyPlace, PartnerPlace)).

not_next_or_opposite_card(MyColor, PartnerColor, MyPlace, PartnerPlace):-
    select(MyPlace, MyColor),
    select(PartnerPlace, PartnerColor),
    MyColor = PartnerColor.

% картка - мінімум 2 проміжки між
% правило перебору для цієї картки
% least_two_spaces_card(?MyColor, ?PartnerColor, ?MyPlace, ?PartnerPlace)
least_two_spaces_card(MyColor, PartnerColor, MyPlace, PartnerPlace):-
    select(MyPlace, MyColor),
    select(PartnerPlace, PartnerColor),
    MyColor = PartnerColor.

least_two_spaces_card(MyColor, PartnerColor, MyPlace, PartnerPlace):-
    least_two_spaces_check(MyColor, PartnerColor, MyPlace, PartnerPlace),
    not(least_two_spaces_next(MyPlace, PartnerPlace)).

least_two_spaces_check(MyColor, PartnerColor, MyPlace, PartnerPlace):-
    select(MyPlace, MyColor),
    select(PartnerPlace, PartnerColor),
    not(card_next_commutative(MyPlace, PartnerPlace)),
    not(card_next_corner_commutative(MyPlace, PartnerPlace)).

least_two_spaces_next(MyPlace, PartnerPlace):-
    select(Next, orange),
    (card_next_commutative(MyPlace, Next);
    card_next_corner_commutative(Next, MyPlace)),
    (card_next_commutative(PartnerPlace, Next);
            card_next_corner_commutative(Next, PartnerPlace)), !.
% кінець L(4) карток


% виклик гри

% перевірка що немає однакових позицій
no_dublicates(WhiteP, PinkP, YellowP, OrangeP, RedP, GreenP, BlueP, BlackP):-
    sort([WhiteP, PinkP, YellowP, OrangeP, RedP, GreenP, BlueP, BlackP], Out),
    length(Out, 8).

% підрахунок очок - якщо успіх, то 0, якщо невдача - 1.
call_it(Card, Points) :- call(Card), Points is 0; Points is 1.

% пошук відповідей
get_solutions(Goal, SolsSorted) :-
     term_variables(Goal, GoalVars),
     findall(GoalVars, Goal, Sols),
     sort(Sols, SolsSorted).

% найкраща відповідь
command_line() :-
                get_solutions(round(_, _, _, _, _, _, _, _ ,_), Sols),
                [[B|M]|_] = Sols, N is 8 - B, write([N|M]), halt.

% перевірка очок стану
command_line_check([WhiteP, PinkP, YellowP, OrangeP, RedP, GreenP, BlueP, BlackP]) :-
                round(N,WhiteP, PinkP, YellowP, OrangeP, RedP, GreenP, BlueP, BlackP), K is 8-N, write(K), halt.


% generated code
round(NegPts, WhiteP, PinkP, YellowP, OrangeP, RedP, GreenP, BlueP, BlackP):- 
                     	call_it(next_card(white, yellow, WhiteP, YellowP), NegPts0),
                     	call_it(next_corner_card(pink, yellow, PinkP, YellowP), NegPts1),
                     	call_it(next_card(yellow, yellow, YellowP, YellowP), NegPts2),
                     	call_it(top_bottom_card(orange, OrangeP), NegPts3),
                     	call_it(any_card(red, RedP), NegPts4),
                     	call_it(left_right_card(green, GreenP), NegPts5),
                     	call_it(next_card(blue, red, BlueP, RedP), NegPts6),
                     	call_it(right_corner_card(black, BlackP), NegPts7),
                     	NegPts is NegPts0 + NegPts1 + NegPts2 + NegPts3 + NegPts4 + NegPts5 + NegPts6 + NegPts7,
                     	no_dublicates(WhiteP, PinkP, YellowP, OrangeP, RedP, GreenP, BlueP, BlackP).