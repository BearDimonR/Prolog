domains
    list = string*
    listint = integer*
    list1 = list*

predicates
    predmet(integer, string)
    kafedra(integer, string)
    posada(integer, string)
    rozklad(integer, integer, string)
    lector(integer, string, string, integer, integer, integer)
    lector_auditories(integer, list)
    member(string, list)
    member(integer, listint)
    to_set(listint, listint)
    to_set(list, list)
    to_set(listint, listint, listint)
    to_set(list, list, list)
    lectors_by_kafedra(listint, integer)
    find_min(integer, listint, integer)
    find_min(integer, listint)
    min(integer, integer, integer)
    min_stavka(list)
    remove_from_list(listint, integer, listint)
    remove_from_list(listint, integer, listint, listint)
    append(list, list, list)
    append(listint, listint, listint)
    append(list1, list1, list1)
    lector_predmets(integer, listint)
    lectors_by_predmets(listint, listint)
    lectors_by_predmets(listint, listint, listint)
    lector_list(list1, listint)
    lector_list(list1, listint, list1)
    find_sim_lectors(integer, list1)
    lectors_intersect_predm(listint, listint)
    lectors_intersect_predm(listint, listint, listint)
    intersection(listint, listint, listint)
    intersection(listint, listint, listint, listint)
    lector_list_short(list1, listint)
    lector_list_short(list1, listint, list1)
    find_all_that(integer, list1)

clauses

           predmet(1, "Probability theory").
           predmet(2, "Logic Programming").
           predmet(3, "Mathematical methods of machine learning").
           predmet(4, "Web programming").
           predmet(5, "Databases").

           kafedra(1, "Informatics").
           kafedra(2, "Math").
           kafedra(3, "Network Technologies").

           posada(1, "Docent").
           posada(2, "Teacher").


                 rozklad(1, 5, "3-32").
                 rozklad(1, 2, "4-10").
                 rozklad(1, 2, "3-32").
                 rozklad(1, 2, "4-20").
                 rozklad(1, 2, "1-10").

                 rozklad(2, 1, "2-32").
                 rozklad(2, 1, "1-30").
                 rozklad(2, 1, "3-32").
                 rozklad(2, 5, "3-32").
                 rozklad(2, 5, "1-10").

                 rozklad(3, 3, "4-22").
                 rozklad(3, 3, "4-15").
                 rozklad(3, 5, "3-22").
                 rozklad(3, 2, "1-20").
                 rozklad(3, 2, "1-30").

                 rozklad(4, 4, "1-15").
                 rozklad(4, 4, "1-6").
                 rozklad(4, 4, "1-15").
                 rozklad(4, 5, "1-10").
                 rozklad(4, 5, "1-20").

                 rozklad(7, 4, "1-15").
                 rozklad(7, 4, "1-15").
                 rozklad(7, 4, "1-15").
                 rozklad(7, 4, "1-10").
                 rozklad(7, 4, "1-10").

                 rozklad(5, 3, "2-20").
                 rozklad(5, 3, "2-20").

                 rozklad(6, 3, "2-10").
                 rozklad(6, 3, "2-10").

           lector(1, "Brovarenko", "01.05.1995", 2, 2000, 1).
           lector(2, "Melnichenko", "22.03.1969", 2, 3000, 2).
           lector(3, "Romanchenko", "01.05.1995", 2, 4200, 3).
           lector(4, "Diduh", "27.01.1975", 2, 2150, 3).
           lector(5, "Panasyuk", "24.06.1966", 1, 2150, 3).
           lector(6, "Antonenko", "13.12.1986", 2, 2400, 2).
           lector(7, "Petrenko", "31.03.1996", 1, 2700, 1).


