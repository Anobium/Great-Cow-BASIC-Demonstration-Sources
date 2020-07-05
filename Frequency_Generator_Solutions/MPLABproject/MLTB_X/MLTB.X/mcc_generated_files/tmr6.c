/**
  TMR6 Generated Driver File

  @Company
    Microchip Technology Inc.

  @File Name
    tmr6.c

  @Summary
    This is the generated driver implementation file for the TMR6 driver using PIC10 / PIC12 / PIC16 / PIC18 MCUs

  @Description
    This source file provides APIs for TMR6.
    Generation Information :
        Product Revision  :  PIC10 / PIC12 / PIC16 / PIC18 MCUs - 1.81.3
        Device            :  PIC16F18446
        Driver Version    :  2.11
    The generated drivers are tested against the following:
        Compiler          :  XC8 2.20 and above 
        MPLAB 	          :  MPLAB X 5.40
*/

/*
    (c) 2018 Microchip Technology Inc. and its subsidiaries. 
    
    Subject to your compliance with these terms, you may use Microchip software and any 
    derivatives exclusively with Microchip products. It is your responsibility to comply with third party 
    license terms applicable to your use of third party software (including open source software) that 
    may accompany Microchip software.
    
    THIS SOFTWARE IS SUPPLIED BY MICROCHIP "AS IS". NO WARRANTIES, WHETHER 
    EXPRESS, IMPLIED OR STATUTORY, APPLY TO THIS SOFTWARE, INCLUDING ANY 
    IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY, AND FITNESS 
    FOR A PARTICULAR PURPOSE.
    
    IN NO EVENT WILL MICROCHIP BE LIABLE FOR ANY INDIRECT, SPECIAL, PUNITIVE, 
    INCIDENTAL OR CONSEQUENTIAL LOSS, DAMAGE, COST OR EXPENSE OF ANY KIND 
    WHATSOEVER RELATED TO THE SOFTWARE, HOWEVER CAUSED, EVEN IF MICROCHIP 
    HAS BEEN ADVISED OF THE POSSIBILITY OR THE DAMAGES ARE FORESEEABLE. TO 
    THE FULLEST EXTENT ALLOWED BY LAW, MICROCHIP'S TOTAL LIABILITY ON ALL 
    CLAIMS IN ANY WAY RELATED TO THIS SOFTWARE WILL NOT EXCEED THE AMOUNT 
    OF FEES, IF ANY, THAT YOU HAVE PAID DIRECTLY TO MICROCHIP FOR THIS 
    SOFTWARE.
*/

/**
  Section: Included Files
*/

#include <xc.h>
#include "tmr6.h"

/**
  Section: Global Variables Definitions
*/

/**
  Section: TMR6 APIs
*/

void TMR6_Initialize(void)
{
    // Set TMR6 to the options selected in the User Interface

    // T6CS CLKR; 
    T6CLKCON = 0x08;

    // T6PSYNC Not Synchronized; T6MODE Starts at T6ON = 1 and TMR6_ers = 1; T6CKPOL Rising Edge; T6CKSYNC Synchronized; 
    T6HLT = 0x21;

    // T6RSEL CLC1_out; 
    T6RST = 0x0D;

    // T6PR 9; 
    T6PR = 0x09;

    // TMR6 0; 
    T6TMR = 0x00;

    // Clearing IF flag.
    PIR4bits.TMR6IF = 0;

    // T6CKPS 1:1; T6OUTPS 1:1; TMR6ON on; 
    T6CON = 0x80;
}

void TMR6_ModeSet(TMR6_HLT_MODE mode)
{
   // Configure different types HLT mode
    T6HLTbits.MODE = mode;
}

void TMR6_ExtResetSourceSet(TMR6_HLT_EXT_RESET_SOURCE reset)
{
    //Configure different types of HLT external reset source
    T6RSTbits.RSEL = reset;
}

void TMR6_Start(void)
{
    // Start the Timer by writing to TMRxON bit
    T6CONbits.TMR6ON = 1;
}

void TMR6_StartTimer(void)
{
    TMR6_Start();
}

void TMR6_Stop(void)
{
    // Stop the Timer by writing to TMRxON bit
    T6CONbits.TMR6ON = 0;
}

void TMR6_StopTimer(void)
{
    TMR6_Stop();
}

uint8_t TMR6_Counter8BitGet(void)
{
    uint8_t readVal;

    readVal = TMR6;

    return readVal;
}

uint8_t TMR6_ReadTimer(void)
{
    return TMR6_Counter8BitGet();
}

void TMR6_Counter8BitSet(uint8_t timerVal)
{
    // Write to the Timer6 register
    TMR6 = timerVal;
}

void TMR6_WriteTimer(uint8_t timerVal)
{
    TMR6_Counter8BitSet(timerVal);
}

void TMR6_Period8BitSet(uint8_t periodVal)
{
   PR6 = periodVal;
}

void TMR6_LoadPeriodRegister(uint8_t periodVal)
{
   TMR6_Period8BitSet(periodVal);
}

bool TMR6_HasOverflowOccured(void)
{
    // check if  overflow has occurred by checking the TMRIF bit
    bool status = PIR4bits.TMR6IF;
    if(status)
    {
        // Clearing IF flag.
        PIR4bits.TMR6IF = 0;
    }
    return status;
}
/**
  End of File
*/