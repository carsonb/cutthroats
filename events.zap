

	.FUNCT	I-UNWOUND
	SET	'WATCH-WOUND,FALSE-VALUE
	RFALSE	


	.FUNCT	I-BUSINESS-HOURS
	ZERO?	BUSINESS-HOURS? /?ELS5
	SET	'BUSINESS-HOURS?,FALSE-VALUE
	IN?	PLAYER,MCGINTY-HQ \?ELS9
	MOVE	PLAYER,WHARF-ROAD-2
	SET	'HERE,WHARF-ROAD-2
	PRINTI	"""Closing time,"" says "
	CALL	DPRINT,MCGINTY
	PRINTI	" as he escorts you out to the street..."
	CRLF	
	CRLF	
	CALL	V-FIRST-LOOK
	RTRUE	
?ELS9:	IN?	PLAYER,OUTFITTERS-HQ \?ELS13
	MOVE	PLAYER,WHARF-ROAD-4
	SET	'HERE,WHARF-ROAD-4
	PRINTI	"""Sorry, but it's closing time,"" the salesman says, then shows you out..."
	CRLF	
	CRLF	
	CALL	V-FIRST-LOOK
	RTRUE	
?ELS13:	IN?	PLAYER,BANK \FALSE
	MOVE	PLAYER,SHORE-ROAD-2
	SET	'HERE,SHORE-ROAD-2
	PRINTI	"The teller says, ""You'll have to leave. It's 5:00."" A guard escorts you out..."
	CRLF	
	CRLF	
	CALL	V-FIRST-LOOK
	RTRUE	
?ELS5:	SET	'BUSINESS-HOURS?,TRUE-VALUE
	CALL	QUEUE,I-BUSINESS-HOURS,480
	PUT	STACK,0,1
	RFALSE	


	.FUNCT	I-FERRY-APPROACHING
	CALL	QUEUE,I-FERRY-APPROACHING,-1
	PUT	STACK,0,1
	FCLEAR	FERRY,INVISIBLE
	IN?	WEASEL,GLOBAL-FERRY \?CND1
	MOVE	WEASEL,FERRY
?CND1:	EQUAL?	HERE,FERRY-LANDING,SHORE-ROAD-1,SHORE-ROAD-2 \FALSE
	PRINTR	"The ferry approaches the landing."


	.FUNCT	I-FERRY,WEASEL-HERE?=0
	CALL	INT,I-FERRY-APPROACHING
	PUT	STACK,0,0
	CALL	QUEUE,I-FERRY-LEAVING,5
	PUT	STACK,0,1
	CALL	QUEUE,I-FERRY-GONE,8
	PUT	STACK,0,1
	MOVE	FERRY,FERRY-LANDING
	IN?	WEASEL,FERRY-LANDING \?ELS3
	CALL	QUEUED?,I-TRAITOR-MEETING
	ZERO?	STACK \?ELS3
	SET	'WEASEL-HERE?,TRUE-VALUE
	MOVE	WEASEL,FERRY
	JUMP	?CND1
?ELS3:	IN?	WEASEL,FERRY \?CND1
	MOVE	WEASEL,FERRY-LANDING
	IN?	JOHNNY,FERRY-LANDING \?ELS10
	ZERO?	WEASEL-BLOWN /?ELS10
	CALL	ROUGH-JUSTICE
	JUMP	?CND1
?ELS10:	EQUAL?	SHIP-CHOSEN,TRAWLER \?ELS14
	CALL	ESTABLISH-GOAL,WEASEL,NW-CREW-QTRS
	JUMP	?CND1
?ELS14:	EQUAL?	SHIP-CHOSEN,SALVAGER \?CND1
	CALL	ESTABLISH-GOAL,WEASEL,MM-CREW-QTRS
?CND1:	EQUAL?	HERE,FERRY-LANDING \?ELS21
	PRINTI	"The ferry arrives. Some passengers get off and others get on."
	ZERO?	WEASEL-HERE? /?ELS26
	CALL	TELL-FERRY-KLUDGE,STR?431
	JUMP	?CND24
?ELS26:	IN?	WEASEL,FERRY-LANDING \?CND24
	CALL	QUEUED?,I-TRAITOR-MEETING
	ZERO?	STACK \?CND24
	CALL	TELL-FERRY-KLUDGE,STR?432
	IN?	ENVELOPE,PLAYER \?CND24
	CRLF	
	CALL	WEASEL-BEATS-YOU
?CND24:	CRLF	
	RTRUE	
?ELS21:	EQUAL?	HERE,SHORE-ROAD-1,SHORE-ROAD-2 \FALSE
	PRINTR	"The ferry arrives at the landing."


	.FUNCT	TELL-FERRY-KLUDGE,STR
	PRINTI	" The Weasel "
	PRINT	STR
	PRINTI	"."
	RTRUE	


	.FUNCT	I-FERRY-LEAVING
	CALL	QUEUE,I-FERRY-LEAVING,-1
	PUT	STACK,0,1
	MOVE	FERRY,LOCAL-GLOBALS
	IN?	WEASEL,FERRY \?CND1
	IN?	PASSBOOK,WEASEL \?CND1
	MOVE	WEASEL,LOCAL-GLOBALS
?CND1:	EQUAL?	HERE,FERRY-LANDING,SHORE-ROAD-1,SHORE-ROAD-2 \FALSE
	PRINTR	"The ferry pulls away, heading for the mainland."


	.FUNCT	I-FERRY-GONE
	CALL	INT,I-FERRY-LEAVING
	PUT	STACK,0,0
	CALL	QUEUE,I-FERRY-APPROACHING,109
	PUT	STACK,0,1
	CALL	QUEUE,I-FERRY,112
	PUT	STACK,0,1
	FSET	FERRY,INVISIBLE
	IN?	WEASEL,FERRY \FALSE
	MOVE	WEASEL,GLOBAL-FERRY
	RFALSE	


	.FUNCT	I-DISGUSTING-WEASEL-KLUDGE,WGT
	IN?	PASSBOOK,WEASEL /FALSE
	GET	GOAL-TABLES,WEASEL-C >WGT
	GET	WGT,GOAL-F
	EQUAL?	STACK,SHANTY /FALSE
	PUT	WGT,ATTENTION,0
	CALL	ESTABLISH-GOAL,WEASEL,SHANTY
	RFALSE	


	.FUNCT	I-FIRST-MEETING
	EQUAL?	FM-CTR,5 \?ELS5
	CALL	INT,I-FIRST-MEETING
	PUT	STACK,0,0
	RFALSE	
?ELS5:	IN?	JOHNNY,SHANTY \FALSE
	IN?	PETE,SHANTY \FALSE
	CALL	META-LOC,PLAYER
	EQUAL?	STACK,SHANTY \FALSE
	ZERO?	FM-CTR \?ELS14
	GRTR?	PRESENT-TIME,535 \?CND15
	CALL	I-PLOT-NEVER-STARTS
	CALL	INT,I-FIRST-MEETING
	PUT	STACK,0,0
	RFALSE	
?CND15:	SET	'QCONTEXT,JOHNNY
	SET	'QCONTEXT-ROOM,HERE
	PRINTI	"""Sit down and we'll talk,"" "
	CALL	DPRINT,JOHNNY
	PRINTR	" says."
?ELS14:	EQUAL?	FM-CTR,1 \?ELS21
	IN?	WEASEL,SHANTY \?ELS26
	SET	'FM-CTR,2
	CALL	I-FIRST-MEETING
	RSTACK	
?ELS26:	ZERO?	WAITING-FOR-WEASEL /?ELS28
	GRTR?	PRESENT-TIME,525 \FALSE
	CALL	INT,I-FIRST-MEETING
	PUT	STACK,0,0
	CALL	I-PLOT-NEVER-STARTS
	SET	'QCONTEXT,JOHNNY
	SET	'QCONTEXT-ROOM,HERE
	PRINTI	"Pete looks at Johnny and says, ""Weasel ain't gonna show.""
""Guess not,"" replies Johnny. ""Without "
	CALL	DPRINT,WEASEL
	PRINTR	", there's no deal. Who knows what that creep is up to?"""
?ELS28:	SET	'QCONTEXT,JOHNNY
	SET	'QCONTEXT-ROOM,HERE
	PRINTI	"Johnny says, ""When "
	CALL	DPRINT,WEASEL
	PRINTI	" shows, I'll tell ya what we got."""
	CRLF	
	SET	'WAITING-FOR-WEASEL,TRUE-VALUE
	RETURN	WAITING-FOR-WEASEL
