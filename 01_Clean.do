/*******************************************************************************
Name: 01_Clean
Purpose: Cleaning the raw file of Notions of Identity 2.1
Author: Bishmay Barik
Date: 9th March 2025
*******************************************************************************/

clear all
macro drop all
set more off

* Setting the file directory:

global dir "/Users/bishmaybarik/Dropbox/Thesis_Bishmay_New/Cultural Capital Calculation"

* Setting the root directory

global raw "$dir/01_Raw"
global clean "$dir/02_Cleaned"
global results "$dir/04_Results"

* Importing the dataset

import delimited "$raw/Samaj Survey Project/samaj_survey_II.csv", clear

* Fixing the variables (the default ones are too messy) // replace drop with order in the end

order hh_id mem_id state hr district region_type stratum psu_id month_slot r_acc_hh_wgt_w r_acc_hh_wgt_for_country_w r_acc_hh_wgt_for_state_w gender age_yrs age_mths religion caste_category caste 

* Dropping the response variables (everyone has responded!)

drop response_status nr_reason

* Cleaning the important variables now

// eaten_with_sc_or_not_sc - this is a question asked. Any answers are not expected.

replace eaten_with_sc_or_not_sc = eaten_with_sc_or_not_sc + "" + eat_with_sc_home

// Fixing the next variables 

replace eat_with_sc_home = eat_with_sc_eatery
replace eat_with_sc_eatery = eaten_with_non_relative_home
replace eaten_with_non_relative_home = eaten_with_non_relative_eatery
replace eaten_with_non_relative_eatery = freq_eaten_out_or_bought_food
replace freq_eaten_out_or_bought_food = q4_caste_prompt_shown_rspnsedt
replace q4_caste_prompt_shown_rspnsedt = religion_caste_of_cook_matter
replace religion_caste_of_cook_matter = do_you_eat_meat
replace do_you_eat_meat = married_outside_caste
replace who_cleans_washrooms_toilet_home = married_outside_caste_category
replace married_outside_caste = married_outside_religion
replace married_outside_caste_category = accept_inter_caste_mriage_child
replace married_outside_religion = accept_inter_caste_mriage_for
replace accept_inter_caste_mriage_child = accept_inter_caste_mriage_for
replace accept_inter_caste_mriage_for = q1_inter_mriage_accepatable_when

// Fixing the above variable further
replace accept_inter_caste_mriage_for = q2_inter_mriage_accepatable_when if accept_inter_caste_mriage_for == "Y"
replace accept_inter_caste_mriage_for = q2_inter_mriage_accepatable_when if accept_inter_caste_mriage_for == "N"
replace accept_inter_caste_mriage_for = q2_inter_mriage_accepatable_when if accept_inter_caste_mriage_for == "DK"

* Next fixing the questions asked

replace q1_inter_mriage_accepatable_when = q2_inter_mriage_accepatable_when
replace q2_inter_mriage_accepatable_when = q3_inter_mriage_accepatable_when
replace q3_inter_mriage_accepatable_when = mriage_diff_caste_acceptable

// Fixing q1_inter_mriage_accepatable_when since it has some random mistakes

replace q1_inter_mriage_accepatable_when = mriage_diff_religion_acceptable if q1_inter_mriage_accepatable_when == "Don't Know/No Response"
replace q1_inter_mriage_accepatable_when = mriage_diff_religion_acceptable if q1_inter_mriage_accepatable_when == "No difference between son or daughter"
replace q1_inter_mriage_accepatable_when = mriage_diff_religion_acceptable if q1_inter_mriage_accepatable_when == "Your daughter"
replace q1_inter_mriage_accepatable_when = mriage_diff_religion_acceptable if q1_inter_mriage_accepatable_when == "Your son"

* Proceeding with other variables

replace mriage_diff_caste_acceptable = mriage_diff_religion_acceptable
replace mriage_diff_religion_acceptable = "" if mriage_diff_religion_acceptable == "Y"
replace mriage_diff_religion_acceptable = "" if mriage_diff_religion_acceptable == "N"
replace mriage_diff_religion_acceptable = "" if mriage_diff_religion_acceptable == "DK"

replace mriage_diff_caste_acceptable = mriage_diff_language_acceptable if mriage_diff_caste_acceptable == "Is inter-marriage ACCEPTABLE When people are from different religions?"
replace mriage_diff_caste_acceptable = mriage_diff_language_acceptable if mriage_diff_caste_acceptable == "Is inter-marriage ACCEPTABLE When people are from different castes?"
replace mriage_diff_caste_acceptable = mriage_diff_language_acceptable if mriage_diff_caste_acceptable == "Is inter-marriage ACCEPTABLE When people speak different languages?"

// caste is fixed!

replace mriage_diff_language_acceptable = "" if mriage_diff_religion_acceptable == "Is inter-marriage ACCEPTABLE When people are from different religions?"
replace mriage_diff_language_acceptable = "" if mriage_diff_religion_acceptable == "Is inter-marriage ACCEPTABLE When people are from different castes?"
replace mriage_diff_language_acceptable = "" if mriage_diff_religion_acceptable == "Is inter-marriage ACCEPTABLE When people speak different languages?"

