'i2C Master with external PIC Slave
'Frequency of PIXACE is CRITICAL
'This is has been tested to interoperate with a PIC at 4mHz
'
'setfreq m4 works with i2cslow_32 which gives a MASTER I2C clock frequency from the PICAXE of 12.5kHz.  If the I2C clock frequency is any faster then inter-PIC commumications will fail.
'
setfreq m4
let b20=1
test:
	HI2cSetup I2CMASTER, $60, i2cslow_32, I2CBYTE 'I2C comms to PIC 
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