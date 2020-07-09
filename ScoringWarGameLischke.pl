shuffle(D) :-
    shuffledeck([[2, diamonds],[3, diamonds],[4, diamonds],[5, diamonds],[6, diamonds],[7, diamonds],[8, diamonds],[9, diamonds],[10, diamonds],[j, diamonds],[q, diamonds],[k, diamonds],[a, diamonds],[2, clubs],[3, clubs],[4, clubs],[5, clubs],[6, clubs],[7, clubs],[8, clubs],[9, clubs],[10, clubs],[j, clubs],[q, clubs],[k, clubs],[a, clubs],[2, spades],[3, spades],[4, spades],[5, spades],[6, spades],[7, spades],[8, spades],[9, spades],[10, spades],[j, spades],[q, spades],[k, spades],[a, spades],[2, hearts],[3, hearts],[4, hearts],[5, hearts],[6, hearts],[7, hearts],[8, hearts],[9, hearts],[10, hearts],[j, hearts],[q, hearts],[k, hearts],[a, hearts]],D).

shuffledeck([],[]).
shuffledeck(D, [Card|D3]) :-
    length(D,L),
    L2 is L+1,
    random(1, L2, I),
    nth1(I, D, Card),
    delete(D, Card, D2),
    shuffledeck(D2, D3).

cardVal([V|L], Card) :-
    integer(V),
    Card is V.
cardVal([V|L], Card):-
    V=j,
    Card is 11.
cardVal([V|L], Card):-
    V=q,
    Card is 12.
cardVal([V|L], Card):-
    V=k,
    Card is 13.
cardVal([V|L], Card):-
    V=a,
    Card is 14.


playhand(L1,[],X,R):-
    sleep(1),
    write("Game over.\n\n\n"),
    R is X.
playhand([],L2,X,R) :-
    sleep(1),
    write("Game over.\n\n\n"),
    R is X.
playhand([X|L1], [Y|L2],W,R) :-
    cardVal(X, V1),
    cardVal(Y, V2),
    V1>V2,
    sleep(1),
    write(X),
    write(" vs. "),
    write(Y),
    write("          "),
    write("Player 1 won the hand.\n"),
    A is W-1,
    playhand(L1,L2,A,R).
playhand([X|L1], [Y|L2],W,R) :-
    cardVal(X, V1),
    cardVal(Y, V2),
    V1<V2,
    sleep(1),
    write(X),
    write(" vs. "),
    write(Y),
    write("          "),
    write("Player 2 won the hand.\n"),
    A is W+1,
    playhand(L1,L2,A,R).
playhand([X1,X2,X3,X4|L1], [Y1,Y2,Y3,Y4|L2],W,R) :-
    cardVal(X1, V1),
    cardVal(Y1, V2),
    V1=:=V2,
    sleep(1),
    write(X1),
    write(" vs. "),
    write(Y1),
    write("\n    "),
    write("TIE! TIME FOR WAR!!!\n"),
    playwar([X2,X3,X4|L1],[Y2,Y3,Y4|L2],[],W,R).

playhand([X1,X2,X3|L1], [Y1,Y2,Y3|L2],W,R) :-
    cardVal(X1, V1),
    cardVal(Y1, V2),
    V1=:=V2,
    sleep(1),
    write(X1),
    write(" vs. "),
    write(Y1),
    write("\n    "),
    write("TIE! TIME FOR WAR!!!\n"),
    playwar([X2,X3|L1],[Y2,Y3|L2],[],W,R).

playhand([X1,X2|L1], [Y1,Y2|L2],W,R) :-
    cardVal(X1, V1),
    cardVal(Y1, V2),
    V1=:=V2,
    sleep(1),
    write(X1),
    write(" vs. "),
    write(Y1),
    write("\n    "),
    write("TIE! TIME FOR WAR!!!\n"),
    playwar([X2|L1],[Y2|L2],[],W,R).

playhand([X1|L1], [Y1|L2],W,R) :-
    cardVal(X1, V1),
    cardVal(Y1, V2),
    V1=:=V2,
    sleep(1),
    write(X1),
    write(" vs. "),
    write(Y1),
    write("\n    "),
    write("TIE! TIME FOR WAR!!!\n"),
    sleep(1),
    write("    Not enough cards for the war. :(\n\n"),
    playhand(L1,L2,W,R).


