%worker(id,pib(name,surname,lastname),[phone(type,number)],email,birth(dd,mm,yyyy),position,[rewards]).
worker(1,pib("Vadym","Juk","Sergiyovych"),phone(undefined,defined(mobile,"380958895160")),"juk@ukma.ed.ua",birth(30,01,2001),"CSS",["Golden medal","15YearsExperience","Honored employee"]).
worker(2,pib("Alex","Vlasenko","Sergiyovych"),phone(defined(landline,"0442931212"),undefined),"beliy@ukr.net",birth(10,02,1993),"Manager",["5YearExperience","Best employee 2019"]).
worker(3,pib("Sergiy","Prytula","Tarasovych"),phone(defined(landline,"0442321233"),defined(mobile,"380660209907")),"dimon@mail.ru",birth(14,08,1978),"CSS",[]).
worker(4,pib("Dmytro","Plyatsok","Romanovych"),phone(phone(defined(landline,"0531223232"),undefined)),"plyats.dim@yahoo.com",birth(03,07,1995),"CSS",["1YearExperience"]).
worker(5,pib("Egor","Malkov","Viktorovych"),phone(phone(undefined,defined(mobile,"380993231122"))),"malyok@mem.pro",birth(03,03,1993),"Trainee",[]).
worker(6,pib("Dmytro","Miedv","Ginadievich"),phone(phone(undefined,defined(mobile,"380965431223"))),"emailmem@mem.pro",birth(20,03,2001),"Junior",[]).


%service(id,client_id,type,price,date(dd,mm,yyyy)).
service(1,i3,"Hiring",2000,date(02,02,2021)).
service(2,i1,"Job finding",300,date(01,12,2020)).
service(3,e2,"Hiring",4000,date(09,07,2020)).
service(4,i2,"Salary estimate",100,date(03,12,2020)).
service(5,e4,"Hiring",3000,date(28,01,2021)).
service(6,i1,"Job finding",250,date(14,02,2021)).
service(7,i1,"Job finding",430,date(20,11,2020)).
service(8,e3,"Hiring",1200,date(14,12,2020)).
service(9,e2,"Project labor costs",8900,date(23,01,2021)).
service(10,e1,"Project labor costs",4650,date(17,10,2020)).

% worker_service(worker_id,service_id).
worker_service(1, 1).
worker_service(3, 1).
worker_service(1, 3).
worker_service(3, 4).
worker_service(2, 2).
worker_service(1, 5).
worker_service(4, 7).
worker_service(5, 10).
worker_service(3, 10).
worker_service(2, 6).
worker_service(2, 3).
worker_service(6, 1).
worker_service(6, 3).
worker_service(6, 5).

% options(service_id,descryption,price).
options(3,"Training",6500).
options(3,"Additional consulting",340).
options(6,"CV",50).
options(9,"Training",1450).
options(4,"Varanty",120).


%individual_client(id,[phone(type,number)],email,pib(name,surname,lastname),birth(dd,mm,yyyy)).
individual_client(i1,phone(defined(landline,"0324723232"),defined(mobile,"380663021344")),"vasyok@ukr.net",pib("Vasyl","Loychuk","Dmytrovych"),birth(09,05,2001)).
individual_client(i2,phone(defined(landline,"0443282356"),defined(mobile,"380503222281")),"sanchooo@ukr.net",pib("Alexander","Makedonsky","Tarasovych"),birth(02,10,1993)).
individual_client(i3,phone(undefined,defined(mobile,"380958882121")),"alex.ilushin@gmail.com",pib("Alex","Ilushin","Pavlovych"),birth(15,11,1986)).


%entity_client(id,[phone(type,number)],email,org_name,pib(name,surname,lastname),code).
entity_client(e1,phone(defined(landline,"0443291123"),undefined),"luxoft@gmail.com","Luxoft",pib("Jane","Smith",""),32855961).
entity_client(e2,phone(defined(landline,"0322235678"),defined(mobile,"380543235543")),"akhmetov@yahoo.com","DTEK",pib("Ramzan","Kadyrov","Akhmatovych"),22813372).
entity_client(e3,phone(defined(landline,"0762256784"),undefined),"apply@sportlife.kiyv.ua","Sportlife",pib("Ruslan","Shudra","Gennadiyovych"),13134532).
entity_client(e4,phone(defined(landline,"0323346578"),undefined),"naukma@gmail.com","NAUKMA",pib("Andriy","Glybovets","Mykolayovych"),86754231).




