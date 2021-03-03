

% Ділення з остачею: % evklid(+Integer, +Integer, -div, -mod).
% Всі Integer. Не використовувати вбудовані арифметичні оператори (функтори): div та mod/

evklid(X, Y, Div, Rem) :- findDiv(X, Y, Div, 1), Rem is X - (Y * Div).
findDiv(X, Y, Index, Index) :- X < Y * (Index + 1), !.
findDiv(X, Y, Div, Index) :- NI is Index + 1, findDiv(X, Y, Div, NI).

% Піднесення до степеню (лінійне та логарифмічне)

% Числа Фібоначчі (ітеративно, не рекурсією).

% Розклад числа на прості множники. % прості(+Integer, -Integer).

% Обрахувати сумму 1/1! + 1/2! + 1/3! + ... 1/n! % ряд(+Integer (N), -Integer).

% Алгоритм Евкліда % evklid(+Integer, +Integer, -Integer).