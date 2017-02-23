# Open Panzer Boards
Board definitions for all Open Panzer-designed AVR and ARM-based Arduino boards.

## Installation Instructions

To add board support for our products, open the Arduino IDE and go to **File > Preferences** (or if using OS X, go to Arduino > Preferences). A window will appear like the one shown below: 
![Add JSON to Preferences](http://openpanzer.org/images/github/boards/Preferences_JSON.png "Add JSON to Preferences")

We will be adding the following URL to the 'Additional Boards Manager URLs' input field: 
`https://openpanzerproject.github.io/OpenPanzerBoards/package_openpanzer_index.json`

There may already be entries in this field, if so, just add the new URL separated from the others with a comma. You only have to add the URL once, new Open Panzer boards and updates to existing boards will automatically be picked up by the Board Manager each time it is opened. The URLs point to index files that the Board Manager uses to build the list of available & installed boards.

Close the Preferences window, then go to the **Tools** menu and select **Board > Boards Manager**. Once the Board Manager opens, click on the category drop down menu on the top left hand side of the window and select **Contributed** - or, just type Open Panzer into the search bar. When you find the Open Panzer Boards option, click on the **Install** button and wait for the process to complete. 

![Boards Manager](http://openpanzer.org/images/github/boards/Preferences_JSON.png "Boards Manager")


Next, **quit and reopen the Arduino IDE** to ensure the new board packages are properly installed. You should now be able to select the new board listed in the **Tools->Board** menu.

![TCB Board shown in List](http://openpanzer.org/images/github/boards/BoardList.png "TCB Board shown in List")