% This deals the first shuffled deck to the two players and starts the
% game.
div(X, R) :-
    shuffle(L),
    append(A, B, L),
    length(A, N),
    length(B, N),
    playhand(A,B,X,R).


start():-
    div(0,R),
    finish(R).



finish(R):-
    R<0,
    R1 is -R,
    write("Player 1 has won by a total of "),
    write(R1),
    write(" hands! Thanks for playing!").
finish(R):-
    R>0,
    write("Player 2 has won by a total of "),
    write(R),
    write(" hands! Thanks for playing!").
finish(R):-
    R=0,
    write("Both Players finished with the same amount of winning hands. It is a tie! Thanks for playing!").





%all cards to turn
playwar([X1,X2,X3,X4|L1],[Y1,Y2,Y3,Y4|L2],S, W, R) :-
    cardVal(X4,VX),
    cardVal(Y4, VY),
    VX>VY,
    sleep(1),
    write("    "),
    write(X1),
    write("                  I                   "),
    write(Y1),
    write("\n    "),
    sleep(1),
    write(X2),
    write("                  DE-                 "),
    write(Y2),
    write("\n    "),
    sleep(1),
    write(X3),
    write("                CLARE                 "),
    write(Y3),
    write("\n    "),
    sleep(1),
    write("                          WAR                \n"),
    write(X4),
    write(" vs. "),
    write(Y4),
    write("        PLAYER ONE WINS THE WAR!\n"),
    W1 is W-1,
    playhand(L1,L2,W1,R).
%all cards to turn
playwar([X1,X2,X3,X4|L1],[Y1,Y2,Y3,Y4|L2],S, W, R) :-
    cardVal(X4,VX),
    cardVal(Y4, VY),
    VX<VY,
    sleep(1),
    write("    "),
    write(X1),
    write("                  I                   "),
    write(Y1),
    write("\n    "),
    sleep(1),
    write(X2),
    write("                  DE-                 "),
    write(Y2),
    write("\n    "),
    sleep(1),
    write(X3),
    write("                CLARE                 "),
    write(Y3),
    write("\n    "),
    sleep(1),
    write("                         WAR                \n"),
    write(X4),
    write(" vs. "),
    write(Y4),
    write("        PLAYER TWO WINS THE WAR!\n"),
    W1 is W+1,
    playhand(L1,L2,W1,R).
%all cards to turn
playwar([X1,X2,X3,X4|L1],[Y1,Y2,Y3,Y4|L2],S, W, R) :-
    cardVal(X4,VX),
    cardVal(Y4, VY),
    VX=:=VY,
    sleep(1),
    write("    "),
    write(X1),
    write("                   I                   "),
    write(Y1),
    write("\n    "),
    sleep(1),
    write(X2),
    write("                 DE-                 "),
    write(Y2),
    write("\n    "),
    sleep(1),
    write(X3),
    write("                 CLARE                 "),
    write(Y3),
    write("\n    "),
    sleep(1),
    write("                            WAR                \n"),
    write(X4),
    write(" vs. "),
    write(Y4),
    write("        THE WAR IS A TIE! WE ARE WARRING AGAIN!!!\n\n"),
    playwar(L1,L2,[X1,X2,X3,X4,Y1,Y2,Y3,Y4],W,R).





%two cards to turn
playwar([X2,X3,X4|L1],[Y2,Y3,Y4|L2],S,W,R):-
    cardVal(X4,VX),
    cardVal(Y4, VY),
    VX>VY,
    sleep(1),
    write("    "),
    write(X2),
    write("                  DE-                 "),
    write(Y2),
    write("\n    "),
    sleep(1),
    write(X3),
    write("                CLARE                 "),
    write(Y3),
    write("\n    "),
    sleep(1),
    write("                          WAR                \n"),
    write(X4),
    write(" vs. "),
    write(Y4),
    write("        PLAYER ONE WINS THE WAR!\n"),
    W1 is W-1,
    playhand(L1,L2,W1,R).

