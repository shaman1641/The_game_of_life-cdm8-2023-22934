asect 0xf0
yadr: ds 1
xadr: ds 1
ypradr: ds 1
asect  0xe0 
y: ds 1
x: ds 1
ypl: ds 1
xpl: ds 1
ymi: ds 1
sost:ds 1
sums: ds 1
#razm: ds 1
sum: ds 1
schx:ds 1
schy: ds 1
#asect 0xfc
#xmax: dc 15
#ymax: dc 15
#xstart: dc 0
#ystart: dc 0
asect 	0x00
start:
ldi r1, 0
##ldc r1, r1
parsy:
ldi r0, yadr #r1 y
st r0, r1
ldi r0, y 
st r0, r1 
#ld r1, r2 #r1 y
ldi r2, 0
##ldc r1, r1
parsx:
ldi r0, xadr
st r0, r2   #r2 x
ldi r0, x
st r0, r2
ldi r0, 0
ldi r3, sums
st r3, r0
ldi r3, xadr
ld r3, r3  #r3 sost
ldi r0, sost
st r0, r3
####################### y -1
if
tst r1
is eq
	ldi r0, 15
	##ldc r3, r0
	ldi r3, yadr
	st r3, r0
	ldi r3, ymi
	st r3, r0
else
	ldi r3, y
	ld r3, r0
	ldi r3, yadr
	dec r0
	st r3, r0
	ldi r3, ymi
	st r3, r0
fi 
#############################
jsr prov
################################ y+1
if
ldi r3, 15
##ldc r3, r3
cmp r1, r3
is eq
	ldi r0, 0
	ldi r3, yadr
	st r3, r0
	ldi r3, ypl
	st r3, r0
else
	ldi r3, y
	ld r3, r0
	ldi r3, yadr
	inc r0
	st r3, r0
	ldi r3, ypl
	st r3, r0
fi 
##########
jsr prov
############# x-1
if
tst r2
is eq
	ldi r0, 15
	##ldc r3, r0
	ldi r3, xadr
	st r3, r0
else
	ldi r3, x
	ld r3, r0
	dec r0
	ldi r3, xadr
	st r3, r0
fi 
##############
jsr prov
############# y
ldi r3, y
jsr extra
###########
jsr prov
############ y -1
ldi r3, ymi
jsr extra	
###########
jsr prov
############# x+1
if
ldi r3, 15
##ldc r3, r3
cmp r2, r3
is eq
	ldi r0, 0
	ldi r3, xadr
	st r3, r0
else
	ldi r3, x
	ld r3, r0
	inc r0
	ldi r3, xadr
	st r3, r0
fi 
ldi r3, xpl
st r3, r0
##############
jsr prov
############# y +1
ldi r3, ypl
jsr extra
###########
jsr prov
############ y 
ldi r3, y
jsr extra	
###########
jsr prov
#####################
ldi r0, x
ld r0, r0 
ldi r3, xadr
st r3, r0
ldi r0, sost
ld r0, r0
ldi r3, sums
ld r3, r3
#push r1
if
tst r0
is ne
	if
	ldi r0, 2
	cmp r0, r3
	is eq
		ldi r0, 0b00000010
		jsr extraq
	else
		if
		ldi r0, 3
		cmp r0, r3
		is eq
			ldi r0, 0b00000010
			jsr extraq
		else 
			br sled
		fi
	fi
else
	if
	ldi r0, 3
	cmp r0, r3
	is eq
		ldi r0, 0b00000010
		jsr extraq
	else 
		br sled
	fi	
fi
######################
sled:
#pop r1
if
ldi r0, 15
##ldc r0, r0
cmp r0, r2
is eq
	if
	ldi r0, 15
	##ldc r0, r0	
	cmp r0, r1
	is eq 
		br fin
	else 
		ldi r3, ypl
		ld r3, r1
		br parsy
	fi
else 
	ldi r3, xpl
	ld r3, r2
	br parsx
fi
fin:
ldi r0, 0b00000001
jsr extraq
br start

extra: 
ld r3, r3
ldi r0, yadr
st r0, r3
rts

extraq:
ldi r3, ypradr
st r3, r0
ldi r0, 0b00000000
st r3, r0
rts

prov:
ldi r3, xadr
ld r3, r0
if
tst r0
is ne
	ldi r3, sums
	ld r3, r0
	inc r0
	st r3, r0	
fi
rts

end
