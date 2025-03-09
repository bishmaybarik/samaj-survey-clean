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
│   └── ~01_Clean.do.stswp
├── 04_Results
└── 05_Docs
```
## Step 1: Download the Dataset  

Download the **Notions of Identity 2.1** module (`samaj_survey_II.csv`) from the following [here](https://consumerpyramidsdx.cmie.com/kommon/bin/sr.php?kall=wroundet&round_id=2&tabno=3&rrurl=samajdx-consumerpyramidsdx).

Save it inside:
``01_Raw/Samaj Survey Project/samaj_survey_II.csv``
