# Samaj Survey Project - Data Cleaning  

The [Samaj Survey Project](https://consumerpyramidsdx.cmie.com/kommon/bin/sr.php?kall=wsamajdx&rrurl=samajdx-consumerpyramidsdx) is a dataset recently released by the [Centre for Monitoring Indian Economy (CMIE)](https://www.cmie.com/). This dataset is a sample of households from the [Consumer Pyramids Dx](https://consumerpyramidsdx.cmie.com/).  

The dataset consists of multiple modules across different waves. Recently, I worked with the [Notions of Identity 2.1](https://consumerpyramidsdx.cmie.com/kommon/bin/sr.php?kall=wroundet&round_id=2&rrurl=samajdx-consumerpyramidsdx) module and encountered significant issues with variable alignment—columns and rows were misaligned, causing observations to be misplaced.  

To resolve these issues, I have written a Stata script (`01_Clean.do`) to clean and structure the data correctly. Below are the steps to follow.  

## Directory Structure  

Please create the following directory structure:  

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
├── 04_Results
└── 05_Docs
```
## Step 1: Download the Dataset  

Download the **Notions of Identity 2.1** module (`samaj_survey_II.csv`) from [here](https://consumerpyramidsdx.cmie.com/kommon/bin/sr.php?kall=wroundet&round_id=2&tabno=3&rrurl=samajdx-consumerpyramidsdx) and then save it in the folder as shown in the above tree. 

## Step 2: Set Folder Directories in `01_Clean.do`  

Open `01_Clean.do` and update the directory paths:  

```stata
* Setting the file directory:
global dir "replace/this/with/your/folder/name"

* Setting the sub-folder root directories:
global raw "$dir/01_Raw"
global clean "$dir/02_Cleaned"
global results "$dir/04_Results"
```
## Step 3: Run the Cleaning Script

Simply execute `01_Clean.do` in Stata. Once completed, the cleaned dataset will be saved in both .dta and .csv formats inside the `02_Cleaned` folder.

---
If you have a more efficient approach to structuring or processing this data, please feel free to share! 