% додаткові функції

     % злиття списків
        % X - список 1
        % Y - список 2
        % Z - вихідний список
        % append(+X, +Y, -Z).
    append([ ], L, L).
    append([X|L1], L2, [X|L]):- append(L1, L2, L).

    % мінімальне з 2
    % X - число
    % Y - число
    % Z - число
    % min(+X, +Y, -Z).
    min(X, Y, X):- X < Y, !.
    min(_, Y, Y):- !.

    % чи є елемент в списку
    % X - елемент
    % Y - список
    % member(+X, +Y).
    member(Elem, [Elem|_]).
    member(Elem, [_|Tail]):- member(Elem, Tail).


    % список до set (прибрати всі дублікати)
        % X - список вхідний
        % Y - список результат
        % to_set(+X, -Y).
    to_set(X, Y) :- to_set(X, [], Y).
    to_set([], Z, Z) :- !.
    to_set([H|T], Acc, Set) :- member(H, Acc), to_set(T, Acc, Set), !.
    to_set([H|T], Acc, Set) :- to_set(T, [H|Acc], Set).


    % списки пересікання (і в тому і в тому)
        % X - список вхідний 1
        % Y - список вхідний 2
        % Z - список вихідний
        % intersection(+X, +Y, -Z).
    intersection(X, Y, Z) :- intersection(X, Y, [], Z).
    intersection([], _, Z, Z) :- !.
    intersection(_, [], Z, Z) :- !.
    intersection([H|T], Sec, Acc, Set) :- member(H, Sec), intersection(T, Sec, [H|Acc], Set), !.
    intersection([_|T], Sec, Acc, Set) :- intersection(T, Sec, Acc, Set).




% Завдання 1(6) В яких аудиторіях викладає певний викладач?


 % знаходить список унікальних аудиторій викладача
    % X - кл - код лектора
    % Y - список аудиторій
    % lector_auditories(?X, -Y).

    lector_auditories(X, Y) :- lector(X, _, _, _, _, _),
                                 findall(M, rozklad(X, _, M), L),
                                     to_set(L, Y).

   % результати
    %  lector_auditories(1, Y). -->  Y = ["3-32", "4-10", "4-20", "1-10"].
    %  lector_auditories(2, Y). -->  Y = ["2-32", "1-30", "3-32", "1-10"].
    %  lector_auditories(3, Y). -->  Y = ["4-22", "4-15", "3-22", "1-20", "1-30"].
    %  lector_auditories(4, Y).  --> Y = ["1-15", "1-6", "1-10", "1-20"].




 % Завдання 2(9) По кожній кафедрі визначити викладача з мінімальною ставкою.




 % знаходить список лекторів певної кафедри
    % X - список кодів лекторів
    % Y - кк - код кафедри
    % lectors_by_kafedra(?X, ?Y).

    lectors_by_kafedra(X, Y) :- kafedra(Y, _), findall(M, lector(M, _, _, _, _, Y), X).


 % шукає мінім ставку лекторів зі списку
    % X - мінімальна ставка
    % Y - список кодів лекторів
    % find_min(-X, +Y).

    find_min(X, Y) :- find_min(X, Y, 0).
    find_min(Z, [], Z) :- !.
    find_min(X, [Y|Z], 0) :- lector(Y, _, _, _, S, _), find_min(X, Z, S), !.
    find_min(X, [Y|Z], K) :- lector(Y, _, _, _, S, _), min(K, S, NK) ,find_min(X, Z, NK).


% повертає для кожної кафедри по списку викладачів з мінімальною ставкою (в результаті буде 3 списка)
    % X - список для кафедри
    % min_stavka(-X).

    min_stavka(X) :- lectors_by_kafedra(List, Index),
                        find_min(Min, List),
                            findall(M, lector(_, M, _, _, Min, Index), X).


 % результати
    %  min_stavka(X).
          % X = ["Brovarenko"] ; - для кафедри 1
          % X = ["Antonenko"] ; - для кафедри 2
          % X = ["Diduh", "Panasyuk"]. - для кафедри 3





 % Завдання 3(1)



 % Які викладачі (прізвище, дата народження, посада) читать ті самі предмети, що і певний викладач?


% видаляє перше значення E is H зі списку
    % X - список після видалення
    % E - значення для видалення
    % Y - список для видалення
    % remove_from_list(-X, +E, +Y)

    remove_from_list(X, E, Y) :- remove_from_list(X, E, Y, []).
    remove_from_list(L, _, [], L) :- !.
    remove_from_list(X, E, [H|T], L) :- E = H, append(T, L, X), !.
    remove_from_list(X, E, [H|T], L) :- append(L, [H], NL),remove_from_list(X, E, T, NL).

% повертає set предметів лектора
    % X - кл - код лектора
    % Y - список кодів предметів
    % lector_predmets(?X, -Y)

    lector_predmets(X, Y) :- findall(M, rozklad(X, M, _), L),  to_set(L, Y).

