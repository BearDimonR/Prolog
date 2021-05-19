

%1.Послідовності вузлів при обході в глибину бінарного дерева праворуч.
% obhid(+Tree, -List).
obhid(nil, []).
obhid(tree(LTr, Val, RTr), List) :- obhid(RTr, RList), obhid(LTr, LList), append(LList, [Val|RList], List).

% obhid(tree(tree(nil,2,tree(nil,4,nil)),3,tree(nil,5,nil)), Res).
  %Res = [2, 4, 3, 5].

% obhid(tree(nil, 2, nil), Res).
  %Res = [2].

% obhid(tree(nil, 2, tree(tree(nil, 5, tree(nil, 6, tree(nil, 8, nil))),3,nil)), Res).
 %Res = [2, 5, 6, 8, 3].


%2.Визначення кількості листків бінарного дерева. - tree(nil, _, nil) - листок
% countLeaf(+Tree, -N).
countLeaf(nil, 0).
countLeaf(tree(nil, _, nil), 1).
countLeaf(tree(LTr, _, RTr), N) :- countLeaf(LTr, LN), countLeaf(RTr, RN), N is LN + RN.

% countLeaf(tree(tree(nil,2,tree(nil,4,nil)),3,tree(nil,5,nil)), Res).
  %Res = 2 .

% countLeaf(tree(nil, 2, tree(tree(nil, 5, tree(nil, 6, tree(nil, 8, nil))),3,nil)), Res).
  %Res = 1

% countLeaf(tree(nil,2,nil),Res).
  %Res = 1



%3.Визначення висоту бінарного дерева.
%Висота бінарного дерева Т:
    %висота порожнього дерева Т рівна H(T)=0;
    %висота непорожнього бінарного дерева Т з батьком та піддеревами Т1 і Т2: H(T)=1+max(H(T1), H(T2)).
% heightB(+Tree, -N).
heightB(nil, 0).
heightB(tree(LTr, _, RTr), N) :- heightB(LTr, LH), heightB(RTr, RH), N is 1 + max(LH, RH).

% heightB(tree(tree(nil,2,tree(nil,4,nil)),3,tree(nil,5,nil)), Res).
  %Res = 3.

% heightB(tree(nil, 2, tree(tree(nil, 5, tree(nil, 6, tree(nil, 8, nil))),3,nil)), Res).
  %Res = 5.

% heightB(nil, Res).
  %Res = 0.


%4.Визначення кількість вузлів у бінарному дереві.
% countNodes(+Tree, -N).
countNodes(nil, 0).
countNodes(tree(LTr, _, RTr), N) :- countNodes(RTr, RN), countNodes(LTr, LN), N is LN + RN + 1.

% countNodes(tree(tree(nil,2,tree(nil,4,nil)),3,tree(nil,5,nil)), Res).
  %Res = 4.

% countNodes(tree(nil, 2, tree(tree(nil, 5, tree(nil, 6, tree(nil, 8, nil))),3,nil)), Res).
  %Res = 5.

% countNodes(nil, Res).
  %Res = 0.



%2-3-дерева

%5.Обходу 2-3-дерева.
% obhid23(+Tree, -List).
obhid23(nil, []).
obhid23(leaf(Value), [Value]).
obhid23(node2(LTr, Value, RTr), List) :- obhid23(RTr, RList), obhid23(LTr, LList), append(LList, [Value|RList], List).
obhid23(node3(LTr, ValL, MTr, ValR, RTr), List) :- obhid23(RTr, RList), obhid23(LTr, LList), obhid23(MTr, MList),
                                                    append(LList, [ValL|MList], LMV), append(LMV, [ValR|RList], List).
% obhid23(nil, Res).
  %Res = [].

% obhid23(node2(leaf(3), 5, leaf(6)), Res).
  %Res = [3, 5, 6].

% obhid23(node2(leaf(3), 5, node3(leaf(6),7,leaf(8),9,leaf(10))), Res).
  %Res = [3, 5, 6, 7, 8, 9, 10].

%6.Пошуку заданого елемента в 2-3-дереві.
% find23(+Tree, +Elem).
find23(nil, _) :- fail.
find23(leaf(Value), Elem) :- Value = Elem.
find23(node2(LTr, Value, RTr), Elem) :- Value = Elem; find23(LTr, Elem); find23(RTr, Elem).
find23(node3(LTr, ValL, MTr, ValR, RTr), Elem) :- ValL = Elem; ValR = Elem;
                                        find23(LTr, Elem); find23(MTr, Elem); find23(RTr, Elem).

