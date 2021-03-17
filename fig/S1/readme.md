Instruction:
1) Create a folder named “ndpi”to store ndpi image file;
2)  Rename the ndpi file as p1.ndpi,p2.ndpi…pn.ndpi as sequence.
3) Create several folder path under one project folder : 
origin: store the sliced image from ndpi;
H :for red pixel color deconvolution;
E : for blue pixel color deconvolution;
originlabel : combine the H and E image to create labeled image;
originlabelrgb: image to rgb;


This project is accomplished by matlab software;
1. imagepreprocessing.m: read ndpi format image data and color deconvolution; There are four files; ndpi file for store the registered ndpi image.Origin file storage the image read from the ndpi image. H and E file storage the image processed color deconvolution. 

2. normalizeStaining.m : is color deconvolution function.
    

3. tubevoxel.m: calculate the discrete point 3d space coordinate position.

4. tissuemodel.m: 1) build the tissue by using the tissue image slides from origin file;
                  2) calculate the blue voxels ratio which represent the cancer area percentage;
                  3) the tube cross-section image visualization;

5. modeltest.m: The testing model is constructed by pure color blocks for tesing tube tubevoxel.m

6. labelpicture.m : is function combine the H and E into labeled picture;