% запити

% «ті» (принаймні один та можливо і інші).
% знайти тих працівників, що навадали хоч б одну послугу що і працівнико Х у дату У
% workers_provided_at_least_one_service(+X,+Y,-Z). X - піб працівника, Y - дата надання послуги, Z - список ПІБ працівників.
% Приклад запиту:  workers_provided_at_least_one_service(pib("Vadym","Juk","Sergiyovych"),date(02,02,2021),Z).
% Має повернути: Z = [(3, pib("Sergiy", "Prytula", "Tarasovych")),  (6, pib("Dmytro", "Miedv", "Ginadievich"))].
workers_provided_at_least_one_service(X,Y,Z):- findall(
                                                    (SId),
                                                        (service(SId,_,_,_,Y),
                                                        worker_service(WId,SId),
                                                        worker(WId,X,_,_,_,_,_)),
                                                    ServicesX),
                                             findall(
                                                 (Id,pib(Name,Surname,Lastname)),
                                                    (worker(Id,pib(Name,Surname,Lastname),_,_,_,_,_),
                                                    worker_service(Id,SSId),
                                                    (service(SSId,_,_,_,_),
                                                     worker(WId,X,_,_,_,_,_),
                                                     Id =\= WId,
                                                     member(SSId,ServicesX))),
                                                 Z).

% «тільки ті» (хоча б один, а інші ні).
% Знайти тих працівників, що надавали послуги тільки тим клієнтам, що і працівник Х.
% find_workers_services_same_clients(+X,-Y). Х - ПІБ працівника, Y - відповідний список
% Приклад запиту: find_workers_services_same_clients(pib("Vadym","Juk","Sergiyovych"),Y).
% Результат: Y = [(6, pib("Dmytro", "Miedv", "Ginadievich"))].
find_workers_services_same_clients(X,Y):- findall(
                                              CLId,
                                                    (service(SId,CLId,_,_,_),
                                                    worker(WId,X,_,_,_,_,_),
                                                    worker_service(WId,SId)),
                                              ClientsX),
                                          findall(
                                                (Id,pib(Name,Surname,Lastname)),
                                                    (worker(Id,pib(Name,Surname,Lastname),_,_,_,_,_),
                                                    findall(CCLId,(service(SSId,CCLId,_,_,_),worker_service(Id,SSId)),ClientsY),
                                                    worker(WId,X,_,_,_,_,_),
                                                    WId =\= Id,
                                                    sublist(ClientsY,ClientsX)),
                                                Res),
                                          sort(Res,Y).

% «усі ті», можливо і інші.
% знайти юридичних клієнтів, що працювали з усіма тими працівниками, що і фізичний клієнт Х
% find_(+X,-Y). X - піб фізичного клієнта, Y - список юридичних клієнтів
% Приклад запиту: find_entity_clients_worked_with_same(pib("Alexander","Makedonsky","Tarasovych"),Y).
% Має повернути: Y = [(e1, pib("Jane", "Smith", ""))].
find_entity_clients_worked_with_same(X,Y):- findall(
                                                 WId,
                                                     (service(SId,CLId,_,_,_),
                                                     individual_client(CLId,_,_,X,_),
                                                     worker_service(WId,SId)),
                                                 WorkersX),
                                            findall(
                                                (Id,pib(Name,Surname,Lastname)),
                                                (entity_client(Id,_,_,_,pib(Name,Surname,Lastname),_),
                                                findall(
                                                     WId,
                                                     (service(SId,Id,_,_,_),
                                                     worker_service(WId,SId)),
                                                WorkersY),
                                                sublist(WorkersX,WorkersY)),Y).




% знайти ПІБ тих працівників, що надавали послуги Х за ціною більше за Y (можливо і інші).
% (Приклад використання - для нарахування бонусів до зарплати співробітників)
% workers_provided_expensive_services(+X,+Y,-Z). X - назва послуги, Y - порогова ціна, Z - список ПІБ працівників.
% Приклад запиту: workers_provided_expensive_services("Hiring",3000,Y).
% Має повернути: Y = [pib("Alex", "Vlasenko", "Sergiyovych"), pib("Dmytro", "Miedv", "Ginadievich"), pib("Vadym", "Juk", "Sergiyovych")].

workers_provided_expensive_services(X,Y,Z):- findall(SId,(service(SId,_,X,Price,_),Price>Y),Services),
                                             findall(
                                                 pib(Name,Surname,Lastname),
                                                 (worker(WId,pib(Name,Surname,Lastname),_,_,_,_,_),
                                                    worker_service(WId,SSId),
                                                    (service(SSId,_,_,_,_),
                                                    member(SSId,Services))),
                                                 Res),
                                             sort(Res,Z).


