# PowerShell-Copy-Paste
A code in PowerShell to help office workers automatize the storage of locally saved files to the cloud. 

To use the code, user must insert the paths to their source and destination folders and execute using Windows PowerShell. The file can be used by Task Scheduler to automatically execute on a regular basis.


The code will Copy all the files in the source folder plus the files in subfolders recursively. 
The code will exclude copying files beginning with__MACOSX.
Then the code will Paste the files into the destination folder, skipping files that exist and are unmodified. 
Lastly, the code will present a pop-up dialogue box stating the number of copies made.