?ELS21:	GRTR?	BLOOD-ALCOHOL,10 \?ELS42
	CALL	INT,I-FIRST-MEETING
	PUT	STACK,0,0
	CALL	I-PLOT-NEVER-STARTS
	PRINTR	"Pete turns to Johnny and says, ""This joker's drunk!""
""Yeah,"" Johnny says. He looks at you. ""Some diver! We'll find someone else."""
?ELS42:	EQUAL?	FM-CTR,2 \?ELS46
	SET	'QCONTEXT,JOHNNY
	SET	'QCONTEXT-ROOM,HERE
	PRINTI	"At Pete's request, "
	CALL	DPRINT,WEASEL
	PRINTI	" joins you. Johnny then whispers that he's come across some sunken "
	CALL	DPRINT,GLOBAL-TREASURE
	PRINTI	"."
	CRLF	
	SET	'FM-CTR,3
	SET	'I-WAIT-RTN,I-FIRST-MEETING
	SET	'I-WAIT-DURATION,2
	RETURN	I-WAIT-DURATION
?ELS46:	EQUAL?	FM-CTR,3 \?ELS50
	ZERO?	I-WAIT-FLAG /?ELS55
	PRINTI	"Unfortunately, this interrupts Johnny's explanation of what the meeting is about."
	CRLF	
	SET	'I-WAIT-DURATION,2
	RETURN	I-WAIT-DURATION
?ELS55:	GRTR?	I-WAIT-DURATION,0 \?ELS60
	EQUAL?	I-WAIT-RTN,I-FIRST-MEETING /FALSE
?ELS60:	SET	'QCONTEXT,JOHNNY
	SET	'QCONTEXT-ROOM,HERE
	PRINTI	"Johnny explains that they need more money to get started. They chose you because they know you've salted some money away and you're a great diver. He asks if you're interested in the deal."
	CRLF	
	SET	'FM-CTR,4
	RETURN	FM-CTR
?ELS50:	EQUAL?	FM-CTR,4 \FALSE
	GRTR?	PRESENT-TIME,539 \?ELS73
	EQUAL?	PRSA,V?NO,V?YES /?ELS73
	SET	'QCONTEXT,JOHNNY
	SET	'QCONTEXT-ROOM,HERE
	CALL	I-PLOT-NEVER-STARTS
	PRINTR	"Pete turns to Johnny. ""We don't want anyone who can't decide.""
""Right,"" says Johnny. ""We'll find someone else."" He turns to you. ""Say a word about this and you're history!"""
?ELS73:	SET	'QCONTEXT,JOHNNY
	SET	'QCONTEXT-ROOM,HERE
	PRINTR	"""Well, what is it? Yes or no?"" Pete asks anxiously."


	.FUNCT	SAMPLE-TREASURE-F
	EQUAL?	PRSA,V?TAKE /?THN6
	EQUAL?	PRSA,V?ASK-FOR \?ELS5
	EQUAL?	PRSO,JOHNNY \?ELS5
?THN6:	IN?	MCGINTY,HERE \?ELS14
	CALL	PERFORM,V?TELL,MCGINTY,SAMPLE-TREASURE
	RTRUE	
?ELS14:	PRINTR	"Red pulls it back. ""If we get the loot, there'll be plenty for all."""
?ELS5:	EQUAL?	PRSA,V?TURN \FALSE
	CALL	DPRINT,JOHNNY
	PRINTR	" has it."


	.FUNCT	I-SECOND-MEETING
	GRTR?	PRESENT-TIME,585 \?CND1
	LESS?	SM-CTR,2 /?THN6
	GRTR?	HOW-HUNGRY,3 \?CND1
?THN6:	CALL	ALL-GO-HOME
	CALL	I-PLOT-NEVER-STARTS
	SET	'SM-CTR,4
?CND1:	EQUAL?	SM-CTR,4 \?ELS12
	CALL	INT,I-SECOND-MEETING
	PUT	STACK,0,0
	RTRUE	
?ELS12:	EQUAL?	HERE,WINDING-ROAD-1 /?ELS14
	CALL	INT,I-SECOND-MEETING
	PUT	STACK,0,0
	RTRUE	
?ELS14:	GRTR?	SM-CTR,1 \?ELS16
	IN?	MCGINTY,WINDING-ROAD-1 /?THN19
	IN?	MCGINTY,WINDING-ROAD-2 \?ELS16
?THN19:	CALL	JIGS-UP,STR?435
	RSTACK	
?ELS16:	LESS?	SM-CTR,2 \?ELS22
	IN?	WEASEL,WINDING-ROAD-1 \?ELS27
	IN?	JOHNNY,WINDING-ROAD-1 \?ELS27
	IN?	PETE,WINDING-ROAD-1 \?ELS27
	SET	'SM-CTR,2
	CALL	I-SECOND-MEETING
	RTRUE	
?ELS27:	ZERO?	SM-CTR \FALSE
	IN?	JOHNNY,WINDING-ROAD-1 \FALSE
	SET	'SM-CTR,1
	SET	'QCONTEXT,JOHNNY
	SET	'QCONTEXT-ROOM,HERE
	PRINTR	"Johnny says, ""We'll start when everyone's here."""
?ELS22:	GRTR?	BLOOD-ALCOHOL,10 \?ELS40
	SET	'SM-CTR,4
	CALL	INT,I-SECOND-MEETING
	PUT	STACK,0,0
	SET	'QCONTEXT,JOHNNY
	SET	'QCONTEXT-ROOM,HERE
	CALL	ALL-GO-HOME
	CALL	I-PLOT-NEVER-STARTS
	PRINTI	"""I won't risk everything on a drunk diver!"" "
	CALL	DPRINT,WEASEL
	PRINTR	" says.
""You're right,"" says Johnny. ""We're calling this off."""
?ELS40:	EQUAL?	SM-CTR,2 \?ELS44
	RANDOM	2 >WRECK-FOUND
	EQUAL?	WRECK-FOUND,1 \?ELS47
	SET	'SAMPLE-TREASURE,GOLD-COIN
	JUMP	?CND45
?ELS47:	SET	'SAMPLE-TREASURE,DINNER-PLATE
?CND45:	PUTP	SAMPLE-TREASURE,P?ACTION,SAMPLE-TREASURE-F
	MOVE	SAMPLE-TREASURE,JOHNNY
	SET	'P-IT-OBJECT,SAMPLE-TREASURE
	SET	'SM-CTR,3
	SET	'I-WAIT-DURATION,6
	SET	'I-WAIT-RTN,I-SECOND-MEETING
	SET	'QCONTEXT,JOHNNY
	SET	'QCONTEXT-ROOM,HERE
	PRINTI	"Johnny nods, then pulls out "
	CALL	APRINT,SAMPLE-TREASURE
	PRINTR	" he says he came across while on a shark hunt."
?ELS44:	EQUAL?	SM-CTR,3 \FALSE
	ZERO?	I-WAIT-FLAG /?ELS58
	PRINTI	"This interrupts Johnny's explanation, which makes him angry."
	CRLF	
	SET	'I-WAIT-DURATION,6
	RETURN	I-WAIT-DURATION
?ELS58:	GRTR?	I-WAIT-DURATION,0 \?ELS63
	EQUAL?	I-WAIT-RTN,I-SECOND-MEETING /FALSE
?ELS63:	CALL	INT,I-SECOND-MEETING
	PUT	STACK,0,0
	SUB	705,PRESENT-TIME
	CALL	QUEUE,I-OTHERS-MEET,STACK
	PUT	STACK,0,1
	SET	'SM-CTR,4
	SET	'MEETINGS-COMPLETED,2
	PUT	MOVEMENT-GOALS,JOHNNY-C,JOHNNY-CONTINUES-TABLE
	CALL	IMOVEMENT,JOHNNY,I-JOHNNY
	CALL	RATING-UPD,20
	SET	'QCONTEXT,JOHNNY
	SET	'QCONTEXT-ROOM,HERE
	CRLF	
	PRINTI	"""We're not sure which wreck to salvage,"" Johnny says. ""Since you're joining up, we're hoping you'll identify where the "
	CALL	DPRINT,SAMPLE-TREASURE
	PRINTI	" came from, and then do the dive for us. I'll captain, Pete will cook, and "
	CALL	DPRINT,WEASEL
	PRINTI	" will crew.

Johnny winks at you. ""We'll need you to supply the minutes of longitude and latitude of the wreck. Get $500 and meet me at Point Lookout at 10:45. Then we'll provision the boat.""

He turns to the others. ""We'll meet in "
	CALL	DPRINT,SHANTY
	PRINTR	" at 11:45 to discuss final arrangements.

""We're all in this now,"" Johnny says to the group. ""I'm not gonna chance this operation if one of you doesn't show. We need everyone to pull this off. If anyone tries anything stupid, you won't live to regret it."""


	.FUNCT	I-THIRD-MEETING,JMG
	EQUAL?	HERE,POINT-LOOKOUT /?ELS3
	CALL	INT,I-THIRD-MEETING
	PUT	STACK,0,0
	RFALSE	
