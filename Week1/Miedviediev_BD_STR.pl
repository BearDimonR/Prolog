

        family( member( tom, fox, date( 7, may, 1940),
              works( bbc, 15200) ),
              member( anne, fox, date( 9, may, 1950), unemployed),
              [member( pat, fox, date( 5, may, 1973), unemployed),
              member( jim, fox, date( 5, may, 1973), unemployed)]).
        family( member( tom2, fox2, date( 15, september, 1955),
                      works( bbc, 9500) ),
                      member( anne2, fox2, date( 9, may, 1978), unemployed),
                      [member( pat2, fox2, date( 5, may, 1990), unemployed),
                      member( jim2, fox2, date( 5, may, 1991), wors(vvc, 5000))]).
        family( member( tom3, fox3, date( 7, may, 1940), unemployed ),
                      member( anne3, fox3, date( 9, may, 1950),
                      works( uuc, 9900)),
                      [member( pat3, fox3, date( 5, may, 1973), unemployed),
                      member( jim3, fox3, date( 5, may, 1981), unemployed)]).
        family( member( tom4, fox4, date( 7, may, 1940),
                      works( bbc, 15200) ),
                      member( anne4, fox4, date( 9, may, 1970), unemployed),
                      [member( pat4, fox4, date( 5, may, 1981), unemployed),
                      member( jim4, fox4, date( 5, may, 1973), unemployed),
                      member( jim4, fox4, date( 5, may, 1973), unemployed)
                      ]).

 husband(X) :-
          family(X, _, _).

 wife(X) :-
          family(_, X, _).

 child(X) :-
           family(_, _, Y),
           belongs( X, Y).

 belongs(X, [X | _]).

 belongs(X, [_ | L]) :-
            belongs(X, L).

 exists(X) :-
            husband(X);
            wife(X);
            child(X).

 birthday(member(_, _, Date, _), Date).

 wage(member(_,_,_, works(_, S)), S).

 wage(member(_,_,_, unemployed), 0).

 %всіх дітей, які народилися у 1981.

 task1981(X) :- child(X), birthday(X, date(_,_,1981)).

 %всіх жінок, які не працюють.

 taskWoman(Name, Surname) :- wife(member(Name, Surname, _, unemployed)).

 %всіх людей, які не працюють, але не досягли пенсійного віку.

 taskAllRetired(Name, Surname, Year) :- exists(member(Name, Surname, date(_,_,Year), unemployed)), Year > 1955.

 %всіх людей, які народилися до 1961, та чий прибуток менше 10000.

 taskAll10K(Name, Surname, Year, W) :- exists(member(Name, Surname, date(_,_,Year), works(_, W))), Year < 1962, W < 10000.

 %прізвища людей, які мають хоча б трьох дітей.

 taskSurname(Surname) :- family( member(_, Surname, _, _), _, [_, _, _ | _]).

 %родини без дітей.

 taskNoChild(Surname) :- family(member(_, Surname, _, _), _, []).

 %всіх працюючих дітей.

 taskWorking(Name, Surname) :- child(member(Name, Surname, _, work(_, _))).

 %родини, де жінка працює, а чоловік ні.

 taskWoman(Surname) :- family(member(_, Surname, _, unemployed), member(_, Surname, _, words(_, _)), _).

 %всіх дітей, для яких різниця у віці їх батьків більше 15 років.

 taskChilderPar(Hus, Wom, Child1, Child2) :- family(Hus, Wom, Child1),
                      birthday(Hus, date(_, _, manBirth)),
                      birthday(Wom, date(_, _, womBirth)),
                      (manBirth - womBirth >= 15; womBirth - manBirth >= 15),
                      belongs(Child1, Child2).
