# JPG-Files-List-Generator
This PowerShell script generates a list of all JPG files on a specified drive and its subdirectories, and saves this information to an HTML file

Description:
This PowerShell script generates a list of all JPG files on a specified drive and its subdirectories, and saves this information to an HTML file. Additionally, it creates a dropdown menu grouped by years, allowing easy navigation between years and selection of files for each year.

Features:
List JPG files: The script lists all JPG files on a specified drive and its subdirectories.
Save to HTML: It saves the file names and modification dates of the JPG files to an HTML table at the specified location.
Yearly dropdown: It creates a dropdown menu grouped by years, enabling users to quickly navigate between years and select files for each year.

Usage:
Specify the drive letter in the $driveLetter variable.
Determine the HTML file path in the $htmlFilePath variable.
Run the script to generate the HTML file with the list of JPG files and the yearly dropdown menu.

Environment:
The script runs in a PowerShell environment and utilizes built-in cmdlets such as Get-ChildItem and Out-File for file listing and HTML file creation.
