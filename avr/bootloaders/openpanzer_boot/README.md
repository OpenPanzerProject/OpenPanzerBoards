## What Is In This Folder? 

This folder contains the custom bootloader used on the TCB - both a precompiled hex, and the source code. The bootloader is a small piece of code that remains on the TCB and allows the main program (firmware) to be rewritten easily using OP Config or the Arduino IDE without any special equipment other than USB cable. 

## Do I Need to Do Anything With This? 

Probably not, the bootloader should already come installed on your TCB from the factory. But if you are a developer, are curious, or for some reason need to re-write the bootloader on your device, read on. 

## Bootloader Details

This bootloader is a modification of the standard Arduino stk500boot bootloader used for the Mega boards. It was first modified by [Arduino Forum user Krupski](http://forum.arduino.cc/index.php?topic=309467.0) who removed the bulky and largely-unused Monitor utility and reduced the overall size of the bootloader to roughly 2KB. 

The Open Panzer project subsequently modified it further for our own purposes. The primary change is the ability to select which serial port you want to flash the chip when writing new firmware. This is done by the position of Dipswitch #5 on the TCB. 

When Dipswitch #5 is in the On position, the bootloader will listen on Serial 0, which is the onboard USB port on the TCB. 

When Dipswitch #5 is in the Off position the bootloader will listen on Serial 1, which is broken out as a six-pin header on the TCB. This header is fully compatible with typical FTDI adapters or cables, or most conveniently of all, the [Adafruit Bluefruit EZ-Link](https://www.adafruit.com/product/1588). This allows wireless flashing of the firmware on the TCB. 

**Note 1:** If you are having problems flashing new firmware to your board, make sure you have Dipswitch #5 set in the correct position! 

**Note 2:** If you have the Adafruit bluetooth device, or some other FTDI device plugged into the Serial 1 connector, and you try to re-flash the board over USB, you may still find it doesn't work even if you have Dipswitch #5 in the correct position (On for USB). This is because these other devices can prevent the board from responding to the reset command sent over the USB port. If you manually hold the RESET button on the TCB, start the firmware update, then release the RESET button, it should work. Alternatively, unplug the device from Serial 1, or if you don't want to do that -  just set Dipswitch #5 to the off position and flash over Serial 1!

## Re-Compiling the Bootloader

To re-compile the bootloader you will need avr-gcc. A version previously came bundled with the Arduino IDE but does no longer. If you are developing in Windows, download the latest version of [WinAVR](https://sourceforge.net/projects/winavr/) and make sure it creates the correct System Environment path variables when you install it. 

Then open a command prompt at the folder where you have saved these bootloader files. Type the following two commands: 
```
prompt> make clean
prompt> make optcb2560
```

The first command will clear the old hex, the second command will compile a new one. 


## Re-Flashing the Bootloader
To flash the bootloader to your chip you will need a special programming device. The USBasp is a good one and available for only a few bucks all over eBay, but there are others to choose from. The AVRISP mkII is another common programmer (more expensive).

The special programmer will come with a dual-row, six pin plug. The TCB has a matching six-pin header footprint that is not populated from the factory, you will have to solder headers to it or even more convenient use something like the [SparkFun ISP Pogo Adapter](https://www.sparkfun.com/products/11591). 

Plug your programmer into a USB port on your computer. Plug the ISP cable into the TCB. The programmer will not supply power to the TCB so you will also need to either connect a battery to the TCB or power it via USB. 

You can then flash the bootloader using one of two methods: 

### 1. Using the Arduino IDE
See this page for instructions on [Installing Open Panzer Board support in Arduino IDE](https://github.com/OpenPanzerProject/OpenPanzerBoards). 

When that is done, close the IDE and then re-open it for the changes to take effect. Next, go to the Tools menu, select "Open Panzer TCB (Mega 2560)" as the board (you may have to scroll down the list to find it). Also in the Tools menu select the appropriate programmer from the Programmer list (USBasp, AVRISP mkII or whatever programming device you have). 

Plug whatever programming device you are using into the computer. Apply power to the TCB either with a battery or through the USB connector. Then with your programming device firmly connected to the six-pin ISP header on the TCB, click "Burn Bootloader" in the IDE (also in the Tools menu). The correct bootloader should now be installed. To confirm, the red LED on the TCB will blink slowly. 

At this point you only have the bootloader, no running firmware. So next you will want to flash the latest firmware to the TCB (this can be done over the USB connection, it does not require the programming device). 

### 2. Using AVRDUDE from the Command Line
Avrdude is the program Arduino uses to write to ATmega chips, but you can use it directly from the command line as well. You will need three files: avrdude.exe, avrdude.conf, and optcb2560_boot.hex

Copies of all these files are included in this folder, but you can also get the most recent versions of the avrdude files from your Arduino installation directory if you have the IDE installed. They will be located here: 
`Your_Arduino_Install_Dir\hardware\tools\avr\bin\avrdude.exe`
`Your_Arduino_Install_Dir\hardware\tools\avr\etc\avrdude.conf`

It will probably be easier to move all these files into a single folder in the root of some drive, such as: 
`C:\openpanzer_boot\avrdude.exe`
`C:\openpanzer_boot\avrdude.conf`
`C:\openpanzer_boot\optcb2560_boot.hex`

Now as with the first method you still need the special programming device (USBasp, AVRISP mkII, etc). Plug this device into your computer. Apply power to the TCB either with a battery or through the USB connector. Then attach your programming device firmly to the six-pin ISP header on the TCB.

Open a Windows command prompt and browse to the folder that contains your files. Then run the following commands. This first command will 1) erase the existing program memory, 2) unlock the bootloader section so we can access it in step two, and 3) set the three fuse bits to the correct values. 

`avrdude -C avrdude.conf -p atmega2560 -c usbasp -P usb -v -e -U lock:w:0x3F:m -U efuse:w:0xFD:m -U hfuse:w:0xDA:m -U lfuse:w:0xF7:m`

Note this command references `usbasp` as the programming device. If you are using a different programmer you will need to change the `-c` flag to match. For a list of supported avrdude programmers see [this link](http://www.nongnu.org/avrdude/user-manual/avrdude_4.html) or type `avrdude -c ?` 

Now that we have set the correct fuse bits for writing the bootloader, run this second command:

`avrdude -C avrdude.conf -p atmega2560 -c usbasp -P usb -v -U flash:w:optcb2560_boot.hex:i -U lock:w:0x0F:m`

Where again you need to specify the correct programmer if you are not using the USBasp. 

The correct bootloader should now be installed. To confirm, the red LED on the TCB will blink slowly. 

If you are going to be doing a lot of flashing it can be useful to put these commands into a Windows batch file. A sample one is included in this folder (`bootloader_batch_script.bat`). You will first need to edit the bat file in a text editor such as Notepad (but we like [Programmer's Notepad](http://www.pnotepad.org/) better!). The file is well commented, all you need to do is set the paths to the three files described above, as well as the name of the programming device you will be using. Save and close the file, then all you need to do is double-click the batch file in Windows Explorer and it will execute. This saves you typing long commands at the command prompt. 

#### Bootloader Flashing Troubleshooting
Many errors such as messages that the programmer could not be found, or that it didn't responsd correctly, or the cryptic Windows error: "The application was unable to start correctly (0xc000007b)" are due to the lack of a driver or an incorrect driver for your programming device. The best way to resolve these is to download the free [Zadig program](https://zadig.akeo.ie/). It is a standalone exe. Run the program, and with your programmer plugged into the computer, go to the Options menu and select "List All Devices." Find your programmer device in the drop-down menu (USBasp or whatever), and then install the `libusb-win32` driver. If you still have problems you can try afterwards switching to the `libusbK` driver. 

#### Important Lesson Learned the Hard Way
Avrdude doesn't like spaces in file names and for sure will croak if there is a parentheses in the path, such as there will be if you install Arduino on a 64-bit Windows OS (ie, "C:\Program Files (x86)\etc..")

So save yourself some hassle and install Arduino into a clean folder like "C:\Arduino\"