?ELS3:	IN?	JOHNNY,POINT-LOOKOUT \FALSE
	LESS?	TM-CTR,6 \?CND1
	INC	'TM-CTR
?CND1:	IN?	MCGINTY,POINT-LOOKOUT \?ELS15
	CALL	JIGS-UP,STR?436
	RSTACK	
?ELS15:	IN?	MCGINTY,OCEAN-ROAD-3 \?ELS17
	CALL	IN-MOTION?,MCGINTY
	ZERO?	STACK \?ELS17
	CALL	JIGS-UP,STR?437
	RSTACK	
?ELS17:	EQUAL?	TM-CTR,1 \?ELS21
	SET	'QCONTEXT,JOHNNY
	SET	'QCONTEXT-ROOM,HERE
	PRINTR	"Johnny turns toward you. ""Well? Did you bring the money?"""
?ELS21:	GRTR?	BLOOD-ALCOHOL,10 \?ELS25
	CALL	JIGS-UP,STR?438
	RSTACK	
?ELS25:	EQUAL?	TM-CTR,4 \?ELS27
	PRINTR	"Johnny glares at you as if you were a sea slug."
?ELS27:	EQUAL?	TM-CTR,5 \?ELS31
	CALL	JIGS-UP,STR?439
	RSTACK	
?ELS31:	EQUAL?	TM-CTR,6 \?ELS33
	SET	'TM-CTR,7
	CALL	RATING-UPD,20
	SET	'QCONTEXT,JOHNNY
	SET	'QCONTEXT-ROOM,HERE
	CRLF	
	PRINTI	"""Glad you're with us. Since you're okay, I'll level with you. Before Hevlin died, he told me he gave you the book. He also said you could handle this job. He's the one who gave me the "
	CALL	DPRINT,SAMPLE-TREASURE
	PRINTI	". I didn't want to say anything in front of Pete and "
	CALL	DPRINT,WEASEL
	PRINTI	" just in case.

""We're gonna need a boat, but I don't know which one. If you need deep-sea diving gear, it'll have to be the "
	CALL	DPRINT,SALVAGER
	PRINTI	". Is the "
	CALL	DPRINT,GLOBAL-TREASURE
	PRINTR	" more than 200 feet deep?"""
?ELS33:	EQUAL?	TM-CTR,7 \?ELS37
	GRTR?	PRESENT-TIME,675 \?CND38
	CALL	JIGS-UP,STR?440
?CND38:	SET	'QCONTEXT,JOHNNY
	SET	'QCONTEXT-ROOM,HERE
	PRINTR	"Johnny looks impatient. ""Don't confuse things. A yes or no will do."""
?ELS37:	EQUAL?	TM-CTR,8 \FALSE
	CALL	ESTABLISH-GOAL,JOHNNY,OUTFITTERS-HQ
	PUT	MOVEMENT-GOALS,JOHNNY-C,JOHNNY-COMPLETES-TABLE
	GET	MOVEMENT-GOALS,JOHNNY-C >JMG
	SUB	838,PRESENT-TIME
	PUT	JMG,MG-TIME,STACK
	CALL	IMOVEMENT,JOHNNY,I-JOHNNY
	CALL	INT,I-THIRD-MEETING
	PUT	STACK,0,0
	SET	'MEETINGS-COMPLETED,3
	PRINTI	"""We'll rent the "
	CALL	DPRINT,SHIP-CHOSEN
	PRINTR	". Let's go get what we need."""


	.FUNCT	I-EQUIP,MCG-GT,V=0
	IN?	PLAYER,OUTFITTERS-HQ \?ELS5
	IN?	MCGINTY,OUTFITTERS-HQ \?ELS10
	INC	'WARNING-CTR
	EQUAL?	WARNING-CTR,7 \?CND11
	PRINTI	"Johnny leans over and whispers, ""Let's wait out McGinty. He should leave soon."""
	CRLF	
	SET	'V,TRUE-VALUE
?CND11:	GRTR?	I-WAIT-DURATION,0 \?ELS20
	SET	'I-WAIT-DURATION,0
	SET	'I-WAIT-RTN,FALSE-VALUE
	PRINTI	"Johnny ends his conversation, and "
	CALL	DPRINT,MCGINTY
	PRINTR	" asks the salesman some questions."
?ELS20:	GET	GOAL-TABLES,MCGINTY-C >MCG-GT
	GET	MCG-GT,GOAL-ENABLE
	ZERO?	STACK /?ELS24
	GET	MCG-GT,GOAL-F
	EQUAL?	STACK,MCGINTY-HQ \?ELS24
	ZERO?	MCGINTY-KNOWS \?CND27
	SET	'MCGINTY-MEETS-WEASEL,TRUE-VALUE
?CND27:	SET	'I-WAIT-DURATION,9
	SET	'I-WAIT-RTN,I-EQUIP
	RFALSE	
?ELS24:	EQUAL?	PRSA,V?RENT,V?BUY \?ELS31
	EQUAL?	PRSO,FERRY-TOKEN /?ELS31
	SET	'MCGINTY-KNOWS,TRUE-VALUE
	CALL	INT,I-MCGINTY-FOLLOWS
	PUT	STACK,0,0
	CALL	INT,I-EQUIP
	PUT	STACK,0,0
	MOVE	MCGINTY,WHARF-ROAD-4
	CALL	ESTABLISH-GOAL,MCGINTY,MCGINTY-HQ
	CALL	DPRINT,MCGINTY
	PRINTI	" grins as he realizes what you're up to."
	CALL	SAY-MCGINTY-KNOWS
	RSTACK	
?ELS31:	GRTR?	PRESENT-TIME,699 \?ELS37
	IN?	JOHNNY,OUTFITTERS-HQ \?ELS42
	CALL	ESTABLISH-GOAL,JOHNNY,SHANTY
	PRINTI	"Johnny glares at "
	CALL	DPRINT,MCGINTY
	PRINTR	" and then at his watch. ""There's no way."" He turns to you. ""Forget it. We can't get this done in time."""
?ELS42:	CALL	INT,I-MCGINTY-FOLLOWS
	PUT	STACK,0,0
	CALL	ESTABLISH-GOAL,MCGINTY,MCGINTY-HQ
	CALL	INT,I-EQUIP
	PUT	STACK,0,0
	CALL	DPRINT,MCGINTY
	PRINTR	" turns to the salesman. ""I think... yeah! I will need that boat after all."" He turns to you and grins."
?ELS37:	EQUAL?	PRSA,V?WAIT-FOR,V?WAIT /?ELS50
	EQUAL?	PRSA,V?WALK,V?LOOK /?ELS50
	PRINTI	"Johnny glances nervously at "
	CALL	DPRINT,MCGINTY
	PRINTR	"."
?ELS50:	RETURN	V
?ELS10:	ZERO?	MCGINTY-KNOWS /?ELS58
	CALL	INT,I-EQUIP
	PUT	STACK,0,0
	RFALSE	
?ELS58:	ZERO?	I-WAIT-FLAG /?ELS61
	PRINTI	"Johnny seems unhappy to have his conversation interrupted."
	CRLF	
	SET	'I-WAIT-DURATION,9
	RETURN	I-WAIT-DURATION
