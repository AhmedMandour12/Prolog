domains
	person=symbol

predicates
	likes(person,person)
	
clauses
	likes(ali,apple).
	likes(ahmed,X) :-likes(ali,X).