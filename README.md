# samaj-survey-clean
The [Samaj Survey Project](https://consumerpyramidsdx.cmie.com/kommon/bin/sr.php?kall=wsamajdx&rrurl=samajdx-consumerpyramidsdx) is a dataset recently released by the [Centre for Monitoring indian Economy (CMIE)](https://www.cmie.com/), and this is a sample of the households present in the [Consumer Pyramids Dx](https://consumerpyramidsdx.cmie.com/). As it can be seen, it has various modeules, for different waves. I have recently used the [Notions of Identity 2.1](https://consumerpyramidsdx.cmie.com/kommon/bin/sr.php?kall=wroundet&round_id=2&rrurl=samajdx-consumerpyramidsdx) Modele, and found out that there are a lot of issues with the variable alinment, columns and rows being misaligned, and due to this, each observation has lost its position, and has been misplaced, making things complicated (I'm sure, if you must have used this dataset, you must be aware of this problem). The Stata script `01_Clean` has the codes to fix these errors in the module. I have written the steps which you can follow:

Please create a directory which looks like:
```
.
├── 01_Raw
│   └── Samaj Survey Project
│       └── samaj_survey_II.csv
├── 02_Cleaned
│   ├── identity_2p1.csv
│   └── identity_2p1.dta
├── 03_Codes
│   ├── 01_Clean.do
│   └── ~01_Clean.do.stswp
├── 04_Results
└── 05_Docs
```
For the first step, please download `samaj_survey_II.csv` module of Samaj Survey Project from [here](https://consumerpyramidsdx.cmie.com/kommon/bin/sr.php?kall=wroundet&round_id=2&tabno=3&rrurl=samajdx-consumerpyramidsdx). 

Next, set the folder directories and the sub-folder directories in `01_Clean.do`

```
* Setting the file directory:

global dir "replace/this/with/your/folder/name"

* Setting the sub-folder root directory

global raw "$dir/01_Raw"
global clean "$dir/02_Cleaned"
global results "$dir/04_Results"
```
Just run the code once and you're done!

The file will be saved in both dta and csv forms, namely - `identity_2p1.dta` and `identity_2p1.csv` in the `02_Cleaned` folder. 

--- 
In case you feel like there's a better way to do this, please feel free to reach out!


