# Great-Cow-BASIC

This GIT contains the latest user contributed demonstrations. 

The baseline set of demonstrations was created at version 0.98.00 of the Great Cow BASIC distrubution.

Please add you demonstrations and improve those that have been posted.

Enjoy


# Documentation of Demonstration Programs

Key Point: Try to provide a complete reference, describing all relevant aspects of the demonstration, and putting code-related terms in code font.

When you are documenting a demonstration, provide a complete references for another methods, typically generated from source code using doc comments that describe all public constants, methods, local constants, and other variables.

Use the basic guidelines in this document as appropriate for the Great Cow BASIC language.

This page also does not cover libraries.   The style suggestions below may be useful to keep in mind while documenting Great Cow BASIC demonstrations.

#Overall Program Layout

This is the standard program. This is included in every Great Cow BASIC installation.  See Snippets.

----
    '''A program  for GCGB and GCB the demonsations......
    '''--------------------------------------------------------------------------------------------------------------------------------
    '''This program [todo]
    '''
    '''@author     [todo]
    '''@licence    GPL
    '''@version    [todo]
    '''@date       [todo]
    '''********************************************************************************

    ; ----- Configuration
     #chip [todo]
     #config [todo]
     #include [todo]

     #option explicit
     
    ; ----- Constants
      ' No Constants specified in this example.
      ' [todo]

    ; ----- Define Hardware settings
      ' [todo]

    ; ----- Variables
      ' No Variables specified in this example. All byte variables are defined upon use.
      ' [todo]

    ; ----- Quick Command Reference:
      [todo]

    ; ----- Main body of program commences here.

    end
    ; ----- Support methods.  Subroutines and Functions
----

The template should be completed with the sections marked `[todo]` being updated as appropiate.

#Language Style

It is *Great Cow BASIC* always not any variant. 

The license is for Great Cow BASIC and not any other variant.

Do not use slang - for example use `do not` do not use `don't`.  Great Cow BASIC users may not have English as first language.

Use microcontroller not `part`, `chip`, `pic` or any other variant.

#Method Support for Peripheral Programming Support (PPS)

The PPS method needs to go at the top of the program .

The PPS method should must show the version of the PPSTool used to generate the method.

Porting to another microcontroller is easier as the user can locate the PPS method and removed.

#Coding Good Practice

The Great Cow BASIC demonstration must provide a description for each of the following:
 - Every constant, variable,  etc.
 - Every method, with a description for each parameter, the return value, and any exceptions thrown.

`#option explicit` should be used to ensure all variables are defined.

Variables should be defined to respresent the variable type such as myADCValueByte, myOutPutString etc.

Place a `Do forever-loop` priot to the end of of program is a good practice.  Serial transmission can be messed up if we got straight to an ‘end’.  

All serial communications need to 9600 BPS. Assume a standard dump terminal with no suport for ANSI etc.


Enjoy


Change log.
1.  First release.  A dump of an email to this document.



