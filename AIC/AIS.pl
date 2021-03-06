%worker(id,pib(name,surname,lastname),[phone(type,number)],email,birth(dd,mm,yyyy),position,[rewards]).
worker(1,pib("Vadym","Juk","Sergiyovych"),phone(undefined,defined(mobile,"380958895160")),"juk@ukma.ed.ua",birth(30,01,2001),"Director",["Golden medal","15YearsExperience","Honored employee"]).
worker(2,pib("Alex","Vlasenko","Sergiyovych"),phone(defined(landline,"0442931212"),undefined),"beliy@ukr.net",birth(10,02,1993),"Manager",["5YearExperience","Best employee 2019"]).
worker(3,pib("Sergiy","Prytula","Tarasovych"),phone(defined(landline,"0442321233"),defined(mobile,"380660209907")),"dimon@mail.ru",birth(14,08,1978),"CSS",[]).
worker(4,pib("Dmytro","Plyatsok","Romanovych"),phone(phone(defined(landline,"0531223232"),undefined)),"plyats.dim@yahoo.com",birth(03,07,1995),"CSS",["1YearExperience"]).
worker(5,pib("Egor","Malkov","Viktorovych"),phone(phone(undefined,defined(mobile,"380993231122"))),"malyok@mem.pro",birth(03,03,1993),"Trainee",[]).


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

% не треба, ключі працівника і клієнтів додані до реляції сервіс
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
worker_service(1, 5).
worker_service(2, 3).


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
entity_client(e1,phone(defined(landline,"0443291123"),undefined),"luxoft@gmail.com","Luxoft",pib("Jane","Smith",_),32855961).
entity_client(e2,phone(defined(landline,"0322235678"),defined(mobile,"380543235543")),"akhmetov@yahoo.com","DTEK",pib("Ramzan","Kadyrov","Akhmatovych"),22813372).
entity_client(e3,phone(defined(landline,"0762256784"),undefined),"apply@sportlife.kiyv.ua","Sportlife",pib("Ruslan","Shudra","Gennadiyovych"),13134532).
entity_client(e4,phone(defined(landline,"0323346578"),undefined),"naukma@gmail.com","NAUKMA",pib("Andriy","Glybovets","Mykolayovych"),86754231).





% усі ті та тільки ті
% знайти усі послуги, що не опрацьовуються працівниками, та тільки ті, що мають загальну вартість > In
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
опрацьовує_послугу(WorkerId, замовлено_клієнтом(ServiceId, ClientId)) :- service(ServiceId, ClientId, _, _, _), worker_service(WorkerId, ServiceId).


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