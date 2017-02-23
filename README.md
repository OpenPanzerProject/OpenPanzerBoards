# Open Panzer Arduino Boards
This repository contains configuration and other support files to use Open Panzer Arduino-compatible boards such as the TCB Mk1 with the Arduino IDE. 

## What these Files are For
You shouldn't need anything in this repository unless you want to manually install the board package. Most people will be better served by using the built-in Boards Manager in the Arduino IDE as described below. But if for some reason you must do a manual install, scroll down to the bottom of this page for instructions. 

## Installing Open Panzer Board support in Arduino IDE
To add board support for our products, open the Arduino IDE and go to **File > Preferences** (or if using OS X, go to Arduino > Preferences). A window will appear like the one shown below: 
![Add JSON to Preferences](http://openpanzer.org/images/github/boards/Preferences_JSON.png "Add JSON to Preferences")

We will be adding the following URL to the 'Additional Boards Manager URLs' input field: 
`https://openpanzerproject.github.io/OpenPanzerBoards/package_openpanzer_index.json`

There may already be entries in this field, if so, just add the new URL separated from the others with a comma. You only have to add the URL once, new Open Panzer boards and updates to existing boards will automatically be picked up by the Board Manager each time it is opened. 

Next close the Preferences window, then go to the **Tools** menu and select **Board > Boards Manager**. Once the Board Manager opens, click on the category drop down menu on the top left hand side of the window and select **Contributed** - or, just type Open Panzer into the search bar. When you find the Open Panzer Boards option, click on the **Install** button and wait for the process to complete. 

![Boards Manager](http://openpanzer.org/images/github/boards/Preferences_JSON.png "Boards Manager")

Next, **quit and reopen the Arduino IDE** to ensure the new board packages are properly installed. You should now be able to select the new board listed in the **Tools->Board** menu.

![TCB Board shown in List](http://openpanzer.org/images/github/boards/BoardList.png "TCB Board shown in List")


## Manual Board Package Installation
Most people will want to install board support using Boards Manager in the IDE as described above. But if for some reason that is not an option for you (perhaps restrictive network settings), you can install the files manually. 

1. Click the green **Clone or Download** button at the top of this page, then select **Download Zip**. 
2. Unzip the downloaded file, then copy the **OpenPanzerBoards-master** folder to your Arduino sketch folder, in the hardware subfolder. Your sketchbook folder location can be found by looking in the Arduino IDE at File > Preferences > Sketchbook Location. If you don't see a hardware folder in there, create one. When you are done the folder should look like this: 
{Arduino_Sketchbook_Folder\hardware\OpenPanzerBoards-master\
3. Restart the Arduino IDE if it's running.
4. Now go to **Tools->Board** in the Arduino IDE and the Open Pnazer board(s) should appear in the list. 