% знайти номери мобільних телефонів (якщо надали, + піб для фізичних осіб, +піб та назва організації для юридичних) тільки тих клієнтів, які замовляли послуги за Х рік.
% (Приклад використання - для розсилки опитування щодо якості наданих послуг, надання знижки)
% find_active_customers_mobiles(+X,-Y). Х - заданий рік, Y - відповідний список
% Приклад запиту: find_active_customers_mobiles(2020,Y).
% Результат: Y = [("380503222281", "Alexander", "Makedonsky", "Tarasovych"),  ("380543235543", "Ramzan", "Kadyrov", "Akhmatovych", "DTEK"),  ("380663021344", "Vasyl", "Loychuk", "Dmytrovych")].
% У результат попали клієнти, що робили замовлення у 2020 році та мають вказаний мобільний телефон, для юридичних осіб також додається назва організації.
find_active_customers_mobiles(X,Y):- findall(SId,(service(SId,_,_,_,date(_,_,Year)),X==Year),Services),
                                     findall(CId,(service(SSId,CId,_,_,_),member(SSId,Services)),Customers),
                                     findall(
                                         (CNumber,Name,Surname,Lastname),
                                         (individual_client(ICId,phone(_,defined(mobile,CNumber)),_,pib(Name,Surname,Lastname),_),member(ICId,Customers)),
                                         CNumbers),
                                     findall(
                                         (ENumber,Name,Surname,Lastname,OrgName),
                                         (entity_client(ECId,phone(_,defined(mobile,ENumber)),_,OrgName,pib(Name,Surname,Lastname),_),member(ECId,Customers)),
                                         ENumbers),
                                     append(CNumbers,ENumbers,Res),
                                     sort(Res,Y).



% «усі ті», можливо і інші.
% знайти ід співробітників, що надавав усі ті (а може й інші) послуги, що надає співробітник з ід Х, та мають таку ж посаду.
% (Приклад використання - для підміни працівника Х іншим працівником, що має відповідні навички та посаду)
% find_same_workers(+X,-Y). X - ід працівника, Y - співробітники, здатні "замінити" Х
% Приклад запиту: find_same_workers(1,Y).
% Має повернути: Y = [3].  -- оскільки робітник з ід 3 має ту ж посаду, та ширший спектр послуг, що включає послуги робітника 1.
find_same_workers(X,Y):- findall(
                             SName,
                             (service(SId,_,SName,_,_),worker_service(X,SId)),
                             Tmp),
                         sort(Tmp,Services),
                         worker(X,_,_,_,_,RequiredPosition,_),
                         findall(WId,
                            (worker(WId,_,_,_,_,Position,_),X=\=WId,Position==RequiredPosition,findall(
                                                                                                    SName,
                                                                                                    (service(SId,_,SName,_,_),worker_service(WId,SId)),
                                                                                                    CurServices),
                            sublist(Services,CurServices)),
                            Y).

sublist( [], _ ).
sublist( [X|XS], [X|XSS] ) :- sublist( XS, XSS ).
sublist( [X|XS], [_|XSS] ) :- sublist( [X|XS], XSS ).



% усі ті та тільки ті
% знайти співробітників, які обслуговують тих та тільки тих клієнтів що і співробітник Х
% find_clients(+In, -Res). - In - ід працівника, Res - список працівників
find_clients(In, Res) :- findall(M, worker_service(In, M), Y), clients(Y, Out, []),
                            findall(M, worker(M, _, _, _, _, _ , _), Workers),
                            check_workers(In, Out, Workers, Ans, []),
                            allinfo(Ans, Res, []).

allinfo([], List, List).
allinfo([H|T], Res, List) :- worker(H, N, K, L, M, O, P) , allinfo(T, Res, [worker(H, N, K, L, M, O, P) |List]).

check_workers(_, _, [], Res, Res).
check_workers(In, Clients, [In|T], Res, List) :- check_workers(In, Clients, T, Res, List), !.
check_workers(In, Clients, [H|T], Res, List) :- findall(M, worker_service(H, M), Y), clients(Y, Out, []),
                                                   Clients = Out,
                                                   check_workers(In, Clients, T, Res, [H|List]), !.
check_workers(In, Clients, [_|T], Res, List) :- check_workers(In, Clients, T, Res, List).