?ELS61:	EQUAL?	I-WAIT-RTN,I-EQUIP \?ELS66
	GRTR?	I-WAIT-DURATION,0 /FALSE
	CALL	ESTABLISH-GOAL,JOHNNY,SHANTY
	SUB	870,PRESENT-TIME
	CALL	QUEUE,I-SHOVE-OFF,STACK
	PUT	STACK,0,1
	CALL	INT,I-EQUIP
	PUT	STACK,0,0
	EQUAL?	SHIP-CHOSEN,TRAWLER \?ELS76
	RANDOM	50
	ADD	50,STACK >AMT-OWED
	JUMP	?CND74
?ELS76:	RANDOM	50
	ADD	400,STACK >AMT-OWED
?CND74:	SET	'JOHNNY-MADE-DEAL,TRUE-VALUE
	CALL	RATING-UPD,20
	PRINTI	"Johnny hands him a list and the salesman quotes a price. Johnny gives him the money he has, then says to you, ""You'll need to chip in $"
	PRINTN	AMT-OWED
	PRINTI	" plus the money for your stuff. We'll leave on the "
	CALL	DPRINT,SHIP-CHOSEN
	PRINTI	" at high tide.""

He tells the "
	CALL	DPRINT,SPEAR-CARRIER
	PRINTR	", ""Deliver the stuff half an hour before high tide."" He turns back to you. ""Better be on board then to watch the stuff."""
?ELS66:	IN?	MCGINTY,WHARF-ROAD-4 /FALSE
	SET	'I-WAIT-DURATION,9
	SET	'I-WAIT-RTN,I-EQUIP
	RFALSE	
?ELS5:	SET	'I-WAIT-DURATION,0
	CALL	INT,I-EQUIP
	GET	STACK,C-TICK
	LESS?	STACK,-15 \FALSE
	CALL	INT,I-EQUIP
	PUT	STACK,0,0
	IN?	JOHNNY,OUTFITTERS-HQ \?CND90
	CALL	ESTABLISH-GOAL,JOHNNY,SHANTY
?CND90:	CALL	I-PLOT-NEVER-STARTS
	RFALSE	


	.FUNCT	TELL-NEED-BOAT
	PRINTR	" ""We will need that boat after all,"" he says to the salesman as he leaves."


	.FUNCT	SAY-MCGINTY-KNOWS
	CALL	TELL-NEED-BOAT
	MOVE	JOHNNY,WHARF-ROAD-3
	CALL	ZERO-ATTENTION,JOHNNY
	CALL	ESTABLISH-GOAL,JOHNNY,SHANTY
	CRLF	
	PRINTR	"Johnny glares at you. ""That was stupid! Now he's stopped us from renting the boat we need."" He storms out. You can't help feeling fortunate that someone else happened to be here."


	.FUNCT	I-OTHERS-MEET,V=1
	GRTR?	PRESENT-TIME,720 \?ELS3
	CALL	INT,I-OTHERS-MEET
	PUT	STACK,0,0
	CALL	I-PLOT-NEVER-STARTS
	IN?	PLAYER,CHAIR \?ELS6
	PRINTI	"Johnny tells Pete the deal's off."
	CRLF	
	RETURN	V
?ELS6:	IN?	PLAYER,SHANTY \?ELS10
	PRINTI	"Johnny says something to Pete."
	CRLF	
	RETURN	V
?ELS10:	SET	'V,FALSE-VALUE
	RETURN	V
?ELS3:	IN?	JOHNNY,SHANTY \?THN17
	IN?	PETE,SHANTY \?THN17
	IN?	WEASEL,SHANTY /?ELS16
?THN17:	CALL	QUEUE,I-OTHERS-MEET,1
	PUT	STACK,0,1
	RFALSE	
?ELS16:	ZERO?	JOHNNY-MADE-DEAL \?CND1
	CALL	I-PLOT-NEVER-STARTS
?CND1:	IN?	PLAYER,CHAIR \?ELS25
	PRINTI	"Johnny tells Pete and "
	CALL	DPRINT,WEASEL
	PRINTI	" the deal's "
	ZERO?	JOHNNY-MADE-DEAL /?ELS30
	PRINTI	"on and to be at the "
	CALL	DPRINT,SHIP-CHOSEN
	PRINTI	" at 2:30"
	JUMP	?CND28
?ELS30:	PRINTI	"off"
?CND28:	PRINTR	"."
?ELS25:	IN?	PLAYER,SHANTY \FALSE
	PRINTI	"Johnny, Pete, and "
	CALL	DPRINT,WEASEL
	PRINTR	" are talking at a corner table."


	.FUNCT	I-TRAITOR-MEETING,FERRY-HERE=0
	IN?	WEASEL,FERRY /?THN6
	ZERO?	MCGINTY-KNOWS \?THN6
	IN?	MCGINTY,FERRY-LANDING /?ELS5
?THN6:	CALL	INT,I-TRAITOR-MEETING
	PUT	STACK,0,0
	RFALSE	
?ELS5:	IN?	WEASEL,FERRY-LANDING \FALSE
	IN?	ID-CARD,WEASEL \?ELS11
	IN?	PASSBOOK,WEASEL \?ELS16
	IN?	FERRY,FERRY-LANDING \?CND17
	MOVE	WEASEL,FERRY
	SET	'FERRY-HERE,TRUE-VALUE
?CND17:	CALL	INT,I-TRAITOR-MEETING
	PUT	STACK,0,0
	IN?	PLAYER,FERRY-LANDING \FALSE
	CALL	TELL-CORNER,FERRY-HERE,STR?441
	RSTACK	
?ELS16:	MOVE	ID-CARD,MCGINTY
	IN?	FERRY,FERRY-LANDING \?CND27
	MOVE	WEASEL,FERRY
	SET	'FERRY-HERE,TRUE-VALUE
?CND27:	CALL	INT,I-TRAITOR-MEETING
	PUT	STACK,0,0
	IN?	PLAYER,FERRY-LANDING \FALSE
	CALL	TELL-CORNER,FERRY-HERE,STR?442
	RSTACK	
?ELS11:	MOVE	ID-CARD,WEASEL
	SET	'MCGINTY-MEETS-WEASEL,FALSE-VALUE
	IN?	PLAYER,FERRY-LANDING \FALSE
	CALL	DPRINT,MCGINTY
	PRINTI	" takes "
	CALL	DPRINT,WEASEL
	PRINTR	" to a corner of the landing, where they talk."


	.FUNCT	TELL-CORNER,FERRY-HERE,STR
	CALL	DPRINT,MCGINTY
	PRINTI	" and "
	CALL	DPRINT,WEASEL
	PRINTI	" are talking in a corner. The Weasel "
	PRINT	STR
	PRINTI	" and "
	ZERO?	FERRY-HERE /?ELS5
	PRINTI	"then boards the ferry"
	JUMP	?CND3
?ELS5:	PRINTI	"they separate"
?CND3:	PRINTR	"."


	.FUNCT	I-SHOVE-OFF,L,?TMP1
	CALL	ENABLED?,I-JOHNNY
	ZERO?	STACK /FALSE
	CALL	META-LOC,PLAYER
	GETP	STACK,P?LINE >?TMP1
	GETP	SHIP-CHOSEN,P?LINE
	EQUAL?	?TMP1,STACK \?ELS7
	GRTR?	PRESENT-TIME,930 \?ELS10
	ZERO?	LATITUDE-SET \?ELS10
	ZERO?	LONGITUDE-SET \?ELS10
	CALL	ALL-GO-HOME
	RFALSE	
?ELS10:	CALL	META-LOC,PLAYER
	IN?	JOHNNY,STACK \?ELS14
	CALL	DPRINT,JOHNNY
	PRINTI	" turns to"
	JUMP	?CND8
?ELS14:	LOC	JOHNNY >L
	CALL	META-LOC,PLAYER
	MOVE	JOHNNY,STACK
	CALL	ESTABLISH-GOAL,JOHNNY,L
	CALL	DPRINT,JOHNNY
	PRINTI	" walks up behind"
?CND8:	PRINTI	" you and says, """
	ZERO?	DELIVERY-MADE \?ELS25
	PRINTI	"We're gonna have to forget it. Outfitters never delivered the stuff."
	CRLF	
	CALL	ALL-GO-HOME
	RTRUE	
?ELS25:	EQUAL?	0,LATITUDE-SET,LONGITUDE-SET \?ELS29
	PRINTI	"If we're gonna go, you have to tell me the minutes of "
	ZERO?	LATITUDE-SET \?CND32
	PRINTI	"latitude"
	ZERO?	LONGITUDE-SET \?CND32
	PRINTI	" and "
