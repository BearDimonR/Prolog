


% Створити невелику базу знань мовою Пролог для вказаної у вашому варіанті предметної області.
% Програма має містити не менше 15 фактів, які описують вказані у завданні відношення,
% та не менше 5 правил,
% що виражають типові запити користувачів (можливі правила наводяться).

%Додати не менше трьох власних правил/запитів.

% Предметна область:
% Мої улюблені фільми.
% Відношення-факти:
    %Фільм (назва, режисер, рік випуску, анотація).
    %Актор (ПІБ, звання, рік народження, місце роботи).
    %Знімався (назва фільму, ПІБ, роль, характеристика ролі).
% Під характеристикою ролі розуміється: головна, епізодична,….

% факти (20)

%film(tenet, cristofernolan, 2020, "factastic action about spies").
%
%film(king, devidmisho, 2019, "historic dramatic film based on plays").
%
%film(superinteligence, benfelkoyn, 2020, "american fantastic film").
%
%actor(mellisamaccarti, professor , 1978, wb).
%actor(benfelkoyn, docent, 1981, wb).
%actor(bobbykannavale, professor, 1984, bbc).
%
%actor(timotishalame, associate, 1995, wb).
%actor(joeledgerton, associate, 1991, hollywood).
%actor(robertpattinson, associate, 1994, hollywood).
%
%actor(johnvashington, docent, 1992, hollywood).
%actor(kennetbrana, professor, 1984, hollywood).
%
%played(tenet, robertpattinson, main, "Nil actor").
%played(tenet, johnvashington, partial, "The Protagonist actor").
%played(tenet, kennetbrana, partial, "Andrei Sator actor").
%
%played(king, robertpattinson, main, "The Dauphin actor").
%played(king, timotishalame, main, "Gel actor").
%played(king, joeledgerton, partial, "Ser John Falstaf actor").
%
%played(superinteligence, mellisamaccarti, main, "Kerol Piters actor").
%played(superinteligence, benfelkoyn, main, "Sharl Koiper actor").
%played(superinteligence, bobbykannavale, partial, "Gourge actor").

% Відношення-правила (6):

%в яких фільмах знімався даний актор;
%actor_film(X, Y) :- played(Y, X, _, _).

%вік акторів, зайнятих на зйомках даного фільму;
%age_actor_film(X, Y) :- played(X, Name, _, _), actor(Name, _, Age, _), Y is (2021 - Age).

%хто з акторів зіграв у заданому фільмі вказану роль;
%role_film(X, Y, Z) :- played(X, Z, Y, _).


% власні правила


% хто з акторів заданого фільму був і його режисером ;
%actor_producer(X, Y) :- film(X, Y, _, _), played(X, Y, _, _).

% в яких фільмах знімалися актори з вказаним званням (з дублікатами);
%rank_film(X, Y) :- actor(Name, X, _, _), played(Y, Name, _, _).

% хто з акторів працює на вказаному місці роботи та старше за вказане число років;
%hollywood20(X, Y, Z) :- actor(Z, _, Age, X), 2021 - Age > Y.