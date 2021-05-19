

lessEqual(_, []).
lessEqual(Value, [X]) :- Value =< X.
lessEqual(Value, [H|T]) :- Value =< H, lessEqual(Value, T).

greater(_, []).
greater(Value, [X]) :- Value > X.
greater(Value, [H|T]) :- Value > H, greater(Value, T).


%1.Обходу AVL-дерева.
% obhidAVL(+Tree, -List).
obhidAVL(nil/0, []).
obhidAVL(tree(LTr, Val, RTr)/_, Res) :- obhidAVL(LTr, LList), obhidAVL(RTr, RList), append(LList, [Val|RList], Res).

% obhidAVL(tree(tree(nil/0, 6, tree(nil/0, 2, nil/0)/1)/2, 8, nil/0)/3,Res)
 %Res = [6, 2, 8].

% obhidAVL(tree(nil/0, 2, tree(nil/0, 4, tree(nil/0,5,nil/0)/1)/2)/3,Res).
  %Res = [2, 4, 5].

% obhidAVL(tree(nil/0, 0, nil/0)/1,Res).
 %Res = [0].




%2.Пошуку заданого елемента в AVL-дерева.
% findAVL(+Tree, +Elem).
findAVL(nil/0, _) :- fail.
findAVL(tree(LTr, Val, RTr)/_, Res) :- Val = Res; findAVL(LTr, Res); findAVL(RTr, Res).

% findAVL(tree(tree(nil/0, 6, tree(nil/0, 2, nil/0)/1)/2, 8, nil/0)/3, 2).
  %true .

% findAVL(tree(tree(nil/0, 6, tree(nil/0, 2, nil/0)/1)/2, 8, nil/0)/3, 9).
  %false.

% findAVL(tree(nil/0, 0, nil/0)/1, 1).
  %false.

% findAVL(tree(nil/0, 0, nil/0)/1, 0).
  %true .





%3.Перевірки чи є заданий об'єкт AVL-деревом.
% checkAVL(+Tree).
checkAVL(nil/0).
checkAVL(tree(_, nil, _)) :- fail.
checkAVL(tree(_, tree(_, _, _)/_, _)) :- fail.
checkAVL(tree(LTr, Val, RTr)/H) :- checkAVL(LTr), checkAVL(RTr),
                                   obhidAVL(LTr, LList), obhidAVL(RTr, RList),
                                    greater(Val, LList), lessEqual(Val, RList),
                                    heightAVL(tree(LTr, Val, RTr)/H, Res), H = Res,
                                    heightAVL(LTr, LH), heightAVL(RTr, RH),
                                    Diff is LH - RH, Abs is abs(Diff), Abs =< 1.

heightAVL(nil/0, 0).
heightAVL(tree(LTr, _, RTr)/_, Res) :- heightAVL(LTr, LH), heightAVL(RTr, RH), Res is 1 + max(LH, RH).


% checkAVL(tree(tree(nil/0, 3, tree(nil/0, 5, nil/0)/1)/2, 10, nil/0)/3).
  %false.

% checkAVL(tree(tree(nil/0, 3, nil/0)/1, 10, tree(nil/0, 11, nil/0)/1)/2).
  %true .

% checkAVL(tree(nil/0, 0, nil/0)/1).
  %true .

% checkAVL(tree(nil/0, 0, nil/0)/2).
  %false.

% checkAVL(tree(tree(tree(nil/0, 2, nil/0)/1, 4 ,nil/0)/2, 6 ,tree(nil/0, 7, tree(nil/0, 9, nil/0)/1)/2)/3).
  %true .




%4.Видалення заданого вузла з AVL-дерева (після видалення дерево має "залишитись" ANL-деревом).

%deleteAVL(+Tree, +Elem, -ResTree).
deleteAVL(Tree, Elem, Res) :- checkAVL(Tree), findAVL(Tree, Elem),
                                remove_val(Tree, Elem, TreeNotAVL), makeAVL(TreeNotAVL, Res), !.
deleteAVL(_, _, _) :- fail.


% deleteAVL(tree(tree(nil/0, 3, nil/0)/1, 10, tree(nil/0, 11, nil/0)/1)/2, 11, Res).
  %Res = tree(tree(nil/0, 3, nil/0)/1, 10, nil/0)/2.

% deleteAVL(tree(tree(tree(nil/0, 2, nil/0)/1, 4 ,nil/0)/2, 6 ,tree(nil/0, 7, tree(nil/0, 9, nil/0)/1)/2)/3, 9, Res).
  %Res = tree(tree(tree(nil/0, 2, nil/0)/1, 4, nil/0)/2, 6, tree(nil/0, 7, nil/0)/1)/3.

