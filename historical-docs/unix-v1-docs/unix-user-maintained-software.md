# UNIX Programmer's Manual - Section VI: User-Maintained Programs

**Contributed Software - UNIX First Edition (November 3, 1971)**

## BASIC (VI)

### NAME
basic -- DEC supplied BASIC

### SYNOPSIS
basic [file]

### DESCRIPTION
Basic is the standard BASIC V000 distributed as a stand alone program. The optional file argument is read before the console. See DEC-11-AJPB-D manual.

Since bas is smaller and faster, basic is not maintained on line.

### FILES

### SEE ALSO
bas

### DIAGNOSTICS
See manual

### BUGS
GOK

### OWNER
dmr

## BJ (VI)

### NAME
bj -- the game of black jack

### SYNOPSIS
/usr/games/bj

### DESCRIPTION
Black jack is a serious attempt at simulating the dealer in the game of black jack (or twenty-one) as might be found in Reno.

The following rules apply:

The bet is $2 every hand.

A player 'natural' (black jack) pays $3. A dealer natural loses $2. Both dealer and player naturals is a 'push' (no money exchange).

If the dealer has an ace up, the player is allowed to make an 'insurance' bet against the chance of a dealer natural. If this bet is not taken, play resumes as normal. If the bet is taken, it is a side bet where the player wins $2 if the dealer has a natural and loses $1 if the dealer does not.

If the player is dealt two cards of the same value, he is allowed to 'double'. He is allowed to play two hands, each with one of these cards. (The bet is doubled also; $2 on each hand.)

If a dealt hand has a total of ten or eleven, the player may 'double down'. He may double the bet ($2 to $4) and receive exactly one more card on that hand.

Under normal play, the player may 'hit' (draw a card) as long as his total is not over twenty-one. If the player 'busts' (goes over twenty-one), the dealer wins the bet.

When the player 'stands' (decides not to hit), the dealer hits until he attains a total of seventeen or more. If the dealer busts, the player wins the bet.

If both player and dealer stand, the one with the largest total wins. A tie is a push.

The machine deals and keeps score. The following questions will be asked at appropriate times. Each question is answered by x followed by a new line for 'yes', or just new line for 'no'.

- ? means 'do you want a hit?'
- Insureance?
- double down?

Every time the deck is shuffled, the dealer so states and the 'action' (total bet) and 'standing' (total won or loss) is printed. To exit, hit the interrupt key (DEL) and the action and standing will be printed.

### FILES

### SEE ALSO

### DIAGNOSTICS

### BUGS

### OWNER
ken

## CAL (VI)

### NAME
cal -- print calendar

### SYNOPSIS
/usr/ken/cal year

### DESCRIPTION
Cal will print a calendar for the given year. The year can be between 0 (really 1 BC) and 9999. For years when several calendars were in vogue in different countries, the calendar of England (and therefore her colonies) is printed.

P.S. try cal of 1752.

### FILES

### SEE ALSO

### DIAGNOSTICS

### BUGS

### OWNER
ken

## CHESS (VI)

### NAME
chess -- the game of chess

### SYNOPSIS
/usr/games/chess

### DESCRIPTION
Chess is an attempt at computer chess. The program 'speaks' in algebraic chess notation. The initial board configuration in this notation is as follows:

```
8 R N B Q K B N R
7 P P P P P P P P
6 - * - * - * - *
5 * - * - * - * -
4 - * - * - * - *
3 * - * - * - * -
2 p p p p p p p p
1 r n b q k b n r
  a b c d e f g h
```

A move is specified by the 'from' co-ordinate followed by the 'to' co-ordinate. Thus the white P-K4 move would be 'e2e4'. The black P-K4 would be 'e7e5'.

The following commands are recognized by the chess program:

- move - Make the move if legal. The program does not keep track of who is to play. The move is made for what ever side is specified.
- move x - Make the move regardless of legality. This is a good way to either set up a desired situation or to cheat. The initial move 'e2e8x' is a winner.
- mw - The program will compute and make a move for the white pieces.
- mb - The program will compute and make a move for the black pieces.
- lab - Set the level parameters to a and b, where a and b are numbers between 0 and 9. The initial settings are 2 and 8. The first parameter increases computation time rapidly while the second parameter only increases computation exponentially. Currently move times run from 20 seconds to 10 minutes. It was hoped that these numbers would be usefully related to the program's competence.
- p - The board is printed.
- u - The last move is un-made. This is another good way to cheat.
- t - All the moves to date are printed.
- s - The current game situation is saved on the file c.tmp.
- r - The game situation on the file c.tmp is restored.
- ! command - The unix command is executed by the mini-shell.

An interrupt (DEL) will pull the program out of its computation. If it is trying to make a move, the best move to date is made.

### FILES
c.tmp

### SEE ALSO
msh

### DIAGNOSTICS
? if an illegal move is attempted, or if an unknown command is typed.

### BUGS
The current version does not recognize castling, promotion and en passant. A new version is in the mill.

### OWNER
ken

## DAS (VI)

### NAME
das -- disassembler

### SYNOPSIS

### DESCRIPTION
A PDP-11 disassembler exists. Contact the author for more information.

### FILES

### SEE ALSO

### DIAGNOSTICS

### BUGS

### OWNER
ken

## DLI (VI)

### NAME
dli -- load DEC binary paper tapes

### SYNOPSIS
dli output [input]

### DESCRIPTION
dli will load a DEC binary paper tape into the output file. The binary format paper tape is read from the input file (/dev/ppt is default.)

### FILES
/dev/ppt

### SEE ALSO

### DIAGNOSTICS
"checksum"

### BUGS
---

### OWNER
dmr

## DPT (VI)

### NAME
dpt -- read DEC ASCII paper tape

### SYNOPSIS
dpt output [input]

### DESCRIPTION
dpt reads the input file (/dev/ppt default) assuming the format is a DEC generated ASCII paper tape of an assembly language program. The output is a UNIX ASCII assembly program.

### FILES
/dev/ppt

### SEE ALSO

### DIAGNOSTICS

### BUGS
Almost always a hand pass is required to get a correct output.

### OWNER
ken, dmr

## MOO (VI)

### NAME
moo -- a game

### SYNOPSIS
/usr/games/moo

### DESCRIPTION
moo is a guessing game imported from England.

### FILES

### SEE ALSO

### DIAGNOSTICS

### BUGS

### OWNER
ken

## SORT (VI)

### NAME
sort -- sort a file

### SYNOPSIS
sort input output

### DESCRIPTION
sort will sort the input file and write the sorted file on the output file. Wide options are available on collating sequence and ignored characters.

### FILES

### SEE ALSO

### DIAGNOSTICS

### BUGS

### OWNER
dmr, ken

## TTT (VI)

### NAME
ttt -- tic-tac-toe

### SYNOPSIS
/usr/games/ttt

### DESCRIPTION
ttt is the X's and O's game popular in 1st grade. This is a learning program that never makes the same mistake twice.

### FILES
ttt.k -- old mistakes

### SEE ALSO

### DIAGNOSTICS

### BUGS

### OWNER
ken