?CND32:	ZERO?	LONGITUDE-SET \?CND42
	PRINTI	"longitude"
?CND42:	PRINTI	"."""
	CRLF	
	CALL	GRAB-ATTENTION,JOHNNY
	RANDOM	10
	ADD	30,STACK
	CALL	QUEUE,I-SHOVE-OFF,STACK
	PUT	STACK,0,1
	RTRUE	
?ELS29:	PRINTI	"We'll be leaving shortly. Get some sleep."""
	CRLF	
?CND23:	EQUAL?	SHIP-CHOSEN,SALVAGER \?ELS55
	CALL	ESTABLISH-GOAL,JOHNNY,MM-WHEELHOUSE
	JUMP	?CND53
?ELS55:	CALL	ESTABLISH-GOAL,JOHNNY,NW-WHEELHOUSE
?CND53:	LOC	WEASEL
	EQUAL?	STACK,FERRY,GLOBAL-FERRY,LOCAL-GLOBALS /?CND58
	LOC	DECK-CHAIR
	CALL	ESTABLISH-GOAL,WEASEL,STACK
?CND58:	ZERO?	AMT-OWED \FALSE
	CALL	QUEUE,I-BOAT-TRIP,10
	PUT	STACK,0,1
	RFALSE	
?ELS7:	GRTR?	PRESENT-TIME,900 \?ELS67
	CALL	ALL-GO-HOME
	RFALSE	
?ELS67:	RANDOM	10
	ADD	30,STACK
	CALL	QUEUE,I-SHOVE-OFF,STACK
	PUT	STACK,0,1
	RFALSE	


	.FUNCT	ALL-GO-HOME
	CALL	ESTABLISH-GOAL,PETE,SHANTY
	IN?	WEASEL,FERRY /?CND1
	IN?	WEASEL,GLOBAL-FERRY /?CND1
	IN?	WEASEL,LOCAL-GLOBALS /?CND1
	CALL	ESTABLISH-GOAL,WEASEL,SHANTY
?CND1:	SET	'JOHNNY-SILENT,TRUE-VALUE
	CALL	ESTABLISH-GOAL,JOHNNY,SHANTY
	RSTACK	


	.FUNCT	I-BOAT-TRIP,BOAT,OT,EXCESS,?TMP1
	ZERO?	ASLEEP \FALSE
	CALL	META-LOC,PLAYER
	GETP	STACK,P?LINE >?TMP1
	GETP	SHIP-CHOSEN,P?LINE >BOAT
	EQUAL?	?TMP1,BOAT \FALSE
	LOC	WEASEL
	GETP	STACK,P?LINE
	EQUAL?	STACK,BOAT /?ELS11
	CALL	TELL-COMES-UP,JOHNNY
	PRINTI	"""The Weasel's not on board. The deal's off."""
	CRLF	
	CALL	FINISH
	JUMP	?CND9
?ELS11:	LOC	MCGINTY
	GETP	STACK,P?LINE
	EQUAL?	STACK,BOAT \?ELS15
	CALL	TELL-COMES-UP,WEASEL
	CALL	JIGS-UP,STR?443
	JUMP	?CND9
?ELS15:	IN?	ENVELOPE,JOHNNY \?CND9
	LOC	WEASEL
	MOVE	JOHNNY,STACK
	CALL	ROUGH-JUSTICE
?CND9:	CALL	INT,I-MCGINTY-FOLLOWS
	PUT	STACK,0,0
	SET	'SOUPS-ON,TRUE-VALUE
	CALL	RATING-UPD,20
	EQUAL?	LATITUDE-SET,20 \?CND18
	EQUAL?	LONGITUDE-SET,25 \?CND18
	CALL	TELL-COMES-UP,JOHNNY
	CALL	JIGS-UP,STR?444
?CND18:	CALL	META-LOC,PLAYER
	EQUAL?	STACK,MM-GALLEY,NW-GALLEY \?CND23
	PRINTI	"Pete announces that the stew is ready."
	CRLF	
?CND23:	EQUAL?	SHIP-CHOSEN,TRAWLER \?ELS30
	SET	'TRAWLER-DOCKED,FALSE-VALUE
	JUMP	?CND28
?ELS30:	SET	'SALVAGER-DOCKED,FALSE-VALUE
?CND28:	SET	'AT-SEA,TRUE-VALUE
	IN?	PLAYER,DECK-CHAIR \?CND33
	LOC	DECK-CHAIR
	MOVE	PLAYER,STACK
?CND33:	LOC	PLAYER
	CALL	GLOBAL-IN?,RAILING,STACK
	ZERO?	STACK /?ELS38
	PRINTI	"As the engines roar to life, you go to the "
	CALL	DPRINT,RAILING
	PRINTI	" to watch the shoreline recede."
	LOC	PLAYER
	IN?	DECK-CHAIR,STACK \?CND41
	CALL	TELL-FERRY-KLUDGE,STR?445
?CND41:	PRINTI	" As the boat leaves the wharf, y"
	JUMP	?CND36
?ELS38:	PRINTI	"The boat begins to move through the waves. Y"
?CND36:	PRINTI	"ou feel the thrill of being out to sea once again."
	CRLF	
	CRLF	
	IN?	PLAYER,BUNK /?CND52
	PRINTI	"You "
	LOC	BUNK
	IN?	PLAYER,STACK /?CND57
	LOC	BUNK >HERE
	CALL	MOVE-SHARED-OBJECTS,HERE
	IN?	AIR-HOSE,DEEP-SUIT \?CND60
	MOVE	AIR-HOSE,MM-COMPRESSOR
	PRINTI	"disconnect the "
	CALL	DPRINT,AIR-HOSE
	PRINTI	", "
?CND60:	PRINTI	"go to the crew's quarters and "
?CND57:	MOVE	PLAYER,BUNK
	PRINTI	"climb into your bunk"
	CALL	STRIP-EQUIPMENT
	PRINTI	". "
	CRLF	
?CND52:	PRINTI	"In no time, the rhythm of the ocean lulls you to sleep..."
	CRLF	
	CRLF	
	MOVE	PETE,DECK-CHAIR
	MOVE	JOHNNY,HERE
	EQUAL?	SHIP-CHOSEN,SALVAGER \?ELS75
	MOVE	WEASEL,MM-AFT-DECK
	JUMP	?CND73
?ELS75:	MOVE	WEASEL,NW-AFT-DECK
?CND73:	CALL	META-LOC,ENVELOPE
	GETP	STACK,P?LINE
	EQUAL?	STACK,BOAT \?CND78
	IN?	ENVELOPE,UNDER-BUNK /?CND78
	MOVE	ENVELOPE,WEASEL
?CND78:	SET	'OT,PRESENT-TIME
	RANDOM	15
	ADD	345,STACK >PRESENT-TIME
	ADD	PRESENT-TIME,1440
	SUB	STACK,OT >EXCESS
	CALL	INTERRUPT-CHECK,EXCESS
	ZERO?	WATCH-WOUND /?CND83
	MOD	EXCESS,60
	ADD	WATCH-MOVES,STACK >WATCH-MOVES
	GRTR?	WATCH-MOVES,59 \?CND87
	SUB	WATCH-MOVES,60 >WATCH-MOVES
	INC	'WATCH-SCORE
?CND87:	DIV	EXCESS,60
	ADD	WATCH-SCORE,STACK >WATCH-SCORE
?PRG90:	GRTR?	WATCH-SCORE,11 \?REP91
	SUB	WATCH-SCORE,12 >WATCH-SCORE
	JUMP	?PRG90
?REP91:	
?CND83:	CALL	WATCH-UPDATE
	EQUAL?	LATITUDE-SET,40 \?ELS99
	EQUAL?	LONGITUDE-SET,45 \?ELS99
	SET	'WRECK-CHOSEN,1
	SET	'OCEAN-BOTTOM,400
	JUMP	?CND97
?ELS99:	EQUAL?	LATITUDE-SET,25 \?ELS103
	EQUAL?	LONGITUDE-SET,25 \?ELS103
	SET	'WRECK-CHOSEN,2
	SET	'OCEAN-BOTTOM,150
	JUMP	?CND97
?ELS103:	EQUAL?	LATITUDE-SET,15 \?ELS107
	EQUAL?	LONGITUDE-SET,50 \?ELS107
	SET	'WRECK-CHOSEN,3
	SET	'OCEAN-BOTTOM,350
	JUMP	?CND97
