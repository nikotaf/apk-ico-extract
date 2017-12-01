# Apk icon extract

Extract the install icon-image from android aplications **```.apk```**.

# Requirements
You will need some additional files to make the script functional.<br/>
  * **[Autohotkey](https://autohotkey.com/)** installed
  * **```aapt.exe```** (from the **[Android SDK tool](https://developer.android.com/studio/index.html)**). A simple Google search will yield lots of results. Mine file size is **824,320** bytes.
  * An extracting application. Supported applications are **[7zip](http://www.7-zip.org/)**, **[PKzip](https://www.google.gr/search?q=PKzip+2.5)**, **[WinRAR](https://www.rarlab.com/)**. You will need the path of the command line executables. Respectively, those are, **7z.exe**, **PKZIP25.EXE**, **WinRAR.exe**. **WinRAR** allows decompressing files in the free version.
  * **[IrfanView](http://www.irfanview.com/)** for creating the final **.ico** format.<br/>

If you like you can replace applications of your liking, but it's up to you to provide the script the correct command line.

# Pre-Run
You will have to edit the script from line **11** to line **15**. It's necessary to insert full path to **```aapt.exe```** and **one** of the supported extracting applications. **```IrfanView```** can be omittted, if you only need the original file contained in **```.apk```**, usualy a **```.png```**.

# Run
At first run of the script, without parameters, if you have **[Autohotkey](https://autohotkey.com/)** installed, it will ask if you want system integration with **```.apk```**'s, that is right clicking an **```.apk```** and have the option **```Extract icon here```** in menu. By selecting **```Yes```** it will install itself in right click menu on **```.apk```**'s. Selecting **```No```**, will remove itself from the menu.<br/>

After that it will extract **```.apk```**'s install icon in the same place and the same name with **```.ico```** extension, if you have given **```IrfanView```** executable path, or just **```.png```** extension, by simply selecting **```Extract icon here```** by right clicking an **```.apk```**.<br/>

Alternatively, you can drag and drop **```.apk```** files to the script itself or its shortcut.

# Disclaimer
This script has been tested and is being used in regular basis. It will not harm any computer and has not been coded for that. If by any chance, strange things happen to your machine, it's not this code. In case you are in doubt, examine the code, it's before your eyes.
