# Quantification of Liver Needle Biopsy Sampling Error with Serial Histopathology Whole Slide Images

MATLAB Code for needle biopsy image sampling and liver fibrosis quantification.

Version 1.0, 1-DEC-2019
    
Email: qli23@gsu.edu

-------------------------------------------------------------------



## Main features
* The code in code_hpc can be used in the HPC cluster to process gigabytes WSI images.
* The code in code_local is a example, which can be used in the local computer to test small image dataset.


## Matlab Code

1. imagepreprocessing.m: read image data and color deconvolution; 
   3) Create several folder path under one project folder : 
   origin: store the sliced image from ndpi;
   H :for red pixel color deconvolution;
   E : for blue pixel color deconvolution;
   Imgsrc1 : combine the H and E image to create labeled image;
   Imgsrc2: image to rgb;
2. test.m: input the tube and tissue size parameters, point coordinate position. 

3. normalizeStaining.m : color deconvolution function.

4. tubevoxel.m: calculate the discrete point 3d space coordinate position.

5. tissuemodel.m: 1) build the tissue by using the tissue image slides from origin file;
       2) calculate the blue voxels ratio which represent the cancer area percentage;
       3) the tube cross-section image visualization;
6. modeltest.m: The testing model is constructed by pure color blocks for tesing tube tubevoxel.m

7. labelimg.m : is function combine the H and E into labeled image;

 



## References

[1] Macenko, Marc, Marc Niethammer, James S. Marron, David Borland, John T. Woosley, Xiaojun Guan, Charles Schmitt, and Nancy E. Thomas. "A method for normalizing histology slides for quantitative analysis." In 2009 IEEE International Symposium on Biomedical Imaging: From Nano to Macro, pp. 1107-1110. IEEE, 2009.

[2] Ruifrok, Arnout C., and Dennis A. Johnston. "Quantification of histochemical staining by color deconvolution." Analytical and quantitative cytology and histology 23, no. 4 (2001): 291-299.

[3] Vahadane, Abhishek, Tingying Peng, Amit Sethi, Shadi Albarqouni, Lichao Wang, Maximilian Baust, Katja Steiger, Anna Melissa Schlitter, Irene Esposito, and Nassir Navab. "Structure-preserving color normalization and sparse stain separation for histological images." IEEE transactions on medical imaging 35, no. 8 (2016): 1962-1971.

https://github.com/jnkather/ColorDeconvolutionMatlab is based on [2]

https://github.com/mitkovetta/staining-normalization is based on [1]