?ELS107:	CALL	OCEAN-BOTTOM-FCN >OCEAN-BOTTOM
	ZERO?	OCEAN-BOTTOM \?CND97
	CALL	JIGS-UP,STR?446
?CND97:	SET	'HOW-TIRED,1
	LESS?	HOW-HUNGRY,2 \?CND112
	SET	'HOW-HUNGRY,1
?CND112:	LESS?	HOW-THIRSTY,2 \?CND115
	SET	'HOW-THIRSTY,1
?CND115:	CALL	QUEUE,I-HUNGER,10
	PUT	STACK,0,1
	CALL	QUEUE,I-THIRST,15
	PUT	STACK,0,1
	CALL	QUEUE,I-TIRED,869
	PUT	STACK,0,1
	SUB	720,PRESENT-TIME
	CALL	QUEUE,I-ENDIT,STACK
	PUT	STACK,0,1
	CALL	DPRINT,JOHNNY
	PRINTI	" shakes your shoulder and wakes you. "
	EQUAL?	SHIP-CHOSEN,TRAWLER \?ELS122
	CALL	ESTABLISH-GOAL,JOHNNY,NW-CAPT-CABIN
	JUMP	?CND120
?ELS122:	CALL	ESTABLISH-GOAL,JOHNNY,MM-CAPT-CABIN
?CND120:	CALL	INT,I-BOAT-TRIP
	PUT	STACK,0,0
	PRINTR	"""We've arrived. You're up as soon as you're ready."""


	.FUNCT	STRIP-EQUIPMENT,F,N,V=0
	FIRST?	PLAYER >F /?KLU17
?KLU17:	
?PRG1:	ZERO?	F \?CND3
	JUMP	?REP2
?CND3:	NEXT?	F >N /?KLU18
?KLU18:	EQUAL?	F,WATCH /?CND6
	LOC	BUNK
	MOVE	F,STACK
	FCLEAR	F,WORNBIT
	SET	'V,TRUE-VALUE
?CND6:	SET	'F,N
	JUMP	?PRG1
?REP2:	ZERO?	V /FALSE
	PRINTI	", dropping your equipment"
	RTRUE	


	.FUNCT	INTERRUPT-CHECK,DUR,C,E,TICK,FOO,R
	ADD	C-TABLE,C-INTS >C
	ADD	C-TABLE,C-TABLELEN >E
	SET	'ASLEEP,TRUE-VALUE
?PRG1:	EQUAL?	C,E \?ELS5
	JUMP	?REP2
?ELS5:	GET	C,C-ENABLED?
	ZERO?	STACK /?CND3
	GET	C,C-TICK >TICK
	ZERO?	TICK \?ELS10
	JUMP	?CND3
?ELS10:	SUB	TICK,DUR >FOO
	LESS?	FOO,2 \?ELS15
	GET	C,C-RTN
	CALL	STACK
	SUB	TICK,1
	PUT	C,C-TICK,STACK
	JUMP	?CND8
?ELS15:	PUT	C,C-TICK,FOO
?CND8:	
?CND3:	ADD	C,C-INTLEN >C
	JUMP	?PRG1
?REP2:	SET	'ASLEEP,FALSE-VALUE
	RETURN	ASLEEP


	.FUNCT	LE?,LAT,LON,CNST,?TMP1
	MUL	LAT,LATITUDE-SET >?TMP1
	MUL	LON,LONGITUDE-SET
	ADD	?TMP1,STACK
	GRTR?	STACK,CNST /FALSE
	RTRUE	


	.FUNCT	GE?,LAT,LON,CNST,?TMP1
	MUL	LAT,LATITUDE-SET >?TMP1
	MUL	LON,LONGITUDE-SET
	ADD	?TMP1,STACK
	LESS?	STACK,CNST /FALSE
	RTRUE	


	.FUNCT	OCEAN-BOTTOM-FCN
	LESS?	LONGITUDE-SET,5 /?THN6
	GRTR?	LONGITUDE-SET,55 /?THN6
	LESS?	LATITUDE-SET,5 /?THN6
	GRTR?	LATITUDE-SET,45 \?ELS5
?THN6:	CALL	JIGS-UP,STR?447
	RSTACK	
?ELS5:	GRTR?	LATITUDE-SET,17 /?ELS9
	CALL	LE?,2,-5,-11
	ZERO?	STACK /?ELS9
	CALL	LE?,1,1,30
	ZERO?	STACK \FALSE
?ELS9:	GRTR?	LATITUDE-SET,6 /?ELS13
	GRTR?	LONGITUDE-SET,36 /?ELS13
	LESS?	LONGITUDE-SET,34 \FALSE
?ELS13:	GRTR?	LONGITUDE-SET,34 /?ELS17
	GRTR?	LATITUDE-SET,7 /?ELS17
	CALL	LE?,1,-1,-26
	ZERO?	STACK \FALSE
?ELS17:	CALL	GE?,2,1,115
	ZERO?	STACK /?ELS21
	RETURN	400
?ELS21:	CALL	GE?,1,1,68
	ZERO?	STACK /?ELS23
	CALL	LE?,1,-2,-91
	ZERO?	STACK /?ELS23
	RETURN	400
?ELS23:	LESS?	LATITUDE-SET,40 \?THN32
	CALL	GE?,15,4,680
	ZERO?	STACK \?THN32
	CALL	GE?,2,1,107
	ZERO?	STACK \?THN32
	CALL	GE?,1,1,76
	ZERO?	STACK \?THN32
	LESS?	LONGITUDE-SET,44 /?ELS27
	CALL	GE?,2,1,70
	ZERO?	STACK /?ELS27
	LESS?	LONGITUDE-SET,52 \?THN32
	CALL	LE?,5,-3,-57
	ZERO?	STACK \?THN32
	CALL	LE?,1,-1,-31
	ZERO?	STACK /?ELS27
?THN32:	RETURN	350
?ELS27:	GRTR?	LATITUDE-SET,37 /?THN40
	CALL	GE?,6,1,240
	ZERO?	STACK \?THN40
	CALL	GE?,13,6,635
	ZERO?	STACK \?THN40
	CALL	GE?,1,1,72
	ZERO?	STACK \?THN40
	LESS?	LONGITUDE-SET,41 /?ELS35
	CALL	GE?,13,8,497
	ZERO?	STACK /?ELS35
	LESS?	LONGITUDE-SET,49 \?THN40
	CALL	LE?,6,-5,-121
	ZERO?	STACK \?THN40
	CALL	LE?,2,-3,-103
	ZERO?	STACK /?ELS35
?THN40:	RETURN	300
?ELS35:	LESS?	LATITUDE-SET,35 \?THN48
	CALL	GE?,2,-1,57
	ZERO?	STACK \?THN48
	CALL	GE?,44,15,1810
	ZERO?	STACK \?THN48
	CALL	GE?,4,3,230
	ZERO?	STACK \?THN48
	LESS?	LONGITUDE-SET,37 /?ELS43
	CALL	GE?,13,7,415
	ZERO?	STACK /?ELS43
	LESS?	LONGITUDE-SET,46 \?THN48
	CALL	LE?,3,-2,-32
	ZERO?	STACK /?ELS43
?THN48:	RETURN	250
?ELS43:	GRTR?	LATITUDE-SET,19 /?ELS55
	CALL	LE?,5,3,131
	ZERO?	STACK /?ELS55
	CALL	LE?,7,6,214
	ZERO?	STACK \?THN52
?ELS55:	GRTR?	LATITUDE-SET,7 /?ELS57
	GRTR?	LONGITUDE-SET,35 \?THN52
?ELS57:	GRTR?	LATITUDE-SET,8 /?ELS51
	CALL	LE?,2,-1,-16
	ZERO?	STACK /?ELS51
	CALL	LE?,1,1,45
	ZERO?	STACK /?ELS51
	CALL	LE?,2,1,51
	ZERO?	STACK /?ELS51
?THN52:	RETURN	50
?ELS51:	GRTR?	LATITUDE-SET,20 /?ELS65
	CALL	LE?,2,1,50
	ZERO?	STACK /?ELS65
	CALL	LE?,10,7,286
	ZERO?	STACK \?THN62
?ELS65:	GRTR?	LATITUDE-SET,9 /?ELS61
	CALL	LE?,3,2,99
	ZERO?	STACK /?ELS61
