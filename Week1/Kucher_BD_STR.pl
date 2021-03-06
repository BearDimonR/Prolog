       family( member( tom, fox, date( 7, may, 1940),
              works( bbc, 15200) ),
              member( anne, fox, date( 9, may, 1950), unemployed),
              [member( pat, fox, date( 5, may, 1973), unemployed),
              member( jim, fox, date( 5, may, 1973), unemployed) ] ).

       husband(X) :-
              family( X, _, _ ).

       wife(X) :-
              family( _, X, _ ).

       child(X) :-
              family( _, _, Y),
              belongs( X, Y).

       belongs( X, [X | _ ]).

       belongs( X, [_ | L ]) :-
               belongs( X, L).

       exists(X) :-
            husband(X);
            wife(X);
            child(X).

       birthday( member( _, _, Date, _ ), Date).

       wage( member( _, _, _, works( _, S) ), S).

       wage( member( _, _, _, unemployed), 0).

       % Task 1
       %? child(X), birthday(X, date(_, _, 1981)).

       c1981(X) :- child(X), birthday(X, date(_, _, 1981)).

       % Task 2
       unemployedWifes(Name, Surname) :- wife(member(Name, Surname, _, unemployed)).

       % Task 3
       unemployedP1955(Name, Surname, Year) :- exists(member(Name, Surname, date(_, _, Year), unemployed)), Year > 1955.
       unemployedPer(Surname, Year) :- exists(member(_, Surname, date(_, _, Year), unemployed)), Year > 1955.


       % Task 4
       workingP(Name, Surname, Year, S) :- exists(member(Name, Surname, date(_, _, Year), works(_, S))), Year =< 1961, S < 10000.

       % Task 5
       moreThan3Children(Surname) :- family( member( _, Surname, _, _ ), _, [ _, _, _ | _ ]).

       % Task 6
       noChildren(Surname) :- family( member( _, Surname, _, _ ), _, [ ]).

       % Task 7
       workingChildren(Name, Surname) :- child(member(Name, Surname, _, works(_, _))).

       % Task 8
       unemployedHworkingW(Surname) :- family(member(_, Surname, _, unemployed), member(_, _, _, works(_, _)), _).

       % Task 9
       ageDifference15(H, W, C, Child) :- family(H, W, C), birthday(H, date(_, _, HYear)), birthday(W, date(_, _, WYear)),
        (HYear - WYear >= 15; WYear - HYear >= 15), belongs(Child, C).
