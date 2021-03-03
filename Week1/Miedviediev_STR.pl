% Предметна область:
%Мої улюблені фільми.
%Відношення-факти:
    %Фільм (назва, режисер, рік випуску, анотація).
    %Актор (ПІБ, звання, рік народження, місце роботи).
    %Знімався (назва фільму, ПІБ, роль, характеристика ролі).
%Під характеристикою ролі розуміється: головна, епізодична,….

% структури фільмів

%film(tenet, person(cristofer, nolan), 2020, "factastic action about spies",
%        [
%        played(actor(person(robert, pattinson), associate, 1994, worked(hollywood)), main, "Nil actor"),
%        played(actor(person(john, vashington), docent, 1992, worked(hollywood)), partial, "The Protagonist actor"),
%        played(actor(person(kennet, brana), professor, 1984, worked(hollywood)), partial, "Andrei Sator actor")
%        ]
%    ).
%
%film(king, person(devid, misho), 2019, "historic dramatic film based on plays",
%        [
%        played(actor(person(robert, pattinson), associate, 1994, worked(hollywood)), main, "The Dauphin actor"),
%        played(actor(person(timoti, shalame), associate, 1995, worked(wb)), main, "Gel actor"),
%        played(actor(person(joel, edgerton), associate, 1991, worked(hollywood)), partial, "Ser John Falstaf actor")
%        ]
%    ).
%
%film(superinteligence, person(ben, felkoyn), 2020, "american fantastic film",
%        [
%        played(actor(person(ben, felkoyn), docent, 1981, worked(wb)), main, "Sharl Koiper actor"),
%        played(actor(person(mellisa, maccarti), professor, 1978, worked(wb)), main, "Kerol Piters actor"),
%        played(actor(person(bobby, kannavale), professor, 1984, worked(bbc)), partial, "Gourge actor")
%        ]
%    ).

 % Відношення-правила (6):

 % додаткові
% belongs( X, [X | _ ]).
% belongs( X, [_ | L ]) :- belongs(X, L).

 %в яких фільмах знімався даний актор;
 % як вхід подається person(name, surname).
% actor_film(X, Y) :- film(Y, _, _, _, Z), belongs(played(actor(X, _, _, _), _, _), Z).


 %вік акторів, зайнятих на зйомках даного фільму;
% age_actor_film(X, Y) :- film(X, _, _, _, Z), belongs(played(actor(_, _, Age, _), _, _), Z), Y is (2021 - Age).

 %хто з акторів зіграв у заданому фільмі вказану роль;
% role_film(X, Y, Z) :- film(X, _, _, _, H), belongs(played(actor(Z, _, _, _), Y, _), H).


 % власні правила


 % хто з акторів заданого фільму був і його режисером ;
 % X це person(name, surname).

% actor_producer(X, Y) :- film(X, Y, _, _, Z), belongs(played(actor(Y, _, _, _), _, _), Z).

 % в яких фільмах знімалися актори з вказаним званням (з дублікатами);
% rank_film(X, Y) :- film(Y, _, _, _, Z), belongs(played(actor(_, X, _, _), _, _), Z).

 % хто з акторів працює на вказаному місці роботи та старше за вказане число років;
% hollywood20(X, Y, Z) :- film(_, _, _, _, H), belongs(played(actor(Z, _, Age, worked(X)), _, _), H), 2021 - Age > Y.