replace mriage_diff_religion_acceptable = mriage_diff_language_acceptable if mriage_diff_religion_acceptable == ""


replace mriage_diff_religion_acceptable = ask_help_outside_family if mriage_diff_religion_acceptable == "Is inter-marriage ACCEPTABLE When people are from different religions?"
replace mriage_diff_religion_acceptable = ask_help_outside_family if mriage_diff_religion_acceptable == "Is inter-marriage ACCEPTABLE When people are from different castes?"
replace mriage_diff_religion_acceptable = ask_help_outside_family if mriage_diff_religion_acceptable == "Is inter-marriage ACCEPTABLE When people speak different languages?"

// religion is fixed!

replace mriage_diff_language_acceptable = ask_help_outside_family if mriage_diff_language_acceptable == "Y"
replace mriage_diff_language_acceptable = ask_help_outside_family if mriage_diff_language_acceptable == "N"
replace mriage_diff_language_acceptable = ask_help_outside_family if mriage_diff_language_acceptable == "DK"

replace mriage_diff_language_acceptable = does_your_family_have_a_bpl_card if mriage_diff_language_acceptable == ""

// languages is fixed!

* Moving ahead with next variables now:

replace ask_help_outside_family = does_your_family_have_a_bpl_card

* After this point, there are a lot of issues in row alignments - things are just messed up!

* Generating a lag variable, to identify that the particular row is misligned (pushed forward by an extra bit)

gen lag = 0
replace lag = 1 if ask_help_outside_family == "Y"
replace lag = 1 if ask_help_outside_family == "N"
replace lag = 1 if ask_help_outside_family == "DK"

* Following up with the variables
replace ask_help_outside_family = does_your_family_have_a_bpl_card if lag == 0
replace ask_help_outside_family = enrolled_in_aadhaar if lag == 1

replace does_your_family_have_a_bpl_card = enrolled_in_aadhaar if lag == 0
replace does_your_family_have_a_bpl_card = member_of_political_party if lag == 1

replace enrolled_in_aadhaar = member_of_political_party if lag == 0
replace enrolled_in_aadhaar = member_of_caste_association if lag == 1

replace member_of_political_party = member_of_caste_association if lag == 0
replace member_of_political_party = member_of_religious_organization if lag == 1

replace member_of_caste_association = member_of_religious_organization if lag == 0
replace member_of_caste_association = member_of_labor_trade_union if lag == 1

replace member_of_religious_organization = member_of_labor_trade_union if lag == 0
replace member_of_religious_organization = member_of_sport_rcrtonl_soc_club if lag == 1

replace member_of_labor_trade_union = member_of_sport_rcrtonl_soc_club if lag == 0
replace member_of_labor_trade_union = member_of_prfssinl_association if lag == 1

replace member_of_sport_rcrtonl_soc_club = member_of_prfssinl_association if lag == 0
replace member_of_sport_rcrtonl_soc_club = member_of_charity if lag == 1

replace member_of_prfssinl_association = member_of_charity if lag == 0
replace member_of_prfssinl_association = member_of_shg_mfi if lag == 1

replace member_of_charity = member_of_shg_mfi if lag == 0
replace member_of_charity = religious_prmpt_shown_rspnsedt if lag == 1

replace member_of_shg_mfi = religious_prmpt_shown_rspnsedt if lag == 0
replace member_of_shg_mfi = freq_your_religious_instttn if lag == 1

replace religious_prmpt_shown_rspnsedt = freq_your_religious_instttn if lag == 0
replace religious_prmpt_shown_rspnsedt = confidence_central_govt if lag == 1

replace freq_your_religious_instttn = confidence_central_govt if lag == 0
replace freq_your_religious_instttn = cond_in_country_rn if lag == 1

replace confidence_central_govt = cond_in_country_rn if lag == 0
replace confidence_central_govt = cond_in_hh_rn if lag == 1

replace cond_in_country_rn = cond_in_hh_rn if lag == 0
replace cond_in_country_rn = discrim_agnst_religion if lag == 1

replace cond_in_hh_rn = discrim_agnst_religion if lag == 0
replace cond_in_hh_rn = no_married_couple_hh if lag == 1

replace discrim_agnst_religion = no_married_couple_hh if lag == 0
replace discrim_agnst_religion = no_sep_hearths_kitchen_hh if lag == 1

replace no_married_couple_hh = no_sep_hearths_kitchen_hh if lag == 0
replace no_married_couple_hh = voice_heard_in_govt if lag == 1

replace no_sep_hearths_kitchen_hh = voice_heard_in_govt if lag == 0
replace no_sep_hearths_kitchen_hh = describe_self if lag == 1

replace voice_heard_in_govt = describe_self if lag == 0 
replace voice_heard_in_govt = describe_family if lag == 1

replace describe_self = describe_family if lag == 0
replace describe_self = v64 if lag == 1

replace describe_family = v64 if lag == 0
replace describe_family = v65 if lag == 1

* Drop the lag and extra variables 

drop lag v64 v65

* Saving the dataset

save "$clean/identity_2p1.dta", replace 

* Saving it in csv too

export delimited "$clean/identity_2p1.csv", replace


