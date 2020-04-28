# Baseball_hit_prediction-
 Using Logistic regression to predict whether a pitch will be a hit or not based on a big data with more than 70 dimensions  Using the Trackman pitch-level data building a model that predicts the probability of a batted ball being a hit based on batted ball characteristics and relevant contextual data. Please regard fielding errors as non-out hits for the purposes of this analysis.

To better understand the data-set please refer to the glossary below which explains what each feature means, especially one who doesn't follow baseball can really get lost going through all the features of this massive data-set. 

_ _ _ _ _ _ _ _ _ _ _ _ GLOSSARY _ _ _ _ _ _ _ _ _ _ _ _

GameId- The unique key identifier per game \n
BallparkId- The unique key identifier for each unique ball park the specific game is being played at 
GameEventId- The unique key identifier for each unique game event 
GameTime- The time the game began at 
Season- The season the game was played 
AtBatId- The unique key identifier for the at bat 
TrackmanUid- The unique key identifier of the pitch 
BatterId- The unique key identifier of the batter hitting 
BatterHitting- Which side of the plate the batter is hitting from 
BatterPositionId- The position on the field the batter plays 
batterTimesFaced- The amount of times the pitcher has faced the batted in the game 
cumulativeBattersFaced- The amount of batters the pitcher has faced in the game 
PinchHit- Was the batter pinch hitting? 
PitcherId- The unique key identifier of the pitcher pitching 
PitcherThrowing- Which arm does the pitcher throw with 
CatcherId- The unique key identifier of the catcher 
HomeTeamId- The unique key identifier of the home team 
AwayTeamId- The unique key identifier of the away team 
PitchType- The classified pitch type of the pitch 
Balls- How many balls in the count when the pitch was thrown 
Strikes- How many strikes in the count when the pitch was thrown 
Outs- How many outs in the inning when the pitch was thrown 
Inning- The inning the pitch was thrown 
InningTop- Was it the top or the bottom of the inning 
PlateAppearance- Plate appearance of the inning 
PitchOfPA- How many pitches in the plate appearance before the pitch 
Runners_on- Were there runners on 
calledStrike- Was the pitch called a strike? 
Swing- Did the pitch generate a swing? 
swingStrike- Did the pitch generate a swing and a miss? 
Foul- Did the pitch generate a foul? 
inPlay- Was the pitch hit into play? 
H1b- Did the pitch result in a single? 
H2b- Did the pitch result in a double? 
H3b- Did the pitch result in a triple? 
hr- Did the pitch result in a homerun? 
fieldingError- Did the pitch result in a fielding error? 
inPlayOut- Was the play an out? 
HorzBreak- How much horizontal movement did the pitch generate? 
VertBreak- How much horizontal movement did the pitch generate? 
StartSpeed- How hard was the pitch thrown? 
Px- The terminal horizontal location of the pitch 
Pz- The terminal vertical location of the pitch 
RelHeight- How high the pitch was released by the pitcher? 
RelSide- How far from the pitcher’s body was the pitch released? 
Extension- How far from the pitcher’s body (towards the plate) was the pitch released? 
VertRelAngle- The vertical release angle of the pitch 
HorzRelAngle- The horizontal release angle of the pitch 
SpinRate- The spin rate of the pitch 
SpinAxis- The axis orientation of the pitch (0-360 degrees) 
BatterHeight- How tall the batter is 
PitcherHeight- How tall the pitcher is 
ExitSpeed- How hard the batted ball was hit off the bat 
Angle- The angle off the bat in which the ball was hit 
Bearing- The angle from the landing position of the ball and home plate 
Direction- The angle off the bat on contact and home plate 
