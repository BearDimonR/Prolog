
/****************************************************************/
/* This module includes some routines which are used in nearly  */
/* all menu and screen tools.					*/
/****************************************************************/

/****************************************************************/
/*		repeat						*/
/****************************************************************/

PREDICATES
  nondeterm repeat

CLAUSES
  repeat.
  repeat:-repeat.


/****************************************************************/
/*		miscellaneous					*/
/****************************************************************/

PREDICATES
  maxlen(STRINGLIST,COL,COL)		/* The length of the longest string */
  listlen(STRINGLIST,ROW)		/* The length of a list		    */
  writelist(ROW,COL,STRINGLIST)		/* used in the menu predicates	    */
  reverseattr(ATTR,ATTR)		/* Returns the reversed attribute   */
  min(ROW,ROW,ROW) min(COL,COL,COL) min(LEN,LEN,LEN) min(INTEGER,INTEGER,INTEGER)
  max(ROW,ROW,ROW) max(COL,COL,COL) max(LEN,LEN,LEN) max(INTEGER,INTEGER,INTEGER)

CLAUSES
  maxlen([H|T],MAX,MAX1) :-
	str_len(H,LENGTH),
	LENGTH>MAX,!,
	maxlen(T,LENGTH,MAX1).
  maxlen([_|T],MAX,MAX1) :- maxlen(T,MAX,MAX1).
  maxlen([],LENGTH,LENGTH).

  listlen([],0).
  listlen([_|T],N):-
	listlen(T,X),
	N=X+1.

  writelist(_,_,[]).
  writelist(LI,ANTKOL,[H|T]):-
	field_str(LI,0,ANTKOL,H),
	LI1=LI+1,
	writelist(LI1,ANTKOL,T).

  min(X,Y,X):-X<=Y,!.
  min(_,X,X).

  max(X,Y,X):-X>=Y,!.
  max(_,X,X).

  reverseattr(A1,A2):-
	bitand(A1,$07,H11),
	bitleft(H11,4,H12),
	bitand(A1,$70,H21),
	bitright(H21,4,H22),
	bitand(A1,$08,H31),
	A2=H12+H22+H31.


/****************************************************************/
/*	Find letter selection in a list of strings		*/
/*      Look initially for first uppercase letter.		*/
/*      Then try with first letter of each string.		*/
/****************************************************************/

PREDICATES
  upc(CHAR,CHAR)  lowc(CHAR,CHAR)
  try_upper(CHAR,STRING)
  tryfirstupper(CHAR,STRINGLIST,ROW,ROW)
  tryfirstletter(CHAR,STRINGLIST,ROW,ROW)
  tryletter(CHAR,STRINGLIST,ROW)

CLAUSES
  upc(CHAR,CH):-
	CHAR>='a',CHAR<='z',!,
	char_int(CHAR,CI), CI1=CI-32, char_int(CH,CI1).
  upc(CH,CH).

  lowc(CHAR,CH):-
	CHAR>='A',CHAR<='Z',!,
	char_int(CHAR,CI), CI1=CI+32, char_int(CH,CI1).
  lowc(CH,CH).

  try_upper(CHAR,STRING):-
	frontchar(STRING,CH,_),
	CH>='A',CH<='Z',!,
	CH=CHAR.
  try_upper(CHAR,STRING):-
	frontchar(STRING,_,REST),
	try_upper(CHAR,REST).

  tryfirstupper(CHAR,[W|_],N,N) :-
	try_upper(CHAR,W),!.
  tryfirstupper(CHAR,[_|T],N1,N2) :-
	N3 = N1+1,
	tryfirstupper(CHAR,T,N3,N2).

  tryfirstletter(CHAR,[W|_],N,N) :-
	frontchar(W,CHAR,_),!.
  tryfirstletter(CHAR,[_|T],N1,N2) :-
	N3 = N1+1,
	tryfirstletter(CHAR,T,N3,N2).

  tryletter(CHAR,LIST,SELECTION):-
	upc(CHAR,CH),tryfirstupper(CH,LIST,0,SELECTION),!.
  tryletter(CHAR,LIST,SELECTION):-
	lowc(CHAR,CH),tryfirstletter(CH,LIST,0,SELECTION).



/*****************************************************************/
/* adjustwindow takes a windowstart and a windowsize and adjusts */
/* the windowstart so the window can be placed on the screen.	 */
/* adjframe looks at the frameattribute: if it is different from */
/* zero, two is added to the size of the window			 */
/****************************************************************/

PREDICATES
  adjustwindow(ROW,COL,ROW,COL,ROW,COL)
  adjframe(ATTR,ROW,COL,ROW,COL)

CLAUSES
  adjustwindow(LI,KOL,DLI,DKOL,ALI,AKOL):-
		LI<25-DLI,KOL<80-DKOL,!,ALI=LI,AKOL=KOL.
  adjustwindow(LI,_,DLI,DKOL,ALI,AKOL):-
		LI<25-DLI,!,ALI=LI,AKOL=80-DKOL.
  adjustwindow(_,KOL,DLI,DKOL,ALI,AKOL):-
		KOL<80-DKOL,!,ALI=25-DLI, AKOL=KOL.
  adjustwindow(_,_,DLI,DKOL,ALI,AKOL):-
		ALI=25-DLI, AKOL=80-DKOL.

  adjframe(0,R,C,R,C):-!.
  adjframe(_,R1,C1,R2,C2):-R2=R1+2, C2=C1+2.


/****************************************************************/
/* 			Readkey					*/
/* Returns a symbolic key from the KEY domain		        */
/****************************************************************/

PREDICATES
  readkey(KEY)
  readkey1(KEY,CHAR,INTEGER)
  readkey2(KEY,INTEGER)

CLAUSES
  readkey(KEY):-readchar(T),char_int(T,VAL),readkey1(KEY,T,VAL).

  readkey1(KEY,_,0):-!,readchar(T),char_int(T,VAL),readkey2(KEY,VAL).
  readkey1(cr,_,13):-!.
  readkey1(esc,_,27):-!.
  readkey1(break,_,3):-!.
  readkey1(tab,_,9):-!.
  readkey1(bdel,_,8):-!.
  readkey1(ctrlbdel,_,127):-!.
  readkey1(char(T),T,_) .
  
  readkey2(btab,15):-!.
  readkey2(del,83):-!.
  readkey2(ins,82):-!.
  readkey2(up,72):-!.
  readkey2(down,80):-!.
  readkey2(left,75):-!.
  readkey2(right,77):-!.
  readkey2(pgup,73):-!.
  readkey2(pgdn,81):-!.
  readkey2(end,79):-!.
  readkey2(home,71):-!.
  readkey2(ctrlleft,115):-!.
  readkey2(ctrlright,116):-!.
  readkey2(ctrlend,117):-!.
  readkey2(ctrlpgdn,118):-!.
  readkey2(ctrlhome,119):-!.
  readkey2(ctrlpgup,132):-!.
  readkey2(fkey(N),VAL):- VAL>58, VAL<70, N=VAL-58, !.
  readkey2(fkey(N),VAL):- VAL>=84, VAL<104, N=11+VAL-84, !.
  readkey2(otherspec,_).
