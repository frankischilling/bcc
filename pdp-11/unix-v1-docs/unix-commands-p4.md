# UNIX Programmer's Manual - Section I: Commands (Part 4)

**Final Commands - UNIX First Edition (November 3, 1971)**

## WC(I)

### NAME
wc -- get (English) word count

### SYNOPSIS
wc name1 ...

### DESCRIPTION
wc provides a count of the words, text lines, and roff control lines for each argument file.

A text line is a sequence of characters not beginning with "." and ended by a new-line. A roff control line is a line beginning with ".". A word is a sequence of characters bounded by the beginning of a line, by the end of a line, or by a blank or a tab.

### FILES

### SEE ALSO
roff

### DIAGNOSTICS
none; arguments not found are ignored.

### BUGS

### OWNER
jfo

## WHO(I)

### NAME
who -- who is on the system

### SYNOPSIS
who

### DESCRIPTION
who lists the name, typewriter channel, and login time for each current UNIX user.

### FILES
/tmp/utmp contains the necessary information; it is maintained by init,

### SEE ALSO
/etc/init

### DIAGNOSTICS

### BUGS

### OWNER
dmr, ken

## WRITE(I)

### NAME
write -- write to another user

### SYNOPSIS
write user

### DESCRIPTION
write copies lines from your typewriter to that of another user. When first called, write sends the message

```
message from yourname...
```

The recipient of the message should write back at this point. Communication continues until an end of file is read from the typewriter or an interrupt is sent. At that point write writes "EOT" on the other terminal.

Permission to write may be denied or granted by use of the mesg command. At the outset writing is allowed. Certain commands, in particular roff and pr, disallow messages in order to prevent messy output.

If the character "!" is found at the beginning of a line, write calls the mini-shell msh to execute the rest of the line as a command.

The following protocol is suggested for using write: When you first write to another user, wait for him to write back before starting to send. Each party should end each message with a distinctive signal ("(o)" for "over is conventional) that the other may reply. "(oo)" (for over and out) is suggested when conversation is about to be terminated.

### FILES
/tmp/utmp is used to discover the target user's typewriter channel and the sending users s name. msh is used to execute commands.

### SEE ALSO
mesg

### DIAGNOSTICS
"user not logged in"; "permission denied"

### BUGS

### OWNER
dmr, ken
