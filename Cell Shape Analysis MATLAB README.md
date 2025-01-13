Cell Segmentation and Analysis Tool
This MATLAB tool allows users to segment cells manually from an image by drawing polygons and calculates key shape metrics such as area, perimeter, eccentricity, and length.

Dependencies
Before running the script, ensure the following prerequisites are met:

Operating System: Windows 10 (or newer), macOS, or Linux
MATLAB Version: R2020b or newer
Toolboxes Required: Image Processing Toolbox
Installing
Download the Script
Download the MATLAB script file from the provided repository or source location.

Prepare the Image File
Place your input image file in the same directory as the script, or update the file path in the script to point to the correct location.

Check for Required Toolboxes
Ensure the Image Processing Toolbox is installed. You can verify by running the following command in MATLAB:

matlab
Copy code
ver
Look for "Image Processing Toolbox" in the output.

Executing the Program
Open MATLAB
Launch MATLAB and navigate to the directory containing the script.

Run the Script
Execute the script by typing the following command in the MATLAB command window:

matlab
Copy code
run('script_name.m') % Replace 'script_name.m' with the actual filename
Follow the On-Screen Instructions

Load the image by providing the correct file path in the script.
Draw a polygon around each cell by clicking and dragging on the image.
Double-click to complete the polygon.
Repeat the process for additional cells.
When finished, confirm your selection in the dialog box.
View Results
The script will display the segmented image with annotations and metrics, along with numerical outputs for each cell.

Help
Common Issues and Fixes
Toolbox Missing:
If you encounter errors related to missing functions, ensure the Image Processing Toolbox is installed.

File Not Found:
Ensure the file path in the script points to an existing image file. Update the path if necessary.

Author
Mohammadreza Rahmani Manesh
GitHub: @MohammadrezaRM