?THN62:	RETURN	100
?ELS61:	GRTR?	LATITUDE-SET,22 /?THN74
	CALL	LE?,5,3,140
	ZERO?	STACK \?THN74
	CALL	LE?,7,3,172
	ZERO?	STACK \?THN70
?THN74:	GRTR?	LATITUDE-SET,10 /?ELS69
	CALL	LE?,9,5,270
	ZERO?	STACK /?ELS69
?THN70:	RETURN	150
?ELS69:	GRTR?	LONGITUDE-SET,29 /?ELS79
	LESS?	LONGITUDE-SET,18 /?ELS79
	GRTR?	LATITUDE-SET,24 /?ELS79
	LESS?	LATITUDE-SET,19 /?ELS79
	CALL	LE?,9,4,296
	ZERO?	STACK /?ELS79
	CALL	GE?,4,1,102
	ZERO?	STACK /?ELS79
	CALL	GE?,2,1,62
	ZERO?	STACK /?ELS79
	RETURN	50
?ELS79:	GRTR?	LATITUDE-SET,28 /?ELS83
	LESS?	LATITUDE-SET,17 /?ELS83
	GRTR?	LONGITUDE-SET,34 /?ELS83
	LESS?	LONGITUDE-SET,15 /?ELS83
	CALL	LE?,1,-1,11
	ZERO?	STACK /?ELS83
	CALL	GE?,1,1,39
	ZERO?	STACK /?ELS83
	CALL	GE?,5,2,141
	ZERO?	STACK /?ELS83
	CALL	GE?,1,-1,-15
	ZERO?	STACK /?ELS83
	CALL	LE?,4,1,118
	ZERO?	STACK \?THN86
	CALL	LE?,6,5,268
	ZERO?	STACK /?ELS83
?THN86:	RETURN	100
?ELS83:	GRTR?	LATITUDE-SET,32 /?ELS89
	LESS?	LATITUDE-SET,16 /?ELS89
	GRTR?	LONGITUDE-SET,38 /?ELS89
	CALL	GE?,5,-3,-19
	ZERO?	STACK /?ELS89
	CALL	GE?,7,3,196
	ZERO?	STACK /?ELS89
	CALL	GE?,3,7,164
	ZERO?	STACK /?ELS89
	CALL	LE?,1,-1,18
	ZERO?	STACK /?ELS89
	CALL	LE?,7,6,344
	ZERO?	STACK \?THN92
	CALL	LE?,11,4,394
	ZERO?	STACK /?ELS89
?THN92:	RETURN	150
?ELS89:	RETURN	200


	.FUNCT	I-HUNGER,N,?TMP1
	ZERO?	ASLEEP \FALSE
	INC	'HOW-HUNGRY
	EQUAL?	HOW-HUNGRY,1 \?ELS9
	CALL	QUEUE,I-HUNGER,300
	PUT	STACK,0,1
	RFALSE	
?ELS9:	EQUAL?	HOW-HUNGRY,2 \?ELS11
	CALL	QUEUE,I-HUNGER,20
	PUT	STACK,0,1
	PRINTI	"You begin to feel hungry."
	CRLF	
	RFALSE	
?ELS11:	EQUAL?	HOW-HUNGRY,3 \?ELS15
	CALL	QUEUE,I-HUNGER,20
	PUT	STACK,0,1
	PRINTI	"Your stomach begins to bother you. Better "
	CALL	META-LOC,PLAYER >?TMP1
	CALL	META-LOC,FOOD
	EQUAL?	?TMP1,STACK \?ELS20
	PRINTI	"do something about it"
	JUMP	?CND18
?ELS20:	PRINTI	"find some food"
?CND18:	PRINTI	"!"
	CRLF	
	RFALSE	
?ELS15:	GRTR?	HOW-HUNGRY,3 \FALSE
	EQUAL?	HERE,SHANTY \?ELS33
	SET	'N,2
	JUMP	?CND31
?ELS33:	SET	'N,6
?CND31:	CALL	QUEUE,I-HUNGER,N
	PUT	STACK,0,1
	PRINTI	"Your stomach is growling loudly."
	CRLF	
	RETURN	2


	.FUNCT	I-THIRST
	ZERO?	ASLEEP \FALSE
	INC	'HOW-THIRSTY
	EQUAL?	HOW-THIRSTY,1 \?ELS9
	CALL	QUEUE,I-THIRST,110
	PUT	STACK,0,1
	PRINTI	"Your throat starts to feel dry."
	CRLF	
	RFALSE	
?ELS9:	EQUAL?	HOW-THIRSTY,2 \?ELS13
	CALL	QUEUE,I-THIRST,115
	PUT	STACK,0,1
	PRINTI	"You feel fairly thirsty."
	CRLF	
	RFALSE	
?ELS13:	EQUAL?	HOW-THIRSTY,3 \?ELS17
	CALL	QUEUE,I-THIRST,15
	PUT	STACK,0,1
	CALL	TELL-YOUD-BETTER,STR?448
	RFALSE	
?ELS17:	GRTR?	HOW-THIRSTY,3 \FALSE
	CALL	QUEUE,I-THIRST,4
	PUT	STACK,0,1
	PRINTI	"You lick your lips and clear your throat."
	CRLF	
	RETURN	2


	.FUNCT	I-TIRED
	ZERO?	ASLEEP \FALSE
	LESS?	HOW-TIRED,6 \?CND1
	INC	'HOW-TIRED
?CND1:	EQUAL?	HOW-TIRED,1 \?ELS11
	CALL	QUEUE,I-TIRED,479
	PUT	STACK,0,1
	RFALSE	
?ELS11:	EQUAL?	HOW-TIRED,2 \?ELS13
	CALL	QUEUE,I-TIRED,1
	PUT	STACK,0,1
	RFALSE	
?ELS13:	EQUAL?	HOW-TIRED,3 \?ELS15
	CALL	QUEUE,I-TIRED,30
	PUT	STACK,0,1
	PRINTR	"You yawn as you begin to feel drowsy."
?ELS15:	EQUAL?	HOW-TIRED,4 \?ELS19
	CALL	QUEUE,I-TIRED,20
	PUT	STACK,0,1
	PRINTI	"You are starting to feel tired."
	CRLF	
	RFALSE	
?ELS19:	EQUAL?	HOW-TIRED,5 \?ELS23
	CALL	QUEUE,I-TIRED,10
	PUT	STACK,0,1
	PRINTR	"You yawn and feel very tired. Think about going to bed."
?ELS23:	EQUAL?	HOW-TIRED,6 \FALSE
	PRINTI	"Exhaustion overwhelms you. Keeping your eyes open is painful."
	ZERO?	AT-SEA \?ELS32
	PRINTI	" "
	CALL	V-SLEEP
	RETURN	2
?ELS32:	CALL	QUEUE,I-TIRED,6
	PUT	STACK,0,1
	CRLF	
	RETURN	2


	.FUNCT	I-SQUID,L
	LOC	SQUID >L
	CALL	META-LOC,PLAYER
	EQUAL?	STACK,L \?ELS5
	CALL	JIGS-UP,STR?449
	RSTACK	
?ELS5:	CALL	INT,I-SQUID
	PUT	STACK,0,0
	RFALSE	


	.FUNCT	I-SHARK
	GETP	HERE,P?LINE
	LESS?	STACK,UNDERWATER-LINE-C \?ELS5
	CALL	INT,I-SHARK
	PUT	STACK,0,0
	MOVE	SHARK,LOCAL-GLOBALS
	FCLEAR	SHARK,ONBIT
	RFALSE	
?ELS5:	IN?	SHARK,UNDERWATER \?ELS7
	IN?	SHARK-REPELLENT,PLAYER \?ELS12
	FSET?	SHARK-REPELLENT,OPENBIT \?ELS12
	MOVE	SHARK,WINDING-ROAD-2
	CALL	INT,I-SHARK
	PUT	STACK,0,0
	ZERO?	LIT /FALSE
	FSET?	SHARK,ONBIT \?ELS19
	PRINTI	"The shark continues"
	JUMP	?CND15
?ELS19:	PRINTI	"A shark swims"
?CND15:	PRINTR	" toward you, then stops. It turns and swims away."
?ELS12:	FSET?	SHARK,ONBIT \?ELS32
	PRINTI	"The shark"
	JUMP	?CND30
?ELS32:	ZERO?	LIT /?ELS36
	PRINTI	"A shark"
	JUMP	?CND30
