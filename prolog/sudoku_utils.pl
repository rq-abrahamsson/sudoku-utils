:- module(sudoku_utils, [sudoku/1, fill_underscore_string_array/2]).

:- set_prolog_flag(double_quotes, chars).

:- use_module(library(clpfd)).
:- use_module(library(lists)).

sudoku(Rows) :-
	length(Rows, 9), maplist(same_length(Rows), Rows),
	append(Rows, Vs), Vs ins 1..9,
	maplist(all_distinct, Rows),
	transpose(Rows, Columns),
	maplist(all_distinct, Columns),
	Rows = [As,Bs,Cs,Ds,Es,Fs,Gs,Hs,Is],
	blocks(As, Bs, Cs),
	blocks(Ds, Es, Fs),
	blocks(Gs, Hs, Is).

fill_underscore_string(A, A) :-
	number(A),
	!.
fill_underscore_string(_, '_').

fill_underscore_string_array(In, Out) :-
	maplist(fill_underscore_string, In, Out).

sudoku_with_underscore_string(In, Out) :-
	maplist(fill_underscore_string_array, In, Out).

blocks([], [], []).
blocks([N1, N2, N3|Ns1], [N4, N5, N6|Ns2], [N7,N8,N9|Ns3]) :-
	all_distinct([N1,N2,N3,N4,N5,N6,N7,N8,N9]),
	blocks(Ns1, Ns2, Ns3).