% find23(nil, Res).
  %false.

% find23(node2(leaf(3), 5, node3(leaf(6),7,leaf(8),9,leaf(10))), 7).
  %true .

% find23(node2(leaf(3), 5, node3(leaf(6),7,leaf(8),9,leaf(10))), 14).
  %false.

% find23(node2(leaf(3), 5, leaf(6)), 2).
  %false.

% find23(node2(leaf(3), 5, leaf(6)), 6).
  %true.



%Написати програму, яка перевірить чи є заданий об'єкт.

lessEqual(_, []).
lessEqual(Value, [X]) :- Value =< X.
lessEqual(Value, [H|T]) :- Value =< H, lessEqual(Value, T).

greater(_, []).
greater(Value, [X]) :- Value > X.
greater(Value, [H|T]) :- Value > H, greater(Value, T).


%7.бінарним деревом
% checkBinary(+Tree).
checkBinary(nil).
checkBinary(tree(_, nil, _)) :- fail.
checkBinary(tree(_, tree(_, _, _), _)) :- fail.
checkBinary(tree(LTr, Val, RTr)) :- checkBinary(LTr), checkBinary(RTr),
                                    obhid(LTr, LList), greater(Val, LList),
                                    obhid(RTr, RList), lessEqual(Val, RList).

% checkBinary(tree(nil, 2, tree(tree(nil, 5, tree(nil, 6, tree(nil, 8, nil))),3,nil))).
  %false.

% checkBinary(tree(nil, 2, tree(tree(nil, 5, tree(nil, 6, tree(nil, 8, nil))),10,nil))).
  %true.

% checkBinary(tree(nil, 2, tree(tree(nil, 5, tree(nil, 6, tree(nil, nil, nil))),3,nil))).
  %false.


%8.2-3 деревом

% check23(+Tree).
check23(nil).
% leaf check
check23(leaf(nil)) :- fail.
check23(leaf(leaf(_))) :- fail.
check23(leaf(node2(_, _, _))) :- fail.
check23(leaf(node3(_, _, _, _, _))) :- fail.
check23(leaf(_)).
% node2 check
check23(node2(_, nil, _)) :- fail.
check23(node2(_, leaf(_), _)) :- fail.
check23(node2(_, node2(_, _, _), _)) :- fail.
check23(node2(_, node3(_, _, _, _, _), _)) :- fail.
check23(node2(LTr, Val, RTr)) :- check23(LTr), check23(RTr),
                                 obhid23(LTr, LList), greater(Val, LList),
                                 obhid23(RTr, RList), lessEqual(Val, RList).
% node3 check
check23(node3(_, nil, _, _, _)) :- fail.
check23(node3(_, leaf(_), _, _, _)) :- fail.
check23(node3(_, node2(_, _, _), _, _, _)) :- fail.
check23(node3(_, node3(_, _, _, _, _), _, _, _)) :- fail.
check23(node3(_, _, _, nil, _)) :- fail.
check23(node3(_, _, _, leaf(_), _)) :- fail.
check23(node3(_, _, _, node2(_, _, _), _)) :- fail.
check23(node3(_, _, _, node3(_, _, _, _, _), _)) :- fail.
check23(node3(LTr, LVal, MTr, RVal, RTr)) :- LVal < RVal, check23(LTr), check23(MTr), check23(RTr),
                                             obhid23(LTr, LList), greater(LVal, LList),
                                             obhid23(MTr, MList), lessEqual(LVal, MList), greater(RVal, MList),
                                             obhid23(RTr, RList), lessEqual(RVal, RList).

% check23(node2(leaf(3), 5, leaf(6))).
  %true .

% check23(node2(leaf(3), 3, leaf(6))).
  %false.

% check23(node2(leaf(3), 6, leaf(6))).
  %true .

% check23(node2(leaf(3), 5, node3(leaf(6),7,leaf(8),9,leaf(10)))).
  %true .

% check23(node2(leaf(3), 5, node3(leaf(4),7,leaf(8),9,leaf(10)))).
  %false.

