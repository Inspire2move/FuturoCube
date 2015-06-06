/*

ReadAcc.p


*/

#include <futurocube>

new data[3]
new stop
new i
new freq = 100 
new len = 1000

main()
{
	stop = true

	while(stop)
	{
		ReadAcc(data,0)
		printf("%d, %d, %d, %d \n", data[0], data[1], data[2], i*freq)
		Delay(freq)
		if (i == len) stop = false
		i++	
	}
}

