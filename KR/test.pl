% Визначити одним розділом предикат завдання з використанням лише предикату "злиття".
  %Додаткові вимоги до умов виконання:
  %
  %Заборонено використовувати
  %а) вбудовані предикати та функтори (окрім "!" та "[... |... ]");
  %б) визначати власні допоміжні;
  %в) рекурсію предикату завдання.
  %Програма має містити один розділ.
  %Програма має містити одну процедуру
  %(якщо дозволено більше, то вказано у завданні до якої кількості процедур можна записувати).
  %Для окремих завдань вказано про дозвіл/потребу використання: not, "\=" та "=" (якщо не вказано, то не можна використовувати).
  %Імена предикатів завдання забороняється  змінювати.
  %Всі завдання починаються наступним
  %
  %% Маючи предикат:
  %
  %злиття([ ], L, L).
  %злиття([X|L1], L2, [X|L]):- злиття(L1, L2, L).
  %
  %
  %% визначити предикат вказаний у завданні.
  %
  %"Тест" контрольної роботи містить 2 завдання з категорій:
  %
  %Легке на "злиття" (5б).
  %Середнє на "злиття" (10б).
  %Питання по бектрекінгу, "!" та здобуття розв'язків (1б).
  %Питання про процедурній інтерпретації Логічного програмування (1б).
  %Загалом: 17 балів.

male(sasha).
male(ivan).
male(petro).
male(nick).

female(masha).
female(sasha).
female(kate).
female(nata).
female(dasha).

p1(X, Y):- X = Y.
p2(X, Y):- Y = X.
p3(Z, X, Z):- Z=X.

appen([ ], L, L).
appen([X|L1], L2, [X|L]) :- appen(L1, L2, L).

%39 чи_є_кінцем
is_end(X, Y) :- appen(_, X, Y).

%10 збіг_суміжні
symi(X, Y) :- appen(_, [Y,Y|_], X).

%8 які_через_1_після
after_1(X, Y, Out) :- appen(_,[Y, _, Out | _],X).

%32 чи_належать_2
conclude_2(E1, E2, List) :- appen(_,[E1|_],List),!, appen(_, [E2|_], List), !.

conc_list(List, El) :- appen(_, [El|_], List), !.

%12 нема_дублікатів
has_dublic(List) :- not((appen(_, [E|T], List), appen(_, [E|_], T))).

nema_dublicativ(List) :- not((appen(_, [E|T], List), appen(_, [E|_], T))).

not_dublicat(El, List) :- appen(Before, [El|T], List),
                            not(appen(_, [El|_], T)), not(appen(_, [El|_], Before)).

%18 чи_останній
is_last(X, List) :- appen(_, [X|[]], List), !.

%24 суфікси
syff(List, Out) :- appen(_, [_|Out], List), not(Out = []).

%26 видалення_сотаннього
remove_last(List, Out) :- appen(Out, [_], List), !.

%13 дублюється
dublicates(El, List) :- appen(_, [El|T], List), appen(_, [El|_], T), !.

%37 підсписки_між_2
sublists_2(El1,El2,List,Subs) :- appen(_, [El1|T], List), appen(Subs, [El2|_], T).


% передОстанній
almostLast(List, Out) :- appen(_, [Out,_|[]], List), !.

peredOstanniy(List, PeredOstanniy) :- appen(_, [PeredOstanniy,_|[]], List), !.

odno([E1,E1]) :- !.
odno([E1,E1|T]) :- odno(T).