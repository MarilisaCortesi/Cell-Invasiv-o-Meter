# Cell-Invasiv-o-Meter
This function measures the invasivity of an *in-vitro* eukaryotic cellular culture through a scratch wound healing assay (http://www.nature.com/nprot/journal/v2/n2/full/nprot.2007.30.html).

This Matlab software analyses the images obtained at different time points during the experiment, segments the wound and quantifies the area. The parameter that leads to the wound recognition is the **local entropy** of the image. The empty region will have a significantly lower local entropy, compared to the rest of the image (that contains the cells) and thus thresholding this image with the Otsu method allows to identify the areas in which there aren't cells.