clients([], Res, List) :- sort(List, Res).
clients([H|T], Res, List) :- service(H, Client, _, _, _), clients(T, Res, [Client|List]).


% тестування
% find_clients(1, Res).
  %Res = [worker(6, pib("Dmytro", "Miedv", "Ginadievich"), phone(phone(undefi
  %ned, defined(mobile, "380965431223"))), "emailmem@mem.pro", birth(20, 3, 2
  %001), "Junior", [])].
% Працівник 6 працює з тими ж клієнтами (і тільки ними)





% знайти усі послуги, що не опрацьовуються працівниками, та тільки ті, що мають загальну вартість > In
% Можна використовувати у пріоритетизації опрацювання послуг.
% find_services(+In, -Res) :- !.
find_services(In, Res) :- findall(M, service(M, _, _, _, _), Y), check(Y, Out, []), moreIn(Out, In, Res, []).

check([], List, List).
check([H|T], Res, List) :- worker_service(_, H), check(T, Res, List), !.
check([H|T], Res, List) :- check(T, Res, [H|List]), !.

moreIn([], _, List, List).
moreIn([H|T], In, Res, List) :- service(H, _, _, Money, _),
                                findall(M, options(H, _, M), Opt),
                                    list_sum(Opt, Sum),
                                     Total is Sum + Money,
                                      Total > In,
                                        moreIn(T, In, Res, [H|List]), !.
moreIn([_|T], In, Res, List) :- moreIn(T, In, Res, List).

list_sum([], 0).
list_sum([Item], Item).
list_sum([Item1,Item2 | Tail], Total) :-
    list_sum([Item1+Item2|Tail], Total).


% тестування

% не опрацьовуються працівниками - вартість загальна
% 8 - 1200
% 9 - 10350
%
% find_services(1000, Out).
  %Out = [8, 9].
  %
  %7 ?- find_services(1200, Out).
  %Out = [9].
  %
  %8 ?- find_services(1199, Out).
  %Out = [8, 9].



% оператор
% хто опрацьовує послугу Х замовлено Y клієнтом

:- op(200,xfy,'замовлено_клієнтом').
:- op(300,xfx,'опрацьовує_послугу').

% опрацьовує_послугу(?WorkerId, замовлено_клієнтом(?ServiceId, ?ClientId))
опрацьовує_послугу(WorkerId, замовлено_клієнтом(ServiceId, ClientId)) :- service(ServiceId, ClientId, _, _, _),
                                                    worker_service(WorkerId, ServiceId).


% тестування

% ?- Хто опрацьовує_послугу 4 замовлено_клієнтом i2.
 %Хто = 3.
 %
% ?- 3 опрацьовує_послугу Яку_послугу замовлено_клієнтом i2.
 %Яку_послугу = 4.
 %
% ?- 3 опрацьовує_послугу 4 замовлено_клієнтом Яким.
 %Яким = i2.


 % Загальний вивід

 % Робітник опрацьовує_послугу Послуга замовлено_клієнтом Клієнт.
    %Робітник = Послуга, Послуга = 1,
    %Клієнт = i3 ;

    %Робітник = 3,
    %Послуга = 1,
    %Клієнт = i3 ;

    %Робітник = Послуга, Послуга = 2,
    %Клієнт = i1 ;

    %Робітник = 1,
    %Послуга = 3,
    %Клієнт = e2 ;

    %Робітник = 2,
    %Послуга = 3,
    %Клієнт = e2 ;

    %Робітник = 3,
    %Послуга = 4,
    %Клієнт = i2 ;

    %Робітник = 1,
    %Послуга = 5,
    %Клієнт = e4 ;

    %Робітник = 1,
    %Послуга = 5,
    %Клієнт = e4 ;

    %Робітник = 2,
    %Послуга = 6,
    %Клієнт = i1 ;

    %Робітник = 4,
    %Послуга = 7,
    %Клієнт = i1 ;

    %Робітник = 4,
    %Послуга = 8,
    %Клієнт = e3 ;

    %Робітник = 2,
    %Послуга = 8,
    %Клієнт = e3 ;

    %Робітник = 5,
    %Послуга = 9,
    %Клієнт = e2 ;

    %Робітник = 4,
    %Послуга = 9,
    %Клієнт = e2 ;

    %Робітник = 5,
    %Послуга = 10,
    %Клієнт = e1 ;

    %Робітник = 3,
    %Послуга = 10,
    %Клієнт = e1.