?ELS36:	PRINTI	"Something"
?CND30:	CALL	JIGS-UP,STR?450
	RSTACK	
?ELS7:	MOVE	SHARK,UNDERWATER
	CALL	QUEUE,I-SHARK,-1
	PUT	STACK,0,1
	ZERO?	LIT /FALSE
	FSET	SHARK,ONBIT
	PRINTR	"A shark swims toward you!"


	.FUNCT	I-PLUMMET
	INC	'CRIMP-CTR
	EQUAL?	CRIMP-CTR,1 \?ELS5
	CALL	QUEUE,I-PLUMMET,-1
	PUT	STACK,0,1
	CALL	GLOBAL-IN?,FALLEN-BUNK,HERE
	ZERO?	STACK /FALSE
	SET	'P-IT-OBJECT,FALLEN-BUNK
	PRINTR	"The row of bunks you moved starts to fall."
?ELS5:	EQUAL?	CRIMP-CTR,2 \?ELS14
	CALL	GLOBAL-IN?,FALLEN-BUNK,HERE
	ZERO?	STACK /FALSE
	SET	'P-IT-OBJECT,FALLEN-BUNK
	PRINTI	"The row of bunks falls toward the doorway"
	EQUAL?	HERE,WRECK-8 \?ELS24
	PRINTI	", threatening to pinch your "
	CALL	DPRINT,AIR-HOSE
	PRINTI	"!"
	JUMP	?CND22
?ELS24:	PRINTI	"."
?CND22:	CRLF	
	RTRUE	
?ELS14:	EQUAL?	CRIMP-CTR,3 \FALSE
	CALL	GLOBAL-IN?,FALLEN-BUNK,HERE
	ZERO?	STACK /?ELS37
	EQUAL?	HERE,WRECK-8 \?ELS42
	CALL	JIGS-UP,STR?451
	RSTACK	
?ELS42:	SET	'BUNKS-MOVED,FALSE-VALUE
	SET	'P-IT-OBJECT,FALLEN-BUNK
	PRINTR	"The bunks fall back into the doorway, blocking the passage."
?ELS37:	EQUAL?	HERE,WRECK-1,WRECK-2,WRECK-3 /?THN49
	EQUAL?	HERE,WRECK-4,WRECK-5,WRECK-6 /?THN49
	EQUAL?	HERE,UNDERWATER \?ELS48
?THN49:	SET	'BUNKS-MOVED,FALSE-VALUE
	RFALSE	
?ELS48:	CALL	JIGS-UP,STR?452
	RSTACK	


	.FUNCT	I-LIVER
	GRTR?	BLOOD-ALCOHOL,0 \?CND1
	DEC	'BLOOD-ALCOHOL
?CND1:	GRTR?	SLOSH-CTR,0 \?CND4
	DEC	'SLOSH-CTR
?CND4:	CALL	QUEUE,I-LIVER,10
	PUT	STACK,0,1
	GRTR?	BLOOD-ALCOHOL,15 \FALSE
	PRINTI	"Your head swims for a minute."
	CRLF	
	RETURN	2


	.FUNCT	I-PENDULUM,DIR=0
	CALL	QUEUE,I-PENDULUM,-2
	EQUAL?	LINE-LOC,5 \?ELS3
	SET	'LINE-LOC-INC,-1
	JUMP	?CND1
?ELS3:	EQUAL?	LINE-LOC,1 \?ELS5
	SET	'LINE-LOC-INC,1
	JUMP	?CND1
?ELS5:	CALL	META-LOC,PLAYER
	IN?	SAFETY-LINE,STACK \?CND1
	EQUAL?	LINE-LOC-INC,1 \?ELS10
	SET	'DIR,STR?170
	JUMP	?CND1
?ELS10:	SET	'DIR,STR?171
?CND1:	ADD	LINE-LOC,LINE-LOC-INC >LINE-LOC
	EQUAL?	LINE-LOC,2 \?ELS17
	MOVE	SAFETY-LINE,WEST-OF-WRECK-9
	EQUAL?	HERE,WEST-OF-WRECK-9 \FALSE
	CALL	TELL-LINE-SWINGS
	RSTACK	
?ELS17:	EQUAL?	LINE-LOC,4 \?ELS24
	MOVE	SAFETY-LINE,WEST-OF-WRECK-11
	EQUAL?	HERE,WEST-OF-WRECK-11 \FALSE
	CALL	TELL-LINE-SWINGS
	RSTACK	
?ELS24:	MOVE	SAFETY-LINE,LOCAL-GLOBALS
	ZERO?	DIR /FALSE
	PRINTI	"The line swings away to the "
	PRINT	DIR
	PRINTR	"."


	.FUNCT	TELL-LINE-SWINGS
	PRINTI	"The "
	CALL	DPRINT,SAFETY-LINE
	PRINTI	" from above swings in from the "
	EQUAL?	LINE-LOC-INC,1 \?ELS5
	PRINTI	"south"
	JUMP	?CND3
?ELS5:	PRINTI	"north"
?CND3:	PRINTR	"."


	.FUNCT	I-CASE-LEAK,ALREADY=0
	INC	'WATER-IN-CASE
	GRTR?	WATER-IN-CASE,9 \?CND1
	FSET?	STAMPS,RMUNGBIT \?CND4
	SET	'ALREADY,TRUE-VALUE
?CND4:	FSET	STAMPS,RMUNGBIT
	CALL	INT,I-CASE-LEAK
	PUT	STACK,0,0
?CND1:	IN?	GLASS-CASE,PLAYER \FALSE
	PRINTI	"The water level in the "
	CALL	DPRINT,GLASS-CASE
	PRINTI	" rises."
	FSET?	STAMPS,RMUNGBIT \?CND14
	ZERO?	ALREADY \?CND14
	PRINTI	" As it reaches the stamps, it soaks them."
?CND14:	CRLF	
	RTRUE	


	.FUNCT	I-DRILL
	FSET	BATTERY,RMUNGBIT
	SET	'DRILL-POWERED,FALSE-VALUE
	CALL	INT,I-DRILL
	PUT	STACK,0,0
	PRINTI	"The "
	CALL	DPRINT,DRILL
	PRINTR	" sputters, and the bit stops turning."


	.FUNCT	I-AIR-SUPPLY
	GETP	HERE,P?LINE
	EQUAL?	STACK,UNDERWATER-LINE-C \FALSE
	IN?	AIR-TANK,PLAYER \FALSE
	CALL	AIRTIGHT-ROOM?
	ZERO?	STACK \FALSE
	ADD	DEPTH,33
	DIV	STACK,44
	SUB	AIR-LEFT,STACK >AIR-LEFT
	LESS?	AIR-LEFT,1 \?ELS12
	CALL	JIGS-UP,STR?453
	RSTACK	
?ELS12:	LESS?	AIR-LEFT,15 \FALSE
	PRINTI	"Your air supply is dangerously low."
	CRLF	
	EQUAL?	WAITED?,1 /TRUE
	RETURN	2


	.FUNCT	I-MM-COMPRESSOR
	CALL	QUEUE,I-LAST-GASP,10
	PUT	STACK,0,1
	GETP	HERE,P?LINE
	EQUAL?	STACK,UNDERWATER-LINE-C \FALSE
	PRINTI	"You have to breathe harder. Maybe you'd better surface."
	CRLF	
	RETURN	2


	.FUNCT	I-LAST-GASP
	GETP	HERE,P?LINE
	EQUAL?	STACK,UNDERWATER-LINE-C \?ELS5
	CALL	JIGS-UP,STR?454
	RSTACK	
?ELS5:	CALL	QUEUE,I-LAST-GASP,1
	PUT	STACK,0,0
	RTRUE	


	.FUNCT	I-PLOT-NEVER-STARTS
	CALL	INT,I-JOHNNY
	PUT	STACK,0,0
	CALL	INT,I-PETE
	PUT	STACK,0,0
	IN?	WEASEL,SHANTY \?CND1
	CALL	INT,I-WEASEL
	PUT	STACK,0,0
?CND1:	SET	'FM-CTR,5
	RFALSE	


	.FUNCT	I-ENDIT
	GETP	HERE,P?LINE
	LESS?	STACK,UNDERWATER-LINE-C \FALSE
	CALL	JIGS-UP,STR?455
	RSTACK	

	.ENDI
