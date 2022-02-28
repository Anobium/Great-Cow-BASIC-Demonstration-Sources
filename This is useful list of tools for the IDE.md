<div id="GCstudio-logo" align="left">
    <br />
    <img src="https://github.com/angelivan-spartan/GCstudio/raw/master/SRC/Logo/Icon/res/256.png" alt="GC Studio Logo" width="210"/>
    <h1>GC Studio</h1>
</div>

# This is useful list of tools for the IDE!

## 1. Want to see all the GCBASIC related tasks?

        Press <F4>  - this will list all the tasks that are set up for GCBASIC


## 2, What keys do what?

        <F1>        Help - opens GCBASIC Help, when a word is selected <F1> will open a Word Help Specific Page.
        <F2>        The IDE Command Pallete - a long list of all the options
        <F3>        Find
        <F4>        GCBASIC command set
        <F5>        Compile, create HEX and Program
        <F6>        Compile to create HEX only
        <F7>        Compile ASM only
        <F7>+SHIFT  Open ASM file
        <F7>+WINDOW Open S file
        <F9>        Open Serial Terminal


## 3. Want to show the serial ports?

        Select the following line of text then select "Terminal/Run Selected Text", then, close the Terminal window when you have completed the port review by selecting the Trash Can (top right).

            Get-WMIObject Win32_SerialPort | Select-Object Name,DeviceID,Description


## 4. Want to show the current installation folder? 

        Select the following line of text then select "Terminal/Run Selected Text", then, close the Terminal window when you have completed the review of the envronment by selecting the Trash Can (top right).
    
            ${env:GCBASIC_INSTALL_PATH}
  

            