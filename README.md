# Cell-Invasiv-o-Meter
This function measures the invasivity of an *in-vitro* eukaryotic cellular culture through a scratch wound healing assay (http://www.nature.com/nprot/journal/v2/n2/full/nprot.2007.30.html).

This Matlab software analyzes the images obtained at different time points during the experiment, segments the wound and quantifies the area. The parameter that leads to the wound recognition is the **local entropy** of the image. The empty region will have a significantly lower local entropy, compared to the rest of the image (that contains the cells) and thus thresholding this image with the Otsu method allows to identify the empty areas.
Cell-Invasiv-o-Meter allows for technical replicates that can be analyzed simultaneously and averaged authomatically (just place the corresponding images in the same folder).

## Requirements:
- MATLAB and Image Processing Toolbox, The MathWorks, Inc., Natick, Massachusetts, United States.
- imoverlay (http://www.mathworks.com/matlabcentral/fileexchange/42904-imoverlay)

## Syntax:
- [file, path]= CellInvasivOMeter(folderImages)
- [file, path]= CellInvasivOMeter(folderImages, kernelDim)
- [file, path]= CellInvasivOMeter(folderImages, woundPrevalence)
- [file, path]= CellInvasivOMeter(folderImages,kernelDim, woundPrevalence)

Where *folderImages* is a string representing the path of the folder in which the images are stored (Cell-Invasiv-o-Meter hyposizes a different folder for every time point and experimental condition). *kernelDim* is the dimension of the kernel used during the computation of the local entropy (size of neighbourhood); the default value is 45 and it needs to be an odd number. *woundPrevalence* is the percentage of the empty area attributed to the wound and is necessary to exclude small holes outside the wound (it is a number between 0 and 1 and the default value is 0.7). 
The workspace containing the results of the elaboration is automatically saved as a *.mat* file, a dialog window will automatically appear allowing the user to set the file's name and its destination.


# compare-Cell-Invasive-o-Measures
This function analyzes and compares the results obtained with Cell-Invasiv-o-Meter.
## Requirements:
- MATLAB,The MathWorks, Inc., Natick, Massachusetts, United States.

## Syntax:
- [areaDecrease,invasivity]= compareCellInvasivOMeasures(folderMAT,control,conditions,timepoints)

Where *folderMAT* is the path of the folder containing the *.mat* files created by Cell-Invasiv-o-Meter. *control* is a string identifying the control condition, this function hypothesizes the *.mat* files to follow this name scheme (**id_timepoint.mat**).
*conditions* and *timepoints* are column vectors containing, respectively, the ids of the tested conditions, and the measured temporal points.

The outputs of this function are the percentual area change (normalized to the control at the first time point) and the invasivity of the population, computed as the average area decrease between two consecutive time points of each tested condition divided by the same quantity computed for the control.  
**See the wiki for more information**


