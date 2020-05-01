'i2C Master with external PIC Slave
'Frequency of PIXACE is CRITICAL
'This is has been tested to interoperate with a PIC at 4mHz
'
setfreq m1
let b20=1
test:
	HI2cSetup I2CMASTER, $60, i2cslow_4, I2CBYTE 'I2C comms to PIC 
	hi2cout (b20)
	pause 10
	hi2cin (b21)
	sertxd(cr,cr,"Returned from PIC: ",#b21,cr,cr,lf)
	b20=b20+1
	if b20 = 25 then
		b20 = 0	
	end if
	pause 500
goto test