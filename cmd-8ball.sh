#!/bin/bash
# Script to get an 8ball output

# So it properly splits in shuf
IFS=''

# Define answers
ANSWERS="As I see it, yes
It is certain
It is decidedly so
Most likely
Outlook good
Signs point to yes
Without a doubt
For sure!
Yes
Yep
Hell yeah!
Yes definitely
You may rely on it
Better not tell you now
Don't count on it
My reply is no
No
Nope
Hell no!
Probably not...
My sources say no
Outlook not so good
Very doubtful"

# Get a random answer
echo $ANSWERS | shuf -n1
