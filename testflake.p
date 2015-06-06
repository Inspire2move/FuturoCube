

#include <futurocube>

new animationFinished
new animationTime
new oldside

main() {
	
	RegAllSideTaps()          
	RegMotion(TAP_DOUBLE)
	SetIntensity(128)
	SetColor(cGREEN)
	
	animationFinished = true
	animationTime = 600
	
	for(;;) {
		
		ClearCanvas
		
		if (!animationFinished) {
			SetColor(cRED)
								
			if (GetTimer(1)>(animationTime*3/4)) { 
				DrawSide(oldside)
			}
			if (GetTimer(1)>(animationTime/2) && GetTimer(1)<=(animationTime*3/4)) { 
				DrawSquare(_w(oldside,4))
			}
			if (GetTimer(1)>(animationTime/4) && GetTimer(1)<=(animationTime/2)) { 
				DrawCross(_w(oldside,4),1)
			}
			if (GetTimer(1)>1 && GetTimer(1)<=(animationTime/4)) { 
				DrawPoint(_w(oldside,4))
			}
			if (GetTimer(1)<=1) {
				animationFinished = true
			}				
		}
		
		if (animationFinished == true){
			SetTimer(1,animationTime)
			animationFinished = false
			oldside = GetRnd(6)
			Play("uff")
		}
	
	
	
		PrintCanvas
	}
}