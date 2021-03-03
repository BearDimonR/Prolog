% Перебір (4б).

% допоміжна функція
fill(-1) :- !.
fill(X):-asserta(d(X)),X1 is X-1,fill(X1).

% У тризначному числi, всi цифри якого непаpнi, закpеслили середню цифру.
% Виявилось, що отpимане двозначне число є дiльником вихiдного числа. Знайдiть всi такi тризначнi числа.
% Перед виконанням треба викликати fill(9).
% Відповідь: 135, 195, 315.

gen3(X):-d(A),
	 A>0,
	 1 is A mod 2,
	 d(B),
	 1 is B mod 2,
	 d(C),
	 1 is C mod 2,
	 X is A*100+B*10 +C,
	 0 is X mod (A*10+C).

% Знайдiть чотиризначне число, яке є точним квадратом, у якого двi першi цифри однаковi та двi останнi також однаковi.
% Перед виконанням треба викликати fill(9). (якщо він не був викликаний до цього)
% Відповідь - 7744. Корінь - 88.

gen4(X):-d(A),
	 A>0,
	 d(B),
         X is A*1000+A*100 + B*10 + B,
         Y is round(sqrt(X)),
         X is Y*Y.

% Скiльки iснує цiлих чисел вiд 1 до 1998, якi не дiляться на жодне з чисел 6, 10, 15?
% Відповідь - 1465.

dodiv(X):- count(X, 1, 0).
count(Sum, Index, Sum) :- Index is 1999, !.
count(X, Index, Sum) :- 0 =\= mod(Index, 6), 0 =\= mod(Index, 10), 0 =\= mod(Index, 15),
                        NSum is Sum + 1, NI is Index + 1, count(X, NI, NSum), !.
count(X, Index, Sum) :- NI is Index + 1, count(X, NI, Sum).

% Знайти найменше натуральне число M, яке має наступну властивiсть:
% сума квадратiв одинадцяти послiдовних натуральних чисел, починаючи з M, є точним квадратом?
% (x+1)^2 .... + (x+10)^2
% Відповідь - 18.

minM(X):-findFirstSqr(Y, 1, 0, 12),dostep(X, 1, Y).
findFirstSqr(Sum, Index, Sum, Last) :- Index is Last, !.
findFirstSqr(Y, Index, Sum, Last) :- NS is Sum + (Index * Index),NI is Index + 1, findFirstSqr(Y,NI, NS, Last).
dostep(Index, Index, Sum) :- Y is round(sqrt(Sum)), Sum is Y*Y, !.
dostep(Y, Index, Sum) :- NIndex is Index + 1, NLast is NIndex + 10,
                         NSum is Sum - (Index * Index) + (NLast * NLast), dostep(Y, NIndex, NSum).

% В послiдовностi 1998737... кождна цифра, починаючи з п'ятої, дорiвнює останнiй цифрi суми чотирьох попеpеднiх цифр.
% Через скiльки цифр знову зустрiнитья початкова комбiнацiя 1998 (тобто скiльки цифр в перiодi)?
% Відповідь - 1560.

period(X) :- findPeriod(X, 1,9,9,8, 0).
findPeriod(Index, 1, 9, 9, 8, Index) :- Index > 0, !.
findPeriod(X, First, Second, Third, Last, Index) :- N is mod(First + Second + Third + Last, 10), NI is Index + 1,
                                                    findPeriod(X, Second, Third, Last, N, NI).