% FOR BEST VIEW USE Courier FONT in Notpad to MIMIC the Prolog ENVIRONMENT
%-------------------------------------------------------------------------

%------------------------ PROJECT OBJECTIVE-----------------
% Native shell.
% top_goal where Native starts the inference.
%------------------------------------------------------------


Domains

file= myfile1; myfile2
S = string
list=S*

Database
known(S,S)


Predicates
	%---------declare the user-defined Clauses----------%
	
top_goal(S)
menuask(S,S,list)
multivalued(S)
writelist(list)
solve
	%---------------------------------------------------%


Clauses

top_goal(X) :- bird(X).

% Write your Production Rules Here %
%-----------------------------------------------------------------------

% Stick to the following Format
% ------------------------------

% menuask has 3 argument ( Attribute name, Attribute value, Alternative values )
%	menuask("color" , "white" , [red,blue,white] ),

% if there is no Alternative values, the Attribute value is attached to Attribute name ,
%	menuask("color : white", yes , [yes, no])

% Each identified Object (Result) has one or more RULEs
% The conclusion put in the 1st argument at the last subgoal 
% 		as  ' menuask("Result", "",[ ]).  '
% Result = e.g., Bird is Malar, Recommend: Plug in , Problem is Monitor


/*************************************************************************
*************************PRODUCTION RULES SAMPLES*************************
**************************************************************************
bird(fulmar) :-
	order(tubenose),
	menuask("size","medium",[large,medium,small]),	% MULTI-VALUED
	menuask("sound:loud", yes ,[yes,no]),		% SINGLE-VALUED
	menuask("fulmar","",[ ]).

order(tubenose) :-
	menuask("nostril","external_tubularl",[external_tubular,OTHER]),
	menuask("live","at_sea",[at_sea, other]),
	menuask("bill","hooked, flat, sharp_hooked, short, other]),


problem("bad battery"):-
	menuask("motor turn over : yes", yes, [yes,no]),
	menuask("light is weak", "weak", [weak,strong]).	
	menuask("bad_battery", "", [ ]).	
**************************************************************************
*************************************************************************/


% Initially, I suppose that All Attributes are Single-valued

multivalued("").	% all attributes are initially Single-valued as "" not existed attribute
			% just added "" to prevent Error MSG"No clauses defined"

			% when need to Exclude an atrribute as mutli-valued,
			% just add multivalued("attributeName")

%-----------------------------------------------------------------------------\
% handle Single-Valued Attributes,check for existing alternative answered value|
%-----------------------------------------------------------------------------/
% if Size is single-valued, So no need to ask the User if there is a pervious answered value

menuask(A, V, _):-			% handle Single_valued Attribute
	not(multivalued(A)), 		% that's a single-value attribute
	known(A, V2), 			% another value of the same Attribute
	!, V = V2.			% fail if other value true


	
%-----------------------------------------------------------------------------\
% handle Multi-valued,check if the value already answered, or ask for the value|
%-----------------------------------------------------------------------------/
% e.g., if Size attribute is multi-valued, 
% So it may be have alternatives values "large"or"small" refer to the same object
	

menuask(A, V, _):-
	known(A, V),!.		% succeed if the value Previously answered

menuask(A, V, MenuList) :-	% if the Attribute is the first time Asked

%----------------------------------------------------------------\
% --- Uncomment the following when using Prolog output Screen ---|
%----------------------------------------------------------------/
	%--------------------------------------------------------------\
	% ------------- Use Prolog Interface------------------|
	%--------------------------------------------------------------/
/*******************************************************************************
%	prompt(A,P),		% for Meangingful Description of the Attribute
%	nl, write(P), nl,	% display the Meangingful Description

				% check it's Attribute or Result
	notEmpty(MenuList),	% that's not Result as it has alternative values

	nl, write(A), nl,
	write("-------------------"), nl,
	writeList(MenuList), nl,	
	readln(X),
	check_val(X, A, V, MenuList),	% check spelling
	asserta( known(A, X) ),	% save (remember) the True or False answer
	X = V.			
*******************************************************************************/

	%----------------------------------------------------------------\
	% ---------------- Use external interface such C#  ---------------|
	%----------------------------------------------------------------/

	openwrite(myfile1,"Quest.txt"),
	writedevice(myfile1),
	write(A),
	nl,
	
	openwrite(myfile2,"Menue.txt"),
	writedevice(myfile2),
	writelist(MenuList),
	
	closefile(myfile1),
	closefile(myfile2),
	exit.			% exit , to enable C# manipulate the data


menuask(_, "", []) :- !.	% handle the Result , when notEmpty is False

%----------------------------------------------------------------\
% --- Uncomment the following when using Prolog output Screen ---|
%----------------------------------------------------------------/
/******************************************************************************
check_val(X, _, _, MenuList) :-
	member(X, MenuList), !.

check_val(X, A, V, MenuList) :-
	write(X," is not a legal value, try again."), nl,
	menuask(A, V, MenuList), Fail.		% ignore stack frame subgoals

notEmpty([]):- !, fail.
notEmpty(_).
*******************************************************************************/

writelist([]):-!.
writelist([H|T]):-
	write(H), nl,
	writelist(T).


member(X,[X|_]):-!.
member(X,[_|T]):-
	member(X,T).

solve:-
	consult("Readkn.txt"),
	top_goal(X),
	!,
	write("The Answer is : ",X),
	nl,
	retractall(known(_,_)).

solve:-
	write("No answer Please try again....")	,
	nl,
	retractall(known(_,_)).

GOAL
	solve.

%---------------------------------------------------------------\
% --- Uncomment the following when using Prolog output Screen ---|
%---------------------------------------------------------------/
/***********************************************************************
top_goal(X),nl,
write("The Conclusion is ",X),nl.
***********************************************************************/




% -- Delete my CopyRight if you 'll using my Code without Refering to me ---%
%--------------------------------------------------------------------------\
% ----------- Coded by Programmer : Muhammad Haggag Zayan-------------------|
% -------------------------- 7:30 AM 29/11/2007 ----------------------------|
%--------------------------------------------------------------------------/
