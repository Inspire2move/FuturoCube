/* 
FTT.p



*/

#include <futurocube>

#define SIZE 256

const cBLACK = 0x00000000
const cGRAY = 0x70707000

new errorvar[SIZE]

new next_ms
new tempo
new cursor
new icon[]=[ICON_MAGIC1,ICON_MAGIC2,1,1,
  cGRAY,WHITE,cGRAY,  cBLACK,WHITE,cBLACK,  cBLACK,WHITE,cBLACK,
  '''', '''']

new getms
new prev
new diff
new error
new freq
new i
new data[3]
  
change_tempo(BPM)
{
  tempo = BPM
  next_ms = GetAppMsecs()
  
  /* draw the number and print on cube */
  SetIntensity(256)
  SetColor(cBLUE)
  ClearCanvas()
  /* construct walker in upper-most left corner with correct direction, draw number */
 ///  draw_number(_w(_side(GetCursor()),0),tempo)
  PrintCanvas()

  /* prepare white spots to flash */
  SetIntensity(30)
  SetColor(WHITE)
  DrawCube()
}  
  
main()
{
  new motion, taptype
  ICON(icon)
  SetVolume(5000)
  RegAllSideTaps()
  change_tempo(94)
  next_ms += 60000 / tempo
  new prev_side = 0
  i=0 

  for (;;)
  {
    cursor = GetCursor()
    Sleep()
    motion=Motion()
    if (GetAppMsecs()>=next_ms && tempo > 0)
    {
      if (prev_side <= 3)
      {
	    FlashCanvas(1,2,1) // zero at the end would override the number
      }
	  next_ms += 60000 / tempo
      if (prev_side != _side(cursor))
      {
        prev_side = _side(cursor)
        SetVolume(_side(cursor) * 4000)
        change_tempo(tempo) /* force redraw digits */
      }
	  if (prev_side != 5)
      {
		Play("ballhit")
	  }		
    }
    if (motion)
    {
      taptype = GetTapType(cursor)
      switch (taptype)
      {
      case 1: /* side - detect tempo */
      {
        printf("detect\n")
 ///       change_tempo( detect_tempo() )
      }

      case 2: /* top - increase BPM */
      {
 ///       change_tempo(min(300, tempo + 2))
 ///       printf("inc\n")
		prev = getms
		getms = GetAppMsecs()
		diff = getms - prev
		freq = (tempo * 1000) / 60
		error = diff - (60000 / tempo)
		errorvar[i] = error
 ///		printf("errorvar: %d \n", errorvar[i])
		ReadAcc(data,0)
		printf("ReadAcc: %d, %d, %d \n", data[0], data[1], data[2])
 ///		printf(" %4d ms | %4d ms | %d | %3d ms | %3d mHz | %3d ms\n", getms, prev, _side(cursor), diff, freq, error) 
		i++
      }

      case 3: /* bottom - decrease BPM */
      {
        change_tempo(max(0, tempo - 2))
        printf("dec\n")
      }
      }
      AckMotion()
    }
  }
}