% deleteAVL(tree(tree(tree(nil/0, 2, nil/0)/1, 4 ,nil/0)/2, 6 ,tree(nil/0, 7, tree(nil/0, 9, nil/0)/1)/2)/3, 7, Res).
  %Res = tree(tree(tree(nil/0, 2, nil/0)/1, 4, nil/0)/2, 6, tree(nil/0, 9, nil/0)/1)/3.

% deleteAVL(tree(tree(tree(nil/0, 2, nil/0)/1, 4 ,nil/0)/2, 6 ,tree(nil/0, 7, tree(nil/0, 9, nil/0)/1)/2)/3, 6, Res).
  %Res = tree(tree(tree(nil/0, 2, nil/0)/1, 4, nil/0)/2, 7, tree(nil/0, 9, nil/0)/1)/3.

% deleteAVL(tree(tree(tree(nil/0, 2, nil/0)/1, 4, nil/0)/2, 6, tree(nil/0, 7, nil/0)/1)/3, 7, Res).
  %Res = tree(tree(nil/0, 2, nil/0)/1, 4, tree(nil/0, 6, nil/0)/1)/2.


remove_val(tree(nil/0, Elem, nil/0)/1, Elem, nil/0).
remove_val(tree(LTr, Elem, nil/0)/_, Elem, LTr).
remove_val(tree(nil/0, Elem, RTr)/_, Elem, RTr).
remove_val(tree(LTr, Elem, RTr)/H, Elem, tree(LTr, N, NRTr)/H) :- minAVL(RTr, N), remove_val(RTr, N, NRTr).
remove_val(tree(LTr, Val, RTr)/H, Elem, tree(NLTr, Val, RTr)/H) :- Val>Elem, remove_val(LTr, Elem, NLTr), !.
remove_val(tree(LTr, Val, RTr)/H, Elem, tree(LTr, Val, NRTr)/H) :- remove_val(RTr, Elem, NRTr).

minAVL(tree(nil/0, Val, _)/_, Val).
minAVL(tree(LTr, _, _)/_, Res) :- minAVL(LTr, Res).

changeH(T/_, NH, T/NH).

makeAVL(nil/0, nil/0).
makeAVL(tree(LTr, Val, RTr)/_, Res) :- makeAVL(LTr, NLTr), makeAVL(RTr, NRTr),
                                        heightAVL(NLTr, LH), heightAVL(NRTr, RH),
                                         H is 1 + max(LH, RH), Diff is LH - RH,
                                         changeH(NLTr, LH, NLTrH), changeH(NRTr, RH, NRTrH),
                                         Tree = tree(NLTrH, Val, NRTrH)/H, decide(Tree, Diff, Res).

 decide(Tree, 2, Res) :- left(Tree, Res).
 decide(Tree, N, Tree) :- -1 =< N, N =< 1.
 decide(Tree, _, Res) :- right(Tree, Res).

 left(tree(tree(tree(LTr, Val1, RTr1)/_, Val2, RTr2)/_, Val3, RTr3)/_,
        tree(tree(LTr, Val1, RTr1)/LH, Val2, tree(RTr2, Val3, RTr3)/RH)/H) :-
            LTree = tree(LTr, Val1, RTr1)/0, RTree = tree(RTr2, Val3, RTr3)/0,
            heightAVL(LTree, LH), heightAVL(RTree, RH),
            H is 1 + max(LH, RH).

 left(tree(tree(LTr1, Val1, tree(LTr2, Val2, RTr1)/_)/_, Val3, RTr2)/_,
        tree(tree(LTr1, Val1, LTr2)/LH, Val2, tree(RTr1, Val3, RTr2)/RH)/H) :-
            LTree = tree(LTr1, Val1, LTr2)/0, RTree = tree(RTr1, Val3, RTr2)/0,
            heightAVL(LTree, LH), heightAVL(RTree, RH),
            H is 1 + max(LH, RH).

right(tree(LTr1, Val1, tree(LTr2, Val2, tree(LTr3, Val3, RTr)/_)/_)/_,
        tree(tree(LTr1, Val1, LTr2)/LH, Val2, tree(LTr3, Val3, RTr)/RH)/H) :-
            LTree = tree(LTr1, Val1, LTr2)/0, RTree = tree(LTr3, Val3, RTr)/0,
            heightAVL(LTree, LH), heightAVL(RTree, RH),
            H is 1 + max(LH, RH).

right(tree(LTr1, Val1, tree(tree(LTr2, Val2, RTr1)/_, Val3, RTr2)/_)/_,
        tree(tree(LTr1, Val1, LTr2)/LH, Val2, tree(RTr1, Val3, RTr2)/RH)/H) :-
            LTree = tree(LTr1, Val1, LTr2)/0, RTree = tree(RTr1, Val3, RTr2)/0,
            heightAVL(LTree, LH), heightAVL(RTree, RH),
            H is 1 + max(LH, RH).