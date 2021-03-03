
% 1. Напишіть предикат, який перетворює вихідний список у список позицій від'ємних елементів.

% тести:
%
% transform_minus([-4,3,-1,2,4], Y).
% Y = [0, 2].
% transform_minus([-4,0,-1,-1,-2], Y).
% Y = [0, 2, 3, 4].
% transform_minus([2,3,4], Y).
% Y = [].


% transform_minus(+список_чисел, -список_результат).
transform_minus(In, Out):- transform_minus(In, Out, 0, []).

transform_minus([], List, _, List) :- !.
transform_minus([H|T], Out, Counter, List) :- H < 0,
                                                NCounter is Counter + 1,
                                                    append(List, [Counter], NList),
                                                        transform_minus(T, Out, NCounter, NList), !.
transform_minus([_|T], Out, Counter, List) :- NCounter is Counter + 1, transform_minus(T, Out, NCounter, List).


%2. Напишіть предикат, що замінює всі входження заданого елемента на символ change_done.

% тести:
%
% change_symbol('a', `abbcd`, Y).
% Y = "change_donebbcd".

% change_symbol('a', `abbcda`, Y).
% Y = "change_donebbcdchange_done".

% change_symbol('a', `bbd`, Y).
% Y = "bbd".

% change_symbol('b', `bbd`, Y).
% Y = "change_donechange_doned".


% change_symbol(+символ, +вхідна_стрічка, -результуюча_стрічка).
change_symbol(Symbol, In, Out) :- atom_codes(Symbol, [FirstSymbol|_]),
                                    change_symbol(FirstSymbol, In, NOut, []),
                                        string_codes(Out, NOut).
change_symbol(_, [], List, List) :- !.
change_symbol(Symbol, [H|T], Out, List) :- H is Symbol,
                                            append(List, `change_done`, NList),
                                                change_symbol(Symbol, T, Out, NList), !.
change_symbol(Symbol, [H|T], Out, List) :- append(List, [H], NList), change_symbol(Symbol, T, Out, NList).


%3. Напишіть предикат, що перетворює будь-який список арабських чисел (від 1 до 50) у список відповідних їм римських чисел.

% тести:
%
% to_romanian([1, 12, 15, 0, 76, 19, 21, 24, 29], Y).
%  Y = ["I", "XII", "XV", "", "LXXVI", "XIX", "XXI", "XXIV", "XXIX"].
% to_romanian([5,3,87,65,43,23,43], Y).
%  Y = ["V", "III", "LXXXVII", "LXV", "XLIII", "XXIII", "XLIII"].

% to_romanian(+список_чисел, -список_римських_чисел).
to_romanian(In, Out) :- to_romanian(In, Out, []).
to_romanian([], Out, List) :-  to_str(List, Out), !.
to_romanian([H|T], Out, List) :- convert_numb(H, Res),
                                    append(List, [Res], NList),
                                        to_romanian(T, Out, NList).

% перетворює список кодів у стрічку
to_str(In, Out) :- to_str(In, Out, []).
to_str([], List, List) :- !.
to_str([H|T], Out, List) :- string_codes(Str, H), append(List, [Str], NList), to_str(T, Out, NList).

% конвертує число в символ
convert_numb(N, _) :- N < 0, !, fail.
convert_numb(N, _) :- N >= 90, !, fail.
convert_numb(0, []) :- !.
convert_numb(N, Out) :- N < 4, NN is N - 1, convert_numb(NN, Res), append([73], Res, Out), !.
convert_numb(4, [73, 86]) :- !.
convert_numb(5, [86]) :- !.
convert_numb(N, Out) :- N < 9, NN is N - 5, convert_numb(NN, Res), append([86], Res, Out), !.
convert_numb(9, [73, 88]) :- !.
convert_numb(N, Out) :- N < 40, NN is N - 10, convert_numb(NN, Res), append([88], Res, Out), !.
convert_numb(N, Out) :- N < 50, NN is N - 40, convert_numb(NN, Res), append([88, 76], Res, Out), !.
convert_numb(N, Out) :- N < 90, NN is N - 50, convert_numb(NN, Res), append([76], Res, Out), !.


%4. Напишіть предикат, що здійснює циклічний зсув елементів списку на один вправо.

% тести:
%
% shift_cycle([2,3,5,-1], Y).
%  Y = [-1, 2, 3, 5].
% shift_cycle([4,5], Y).
%  Y = [5, 4].
% shift_cycle([4], Y).
%  Y = [4].

% shift_cycle(+список_входу, -список_результат).
shift_cycle([], []) :- !.
shift_cycle(In, Out) :- reverse(In, [Last|NList]),  reverse(NList, Res), append([Last], Res, Out).

%5. Напишіть предикат, що реалізує множення матриці (список списків) на вектор.

% тести:
%
% mult_vec([[1,0],[-1,-3],[2,1]], [2,1,0], Y).
% Y = [1, -3].

% mult_vec([[1,2,4],[3,4,4]], [2,2], Y).
% Y = [8, 12, 16].

% mult_vec([[1,2,3], [1,2,2]], [1,2], Y).
% Y = [3, 6, 7].

% mult_vec([[1,2,3], [1,2,2], [1,2,2]], [1,2], Y).
% false.

% mult_vec([[1,2,3], [1,2,2]], [1,2,3], Y).
% false.


% mult_vec(+матриця_m_n, +вектор_m, -результат_множення).
mult_vec(Matrix, Vector, Out) :- mult_to_vec(Matrix, Vector, Res), sum_matrix(Res, Out).

% сумує вектори матриці
sum_matrix(In, Out) :- sum_matrix(In, Out, []).
sum_matrix([], List, List) :- !.
sum_matrix([H|T], List, []) :- sum_matrix(T, List, H), !.
sum_matrix([H|T], Out, List) :- sum_vector(H, List, NList), sum_matrix(T, Out, NList).

% сумує 2 вектори
sum_vector(In, Vect, Out) :- sum_vector(In, Vect, Out, []).
sum_vector([], [], List, List) :- !.
sum_vector([], _, _, _) :- fail.
sum_vector(_, [], _, _) :- fail.
sum_vector([H|T], [H1|T1], Out, List) :- SUMH is H + H1, append(List, [SUMH], NList), sum_vector(T, T1, Out, NList).

% множить матрицю на вектор (не сумуючи)
mult_to_vec(Matrix, Vector, Out) :- mult_to_vec(Matrix, Vector, Out, []).
mult_to_vec([], [], NMatrix, NMatrix) :- !.
mult_to_vec([], _, _, _) :- fail.
mult_to_vec(_, [], _, _) :- fail.
mult_to_vec([MH|MT], [VH|VT], Out, NMatrix) :- mult_by_numb(MH, VH, NMH),
                                                append(NMatrix, [NMH], NNMatrix),
                                                    mult_to_vec(MT, VT, Out, NNMatrix).

% множить вектор на число
mult_by_numb(MH, VH, NMH) :- mult_by_numb(MH, VH, NMH, []).
mult_by_numb([], _, List, List).
mult_by_numb([H|T], VH, NMH, List) :- NH is H * VH, append(List, [NH], NList), mult_by_numb(T, VH, NMH, NList).