%two cards to turn
playwar([X2,X3,X4|L1],[Y2,Y3,Y4|L2],S,W,R):-
    cardVal(X4,VX),
    cardVal(Y4, VY),
    VX<VY,
    sleep(1),
    write("    "),
    write(X2),
    write("                  DE-                 "),
    write(Y2),
    write("\n    "),
    sleep(1),
    write(X3),
    write("                CLARE                 "),
    write(Y3),
    write("\n    "),
    sleep(1),
    write("                          WAR                \n"),
    write(X4),
    write(" vs. "),
    write(Y4),
    write("        PLAYER TWO WINS THE WAR!\n"),
    W1 is W+1,
    playhand(L1,L2,W1,R).

%two cards to turn
playwar([X2,X3,X4|L1],[Y2,Y3,Y4|L2],S,W,R):-
    cardVal(X4,VX),
    cardVal(Y4, VY),
    VX=:=VY,
    sleep(1),
    write("    "),
    write(X2),
    write("                  DE-                 "),
    write(Y2),
    write("\n    "),
    sleep(1),
    write(X3),
    write("                CLARE                 "),
    write(Y3),
    write("\n    "),
    sleep(1),
    write("                          WAR                \n"),
    write(X4),
    write(" vs. "),
    write(Y4),
    write("        THE WAR IS A TIE! WE ARE WARRING AGAIN!!!\n\n"),
    playwar(L1,L2,[X2,X3,X4,Y2,Y3,Y4],W,R).





%one card to turn
playwar([X3,X4|L1],[Y3,Y4|L2],S,W,R):-
    cardVal(X4,VX),
    cardVal(Y4, VY),
    VX>VY,
    sleep(1),
    write("    "),
    write(X3),
    write("                CLARE                 "),
    write(Y3),
    write("\n    "),
    sleep(1),
    write("                          WAR                \n"),
    write(X4),
    write(" vs. "),
    write(Y4),
    write("        PLAYER ONE WINS THE WAR!\n"),
    W1 is W-1,
    playhand(L1,L2,W1,R).
%one card to turn
playwar([X3,X4|L1],[Y3,Y4|L2],S,W,R):-
    cardVal(X4,VX),
    cardVal(Y4, VY),
    VX<VY,
    sleep(1),
    write("    "),
    write(X3),
    write("                CLARE                 "),
    write(Y3),
    write("\n    "),
    sleep(1),
    write("                          WAR                \n"),
    write(X4),
    write(" vs. "),
    write(Y4),
    write("        PLAYER TWO WINS THE WAR!\n"),
    W1 is W+1,
    playhand(L1,L2,W1,R).
%one card to turn
playwar([X3,X4|L1],[Y3,Y4|L2],S,W,R):-
    cardVal(X4,VX),
    cardVal(Y4, VY),
    VX>VY,
    sleep(1),
    write("    "),
    write(X3),
    write("                CLARE                 "),
    write(Y3),
    write("\n    "),
    sleep(1),
    write("                          WAR                \n"),
    write(X4),
    write(" vs. "),
    write(Y4),
    write("        THE WAR IS A TIE! WE ARE WARRING AGAIN!!!\n\n"),
    playwar(L1,L2,[X3,X4,Y3,Y4],W,R).




%NO CARDS TO TURN
playwar([X4|L1],[Y4|L2],S,W,R):-
    cardVal(X4,VX),
    cardVal(Y4, VY),
    VX=:=VY,
    sleep(1),
    write("                          WAR                \n"),
    write(X4),
    write(" vs. "),
    write(Y4),
    write("        THE WAR IS A TIE! WE ARE WARRING AGAIN!!!\n\n"),
    write("    There are not enough cards.\n"),
    playhand(L1,L2,W,R).
playwar([X4|L1],[Y4|L2],S,W,R):-
    cardVal(X4,VX),
    cardVal(Y4, VY),
    VX<VY,
    sleep(1),
    write("                          WAR                \n"),
    write(X4),
    write(" vs. "),
    write(Y4),
    write("        PLAYER TWO WINS THE WAR!\n"),
    W1 is W+1,
    playhand(L1,L2,W1,R).
playwar([X4|L1],[Y4|L2],S,W,R):-
    cardVal(X4,VX),
    cardVal(Y4, VY),
    VX>VY,
    sleep(1),
    write("                          WAR                \n"),
    write(X4),
    write(" vs. "),
    write(Y4),
    write("        PLAYER ONE WINS THE WAR!\n"),
    W1 is W-1,
    playhand(L1,L2,W1,R).
