% повертає set лекторів, які викладають хоч 1 предмет зі списку
    % X - список кодів лекторів
    % Y - список кп - кодів предметів
    % lectors_by_predmets(-X, +Y)

    lectors_by_predmets(X, Y) :- lectors_by_predmets(X, Y, []).
    lectors_by_predmets(X, [], Z) :-  to_set(Z, X), !.
    lectors_by_predmets(X, [Y|Z], K) :- findall(M, rozklad(M, Y, _), L),
                                            append(K, L, NK),
                                                lectors_by_predmets(X, Z, NK).

% повертає інформацію про лекторів зі списку з їх кодами
      % X - список [прізвище, дата народження, посада] відповідних лекторів
      % Y - список кл - кодів лекторів
      % lector_list(-X, +Y)

      lector_list(X, Y) :- lector_list(X, Y, []).
      lector_list(Z, [], Z) :- !.
      lector_list(X, [H|T], Z) :- lector(H, Prizv, Data, PosId, _, _),
                                      posada(PosId, PosName),
                                          append(Z, [[Prizv, Data, PosName]], NZ),
                                              lector_list(X, T, NZ).

% викладачі (прізвище, дата народження, посада) читать ті самі предмети, що і певний викладач
    % X - кл - код лектора
    % Y - список (прізвище, дата народження, посада)
    % find_sim_lectors(+X, -Y)

    find_sim_lectors(X, Y) :- lector_predmets(X, Predm),
                                lectors_by_predmets(Lect, Predm),
                                    remove_from_list(LectFinal, X, Lect),
                                        lector_list(Y, LectFinal).



    % результат
    % find_sim_lectors(1, Y).
          % Y = [["Melnichenko", "22.03.1969", "Teacher"],
          %      ["Romanchenko", "01.05.1995", "Teacher"],
          %      ["Diduh", "27.01.1975", "Teacher"]].

    % find_sim_lectors(5, Y).
          % Y = [["Antonenko", "13.12.1986", "Teacher"],
          %      ["Romanchenko", "01.05.1995", "Teacher"]].

    %  find_sim_lectors(4, Y).
          % Y = [["Petrenko", "31.03.1996", "Docent"],
          %      ["Brovarenko", "01.05.1995", "Teacher"],
          %      ["Melnichenko", "22.03.1969", "Teacher"],
          %      ["Romanchenko", "01.05.1995", "Teacher"]].






% Які викладачі (прізвище, кафедра) читать усі ті предмети, що і певний викладач?



% лектори які викладають усі ті предмети, що і заданому списку
    % X - список кл - кодів лекторів
    % Y - список кп - кодів предметів
    % lectors_intersect_predm(-X, +Y)

    lectors_intersect_predm(X, Y) :- lectors_intersect_predm(X, Y, []).
    lectors_intersect_predm(X, [], Z) :-  to_set(Z, X), !.
    lectors_intersect_predm(X, [Y|Z], []) :- findall(M, rozklad(M, Y, _), L),
                                                     lectors_intersect_predm(X, Z, L), !.
    lectors_intersect_predm(X, [Y|Z], K) :- findall(M, rozklad(M, Y, _), L),
                                            intersection(K, L, NK),
                                                 lectors_intersect_predm(X, Z, NK).

% повертає інформацію про лекторів зі списку з їх кодами
    % X - список (прізвище, кафедра)
    % Y - список кл - кодів лекторів
    % lector_list_short(-X, +Y)

    lector_list_short(X, Y) :- lector_list_short(X, Y, []).
    lector_list_short(Z, [], Z) :- !.
    lector_list_short(X, [H|T], Z) :- lector(H, Prizv, _, _, _, KafId),
                                        kafedra(KafId, KafName),
                                            append(Z, [[Prizv, KafName]], NZ),
                                                lector_list_short(X, T, NZ).

% викладачі (прізвище, кафедра) читать усі ті предмети, що і певний викладач
    % X - кл - код лектора
    % Y - список (прізвище, кафедра)
    % find_all_that(+X, -Y)
    find_all_that(X, Y) :- lector_predmets(X, Predm),
                                lectors_intersect_predm(L, Predm),
                                    remove_from_list(LFinal, X, L),
                                        lector_list_short(Y, LFinal).

 % результати
   % find_all_that(1, Y).
        % Y = [["Romanchenko", "Network Technologies"]].
   % find_all_that(5, Y).
        % Y = [["Antonenko", "Math"],  ["Romanchenko", "Network Technologies"]].
   % find_all_that(3, Y).
        % Y = [].