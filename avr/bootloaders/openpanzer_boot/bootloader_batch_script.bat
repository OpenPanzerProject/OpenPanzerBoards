REM ----------------------------------------------------------------------------------------------------------->>
REM - This will burn a bootloader. First it will set the fuse bits and unlock the bootloader section, then it 
REM - will burn the bootloader and re-lock the bootloader section
REM ----------------------------------------------------------------------------------------------------------->>


REM ----------------------------------------------------------------------------------------------------------->>
REM ----------------------------------------------------------------------------------------------------------->>
REM -   SET YOUR PATHS HERE 
REM - 
REM -   CHANGE THESE PATHS TO MATCH YOUR LOCAL SYSTEM
REM -   AVOID SPACES AND OTHER SPECIAL CHARACTERS IN YOUR PATH ! 
REM - 
REM ----------------------------------------------------------------------------------------------------------->>
REM - Not having any spaces in the file name will save you infinite heartache. 
REM - You also for sure don't want any parentheses in the file name either, AVRDUDE will croak for sure if it sees those
REM - Best also not to use any quotation marks! 

REM - Path to avrdude.conf file: 
set conf_file=C:\openpanzer_boot\avrdude\avrdude.conf

REM - Path to avrdude.exe
set avrdude_exe=C:\openpanzer_boot\avrdude\avrdude.exe

REM - Path to bootloader hex
set boot_hex=C:\openpanzer_boot\optcb2560_boot.hex



REM ----------------------------------------------------------------------------------------------------------->>
REM ----------------------------------------------------------------------------------------------------------->>
REM -   SET YOUR PROGRAMMER TYPE HERE 
REM - 
REM ----------------------------------------------------------------------------------------------------------->>
REM - See http://www.nongnu.org/avrdude/user-manual/avrdude_4.html for a list of programmers, or type avrdude -c ?
REM - Use this for the USBasp. If using the USBasp, you can also ignore the warning message avrdude will give you about sck 
REM - The two most common aare usbasp and avrispmkII

REM set programmer=avrispmkII
set programmer=usbasp           


REM ----------------------------------------------------------------------------------------------------------->>


REM - FUSES - Don't change these, they are correct for the TCB Mk !
REM ----------------------------------------------------------------------------------------------------------->>
set EFUSE=0xFD
set HFUSE=0xDA
set LFUSE=0xF7
set ULOCKF=0x3F
set LOCKF=0x0F



REM - THIS WILL DO THE EXECUTING - DON'T CHANGE ANYTHING BELOW HERE
REM ----------------------------------------------------------------------------------------------------------->>
REM - The start cmd.exe /k lets us open the command prompt first and then leave it open so we can see if it worked. 
REM - First half: chip erase (-e), unlock boot section, write fuses. Next comes a "+" symbol to add the second half: 
REM - Second half: now we write the bootloader to flash, then finish by locking the boot section
start "Flash Bootloader" cmd.exe /K "%avrdude_exe% -C %conf_file% -p atmega2560 -c %programmer% -P usb -v -e -U lock:w:%ULOCKF%:m -U efuse:w:%EFUSE%:m -U hfuse:w:%HFUSE%:m -U lfuse:w:%LFUSE%:m && %avrdude_exe% -C %conf_file% -p atmega2560 -c %programmer% -P usb -v -U flash:w:%boot_hex%:i -U lock:w:%LOCKF%:m" 
