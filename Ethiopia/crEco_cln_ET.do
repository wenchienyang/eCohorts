* Ethiopia ECohort Data Cleaning File 
* Created by K. Wright, S. Sabwa, C. Arsenault 
* Updated: July 24 2023 

*------------------------------------------------------------------------------*

* Import Data 
clear all 

*--------------------DATA FILE:
import delimited using "$et_data/8Dec2023.csv", clear

*---------------------

drop if record_id == "1" | record_id == "2" | record_id == "3" | ///
		record_id == "4" | record_id == "5" | record_id == "6" | ///
		record_id == "7" | record_id == "8" | record_id == "9" | ///
		record_id == "10" | record_id == "11" | record_id == "12" | ///
		record_id == "13" | record_id == "14" | record_id == "15" | ///
		record_id == "16" | record_id == "17" | record_id == "18" | ///
		record_id == "19" | record_id == "20" | record_id == "21" | ///
		record_id == "22" | record_id == "23" | record_id == "24" | ///
		record_id == "25" | record_id == "26" | record_id == "27" | ///
		record_id == "28"


** FOR STATISTICS OF COMPLETED SURVEYS:
tab redcap_event_name
tab redcap_repeat_instance

keep if redcap_event_name == "module_1_arm_1" | redcap_event_name == "module_2_arm_1" | redcap_event_name == "module_3_arm_1" 
		
* filter for eligible participants only:
recode is_the_respondent_eligible (. = .a) if redcap_event_name != "module_1_arm_1" // N =17 missing answer to eligiblity

keep if is_the_respondent_eligible == 1 | is_the_respondent_eligible == .a | is_the_respondent_eligible == .

gen country = "Ethiopia"

*** Dropping M4 & M5 for cleaning purposes:
*drop m4_attempt_date-maternal_integrated_cards_comple

*------------------------------------------------------------------------------*
	* STEPS: 
		* STEP ONE: RENAME VARIABLES (starts at: line 29)
		* STEP TW0: ADD VALUE LABELS (starts at: line 214)
		* STEP THREE: RECODING MISSING VALUES (starts at: line 903)
		* STEP FOUR: LABELING VARIABLES (starts at: line 1688)
		* STEP FIVE: ORDER VARIABLES (starts at: line 2379)
		* STEP SIX: SAVE DATA

*------------------------------------------------------------------------------*

	* STEP ONE: RENAME VARAIBLES
    
	* MODULE 1:
	
	rename record_id redcap_record_id
	rename (study_id interviewer_id date_of_interview_m1 time_of_interview_m1) ///
	       (study_id interviewer_id date_m1 m1_start_time)
	rename study_site_a4 study_site
	rename other_study_site_a4 study_site_sd
	rename facility_name_a5 facility
	rename other_facility_name facility_other
	rename facility_type_a6 facility_type
	rename b1_may_we_have_your_permis permission
	rename b2_are_you_here_today_to_r care_self
	rename b3_how_old_are_you enrollage
	rename b4_which_zone_district zone_live
	rename b5_are_you_here_to_receive b5anc
	rename b6_is_this_the_first_time_you b6anc_first
    rename data_collector_confirms_01 b6anc_first_conf
	rename eth_1_b_do_you_plan_to_con continuecare
	rename is_the_respondent_eligible b7eligible
	rename what_is_your_first_name_101 first_name
	rename what_is_your_family_name_102 family_name
	rename assign_respondent_id_103 respondentid
	rename do_you_have_a_mobile_phone mobile_phone
	rename what_is_your_phone_number phone_number
	rename can_i_flash_this_mobile_num flash
	rename is_the_place_kebele_you_eth_1_1 kebele_malaria
	rename eth_2_1_is_the_place_or_ke kebele_intworm
	
	rename in_general_how_would_201m1 m1_201
	rename did_you_have_diabetes_202a m1_202a
	rename (did_yo_have_hbp_202b did_you_had_cardiac_disease did_you_had_mental_disorder ///
	        did_you_had_hiv before_you_got_pregnant_202f before_you_got_pregnant_202g) ///
			(m1_202b m1_202c m1_202d m1_202e m1_202f_et m1_202g_et)
	rename (before_pregnant_diagn_203 specify_the_diagnosed_203 currently_taking_medication ///
	        which_best_describe_your_205a which_describes_your_205b which_describe_your_205c ///
			which_describe_your_205d which_describe_your_205e) ///
		   (m1_203_et m1_203_other m1_204 m1_205a m1_205b m1_205c m1_205d m1_205e)	
	rename m1_206a phq9a
	rename m1_206b phq9b
	rename m1_206c phq9c
	rename m1_206d phq9d
	rename m1_206e phq9e
	rename m1_206f phq9f
	rename m1_206g phq9g
	rename m1_206h phq9h
	rename m1_206i phq9i
	rename health_problems_affecting_207 m1_207
	
	rename (rate_health_quality_301	overall_view_of_health_302 how_confident_are_you_303 ///
	how_confident_are_you_304 how_confident_are_you_305_a how_confident_are_you_305_b) ///
	(m1_301 m1_302 m1_303 m1_304 m1_305a m1_305b)
	
	rename (how_did_you_travel_401 specify_other_transport_401 how_long_in_hours_or_minut_402 ///
	        do_you_know_the_distance_403a how_far_403b is_this_the_nearest_health_404 ///
			what_is_the_most_important_405 specify_other_reason_405) ///
		   (m1_401 m1_401_other m1_402 m1_403a m1_403b m1_404 m1_405 m1_405_other)
		   
	rename (what_is_your_first_languag_501 specify_other_language_501 have_you_ever_attend_502 ///
	        what_is_the_highest_level_503 can_you_read_any_part_504 what_is_your_current_marit_505 ///
			what_is_your_occupation_506 specify_other_occupation_506 what_is_your_religion_507 ///
			specify_other_religion_507 how_many_people_508) ///
			(m1_501 m1_501_other m1_502 m1_503 m1_504 m1_505 m1_506 ///
			m1_506_other m1_507 m1_507_other m1_508)
	
	rename (have_you_ever_heard_509a do_you_think_that_people_509b a_have_you_ever_heard_510a ///
	        do_you_think_that_tb_can_510b when_children_have_diarrhe_511 is_smoke_from_a_wood_burni_512) ///
	       (m1_509a m1_509b m1_510a m1_510b m1_511 m1_512)
		   
	rename (what_phone_numbers_513a___1 what_phone_numbers_513a___2 what_phone_numbers_513a___3  ///
		   what_phone_numbers_513a___4 what_phone_numbers_513a___5 what_phone_numbers_513a___6 ///
		   what_phone_numbers_513a___7 what_phone_numbers_513a___8) (m1_513a_1 m1_513a_2 m1_513a_3 ///
		   m1_513a_4 m1_513a_5 m1_513a_6 m1_513a_7 m1_513a_8)
		   
    rename (what_phone_numbers_513a___998 what_phone_numbers_513a___999 what_phone_numbers_513a___888) ///
		   (m1_513a_998 m1_513a_999 m1_513a_888)
	
	rename (primary_phone_number_513b can_i_flash_this_number_513c secondary_personal_phone_513d ///
		   spouse_or_partner_513e community_health_worker_513f close_friend_or_family_513g ///
		   close_friend_or_family_513h other_phone_number_513i) ///
		   (m1_513b m1_513c m1_513d m1_513e m1_513f m1_513g m1_513h m1_513i)
	
	rename (mobile_phone_number_514b where_is_your_town_515a where_is_your_zone_515b where_is_your_kebele_515c  ///
		    what_is_your_house_num_515d could_you_please_describe_516 is_this_a_temporary_reside_517 ///
			until_when_will_you_be_at_518  ///
			where_will_your_district_519a where_will_your_kebele_519b where_will_your_village_519c) ///
			(m1_514b m1_515a_town m1_515b_zone m1_515c_ward ///
			m1_515d_house m1_516 m1_517 m1_518 m1_519_district m1_519_ward m1_519_village)
	
	rename (i_would_like_to_know_how_601 how_likely_are_you_to_reco_602	how_long_in_minutes_did_603 ///
	        how_long_in_hours_or_minut_604 eth_1_6_1_do_you_know_how_lo eth_1_6_2_how_long_is_your) ///
			(m1_601 m1_602 m1_603 m1_604 m1_604b_et m1_604c_et) 
			
	rename (thinking_about_the_visit_605 thinking_about_the_visit_605b thinking_about_the_visit_605c ///
	        thinking_about_the_visit_605d thinking_about_the_visit_605e thinking_about_the_visit_605f ///
			thinking_about_the_visit_605g thinking_about_the_visit_605h thinking_about_the_visit_605i ///
			thinking_about_the_visit_605j thinking_about_the_visit_605k) ///
	        (m1_605a m1_605b m1_605c m1_605d m1_605e m1_605f m1_605g m1_605h ///
			m1_605i_et m1_605j_et m1_605k_et)
			
	rename (measure_your_blood_pressure_700	measure_your_weight_701 measure_your_height_702 ///
	        measure_your_upper_arm_703 measure_heart_rate_704 take_urine_sample_705 take_blood_drop_706 ///
			take_blood_draw_707) ///
		   (m1_700 m1_701 m1_702 m1_703 m1_704 m1_705 m1_706 m1_707)
		   
	rename (do_hiv_test_708a share_hiv_test_result_708b medicine_for_hiv_708c explain_medicine_usage_708d do_hiv_viral_load_test_708e do_cd4_test_708f do_hiv_viral_load_test_709a do_cd4_test_709b result_of_blood_sugar_test_711b) (m1_708a m1_708b m1_708c m1_708d m1_708e m1_708f m1_709a m1_709b m1_711b)
		
	rename (how_subscription_for_713a_1 how_do_they_provide_713b_1 how_do_they_provide_713c_1 how_do_they_provide_713d_1 how_do_they_provide_713e_1 how_do_they_provide_713f_1 how_do_they_provide_713g_1 how_do_they_provide_713h_1 how_do_they_provide_713i_1 whare_you_given_injection_714a receive_tetanus_injection_714b nuber_of_tetanus_injection_714c how_many_years_ago_714d  how_many_years_ago_last_714e) (m1_713a m1_713b m1_713c m1_713d m1_713e m1_713f m1_713g m1_713h m1_713i m1_714a m1_714b m1_714c m1_714d m1_714e)
	
	rename (provided_with_an_insecticide_715 discuss_about_diabetes_718 discuss_about_bp_719 discuss_about_cardiac_720 discuss_about_mental_health_721 discuss_about_hiv_722 discus_about_medication_723) (m1_715 m1_718 m1_719 m1_720 m1_721 m1_722 m1_723)
	
	rename (should_come_back_724a when_did_he_tell_you_724b to_see_gynecologist_724c  to_go_to_hospital_724e to_go_for_urine_test_724f go_to_blood_test_724g go_to_do_hiv_test_724h go_to_do_ultrasound_test_724i) (m1_724a m1_724b m1_724c m1_724e m1_724f m1_724g m1_724h m1_724i)
	
	rename (estimated_date_for_delivery_801 how_many_months_weeks_803 calculate_gestational_age_804 how_many_babies_you_preg_805 ask_your_last_period_806 when_you_got_pregnant_807) (m1_801 m1_803 m1_804 m1_805 m1_806 m1_807)
	
	rename (m1_802b m1_802c m1_802d) (m1_802b_et m1_802c_et m1_802d_et)
	
	rename (m1_808___0 m1_808___1 m1_808___2 m1_808___3 m1_808___4 m1_808___5 ///
			m1_808___6 m1_808___7 m1_808___8 m1_808___9 m1_808___10 m1_808___11 ///
			m1_808___12 m1_808___96 m1_808___99 m1_808___998 m1_808___999 m1_808___888) ///
		   (m1_808_0_et m1_808_1_et m1_808_2_et m1_808_3_et m1_808_4_et m1_808_5_et ///
		   m1_808_6_et m1_808_7_et m1_808_8_et m1_808_9_et m1_808_10_et m1_808_11_et ///
		   m1_808_12_et m1_808_96_et m1_808_99_et m1_808_998_et m1_808_999_et m1_808_888_et)
	
	rename (specify_other_reason_808) (m1_808_other)
	
	rename (discuss_your_birth_plan_809 other_than_the_list_above m1_811 you_might_need_c_section_812a) ///
		   (m1_809 m1_810_other m1_811 m1_812a) 
	
	rename (m1_812b_0 m1_812b___1 m1_812b___2 m1_812b___3 m1_812b___4 m1_812b___5 ///
			m1_812b___96 m1_812b___98 m1_812b___99 m1_812b___998 m1_812b___999 ///
			m1_812b___888 other_reason_for_c_section_812) ///
		   (m1_812b_0_et m1_812b_1 m1_812b_2 m1_812b_3 m1_812b_4 m1_812b_5 ///
		   m1_812b_96 m1_812b_98 m1_812b_99 m1_812b_998_et m1_812b_999_et ///
		   m1_812b_888_et m1_812b_other) 
	
	rename (common_health_problems_813a advice_for_treatment_813b some_women_experience_813c some_women_experience_813d  during_the_visit_today_813e some_women_experience_eth_1_8a eth_1_8b_hyperemesis_gravi eth_1_8c_did_you_experienc eth_1_8d_did_you_experienc eth_1_8e_did_you_experienc eth_1_8f_did_you_experienc eth_1_8g_any_other_pregnan specify_the_feeling_eth_1_8_h eth_2_8_did_the_provider) (m1_813a m1_813b m1_813c m1_813d m1_813e m1_8a_et m1_8b_et m1_8c_et m1_8d_et m1_8e_et m1_8f_et m1_8g_et m1_8gother_et m1_2_8_et)
	
	rename (experience_headaches_814a experience_a_fever_814c experience_abdominal_pain_814d  experience_convulsions_814f experience_repeated_faint_814g exprience_biby_stop_moving_814h could_you_please_tell_814i) (m1_814a m1_814c m1_814d m1_814f m1_814g m1_814h m1_814i)
	
	rename (m1_815___0 m1_815___1 m1_815___2 m1_815___3 m1_815___4 m1_815___5 m1_815___6 ///
			m1_815___7 m1_815___96 m1_815___98 m1_815___99) (m1_815_0 m1_815_1 m1_815_2 ///
			m1_815_3 m1_815_4 m1_815_5 m1_815_6 m1_815_7 m1_815_96 m1_815_98 m1_815_99)
	
	rename (m1_815___998 m1_815___999 m1_815___888) (m1_815_998_et m1_815_999_et m1_815_888_et)
	
	rename (other_specify_kan_biroo_ib) (m1_815_other)
	
	rename (smoke_cigarettes_901 advised_to_stop_smoking_902 frequency_of_chew_khat_903 advice_to_stop_khat_904 drink_alcohol_within_30_days_905 when_you_do_drink_alcohol_906 advised_to_stop_alcohol_907) (m1_901 m1_902 m1_903 m1_904 m1_905 m1_906 m1_907)
	
	rename (no_of_pregnancies_you_had_1001 no_of_births_you_had_1002 baby_came_too_early_1005 ///
			blood_need_during_pregnancy_1006 m1_eth_1_10 had_cesarean_section_1007) ///
			(m1_1001 m1_1002 m1_1005 m1_1006 m1_1_10_et m1_1007)
			
	rename (m1_1102___1 m1_1102___2 m1_1102___3 m1_1102___4 m1_1102___5 m1_1102___6 ///
			m1_1102___7 m1_1102___8 m1_1102___9 m1_1102___10 m1_1102___96 m1_1102___98 ///
			m1_1102___99) (m1_1102_1 m1_1102_2 m1_1102_3 m1_1102_4 m1_1102_5 m1_1102_6 ///
			m1_1102_7 m1_1102_8 m1_1102_9 m1_1102_10 m1_1102_96 m1_1102_98 m1_1102_99)
	
	rename (m1_1102___998 m1_1102___999 m1_1102___888) ///
		   (m1_1102_998_et m1_1102_999_et m1_1102_888_et)
		   
	rename (specify_who_else_hit_1102) (m1_1102_other)
	
	rename (delivery_lasted_12_hours_1008 no_children_still_alive_1009 discuss_about_prev_pregn_1011a discuss_lost_baby_after_5m_1011b discuss_baby_born_dead_1011c discuss_baby_born_early_1011d discuss_you_had_c_section_1011e discuss_baby_die_within_1m_1011f anyone_ever_hit_kicked_1101 anyone_humiliate_you_1103) (m1_1008 m1_1009 m1_1011a m1_1011b m1_1011c m1_1011d m1_1011e m1_1011f m1_1101 m1_1103)
	
	rename (m1_1104___1 m1_1104___2 m1_1104___3 m1_1104___4 m1_1104___5 m1_1104___6 ///
			m1_1104___7 m1_1104___8 m1_1104___9 m1_1104___10 m1_1104___96 m1_1104___98 ///
			m1_1104___99) (m1_1104_1 m1_1104_2 m1_1104_3 m1_1104_4 m1_1104_5 ///
			m1_1104_6 m1_1104_7 m1_1104_8 m1_1104_9 m1_1104_10 m1_1104_96 ///
			m1_1104_98 m1_1104_99)
	
	rename (m1_1104___998 m1_1104___999 m1_1104___888) (m1_1104_998_et m1_1104_999_et m1_1104_888_et)
	
	rename specify_who_humuliates_you m1_1104_other
	
	rename discuss_on_seek_support_1105	m1_1105
	
	rename (main_source_of_drink_water_1201 other_source_of_drink_1201 kind_of_toilet_facilities_1202 specify_other_toilet_1202 household_have_electricity_1203 household_have_radio_1204 household_have_tv_1205 household_have_telephone_1206 household_have_frige_1207 type_of_fuel_for_cook_1208 other_fuel_type_for_cook_1208) (m1_1201 m1_1201_other m1_1202 m1_1202_other m1_1203 m1_1204 m1_1205 m1_1206 m1_1207 m1_1208 m1_1208_other)
	
	rename (material_type_for_floor_1209 other_material_for_floor_1209 material_for_walls_1210 other_material_for_wall_1210 material_for_roof_1211 other_material_for_roof_1211 anyone_own_bicycle_1212 anyone_own_motor_cycle_1213 anyone_own_car_or_truck_1214 anyone_have_bank_account_1215 no_of_meals_per_day_1216 how_many_meals_per_1216_1) (m1_1209 m1_1209_other m1_1210 m1_1210_other m1_1211 m1_1211_other m1_1212 m1_1213 m1_1214 m1_1215 m1_1216 m1_1216_1)
	
	rename money_from_pocket_for_trans_1217 m1_1217

	rename (m1_1220___1 m1_1220___2 m1_1220___3 m1_1220___4 m1_1220___5 m1_1220___6 m1_1220___96) ///
		   (m1_1220_1 m1_1220_2 m1_1220_3 m1_1220_4 m1_1220_5 m1_1220_6 m1_1220_96)
	
	rename (m1_1220___998 m1_1220___999 m1_1220___888) ///
	       (m1_1220_998_et m1_1220_999_et m1_1220_888_et)
	
	rename other_financial_source_1220 m1_1220_other
	
	rename other_health_insurance_type m1_1222_other
	
	rename (eth_1_13_muac_safartuu_naa hemoglobin_level_from_test) (muac m1_1309)
	
	rename (m1_1402___1 m1_1402___2 m1_1402___3 m1_1402___4 m1_1402___5 m1_1402___6 m1_1402___7 ///
			m1_1402___8 m1_1402___9) (m1_1402_1_et m1_1402_2_et m1_1402_3_et m1_1402_4_et m1_1402_5_et ///
			m1_1402_6_et m1_1402_7_et m1_1402_8_et m1_1402_9_et)
			
	rename (m1_1402___888 m1_1402___998 m1_1402___999) (m1_1402_888_et m1_1402_998_et m1_1402_999_et)
	
	rename (interview_end_time total_duration_of_intervie module_1_baseline_face_to_face_e) (m1_end_time interview_length m1_complete)
	
	
* MODULE 2:
	
	rename (time_of_rescheduled_m2 date_of_rescheduled_m2) (m2_time_of_rescheduled m2_date_of_rescheduled)
	
	rename maternal_death_reported m2_maternal_death_reported
	
	rename (m2_iic m2_cr1 m2_102 m2_103a m2_107 m2_107b_ga hiv_status_109_m2 date_of_maternal_death ///
			how_did_you_learn_maternal_death)(m2_start m2_permission m2_date m2_time_start ///
			m2_ga m2_ga_estimate m2_hiv_status m2_date_of_maternal_death m2_maternal_death_learn)
			
	rename maternal_death_learn_other m2_maternal_death_learn_other
	
	rename date_of_maternal_death_2 m2_date_of_maternal_death_2

	rename (are_you_still_pregnant_or sever_headaches_since_last_visit viginal_bleed_since_last_visit a_fever_since_last_visit abdominal_pain_since_last_visit convulsions_since_last_visit)(m2_202 m2_203a m2_203b m2_203c m2_203d m2_203f)
	
	rename m2_death_info m2_111_other // order this ater 210

	rename (since_you_last_spoke_203i preeclapsia_eclampsia_204a bleeding_during_pregnancy_204b hyperemesis_gravidarum_204c anemia_204d cardiac_problem_204e amniotic_fluid_204f asthma_204g rh_isoimmunization_204h  specify_any_other_feeling) (m2_203i m2_204a m2_204b m2_204c m2_204d m2_204e m2_204f m2_204g m2_204h m2_204i_other)

	rename (over_the_past_2_weeks_on_205a over_the_past_2_weeks_205b)(m2_205a m2_205b)
	
	rename (how_often_do_you_currently_206 how_often_do_you_currently_207 how_often_do_you_currently_208   health_consultation_1st health_consultation_2nd health_consultation_3rd health_consultation_4th health_consultation_5th) (m2_206 m2_207 m2_208 m2_303a m2_303b m2_303c m2_303d m2_303e)
	
	rename (other_facility_for_1st_consult other_facility_for_2nd_consult other_facility_for_3rd_consult  other_facility_for_4th_consult other_facility_for_5th_consult) (m2_304a_other m2_304b_other m2_304c_other m2_304d_other m2_304e_other)
	
	rename (m2_306_reason___1 m2_306_reason___2 m2_306_reason___3 m2_306_reason___4 ///
			m2_306_reason___5 m2_306_reason___96 m2_306_reason___998 m2_306_reason___999 ///
			m2_306_reason___888) (m2_306_1 m2_306_2 m2_306_3 m2_306_4 m2_306_5 m2_306_96 ///
			m2_306_998_et  m2_306_999_et m2_306_888_et)
	
	rename (specify_other_reason_307 other_reason_for_2nd_consult other_reason_for_3rd_consult other_reason_for_4th_consult other_reason_for_5th_consult) (m2_307_other m2_310_other m2_313_other m2_316_other m2_319_other)
		
	rename (m2_308_reason___1 m2_308_reason___2 m2_308_reason___3 m2_308_reason___4 ///
	m2_308_reason___5 m2_308_reason___96 m2_308_reason___998 m2_308_reason___999 ///
	m2_308_reason___888) (m2_308_1 m2_308_2 m2_308_3 m2_308_4 m2_308_5 m2_308_96 ///
	m2_308_998_et  m2_308_999_et m2_308_888_et)
			
	rename (m2_311_reason___1 m2_311_reason___2 m2_311_reason___3 m2_311_reason___4 ///
	m2_311_reason___5 m2_311_reason___96 m2_311_reason___998 m2_311_reason___999 ///
	m2_311_reason___888) (m2_311_1 m2_311_2 m2_311_3 m2_311_4 m2_311_5 m2_311_96 ///
	m2_311_998_et  m2_311_999_et m2_311_888_et)

	rename (m2_314_reason___1 m2_314_reason___2 m2_314_reason___3 m2_314_reason___4 ///
	m2_314_reason___5 m2_314_reason___96 m2_314_reason___998 m2_314_reason___999 ///
	m2_314_reason___888) (m2_314_1 m2_314_2 m2_314_3 m2_314_4 m2_314_5 m2_314_96 ///
	m2_314_998_et  m2_314_999_et m2_314_888_et)
	
		rename (m2_317_reason___1 m2_317_reason___2 m2_317_reason___3 m2_317_reason___4 ///
	m2_317_reason___5 m2_317_reason___96 m2_317_reason___998 m2_317_reason___999 ///
	m2_317_reason___888) (m2_317_1 m2_317_2 m2_317_3 m2_317_4 m2_317_5 m2_317_96 ///
	m2_317_998_et  m2_317_999_et m2_317_888_et)
	
	rename (m2_320___0 m2_320___1 m2_320___2 m2_320___3 m2_320___4 m2_320___5 m2_320___6 m2_320___7 ///
			m2_320___8 m2_320___9 m2_320___10 m2_320___11 m2_320___96 m2_320___99 m2_320___998 ///
			m2_320___999 m2_320___888) (m2_320_0 m2_320_1 m2_320_2 m2_320_3 m2_320_4 m2_320_5 ///
			m2_320_6 m2_320_7 m2_320_8 m2_320_9 m2_320_10 m2_320_11 m2_320_96 m2_320_99 m2_320_998_et ///
			m2_320_999_et m2_320_888_et)

	rename (quality_rate_of_care_1st_consult quality_rate_of_care_2nd_consult quality_rate_of_care_3rd_consult quality_rate_of_care_4th_consult quality_rate_of_care_5th_consult) (m2_401 m2_402 m2_403 m2_404 m2_405)
	
	rename (measured_bp_with_a_cuff_501a weight_taken_using_scale_501b taking_blook_draw_from_arm_501c blood_test_using_finger_501d urine_test_peed_container_501e ultrasound_test_501f any_other_test_501g) ///
	(m2_501a m2_501b m2_501c m2_501d m2_501e m2_501f m2_501g)
	
	rename (did_you_receive_any_results_502 which_test_result_did_you_503 have_you_received_test_503b have_you_received_test_503c have_you_received_test_503d have_you_received_test_503e have_you_received_test_503f did_you_receive_any_504 specify_other_test_result)(m2_502 m2_503a m2_503b m2_503c m2_503d m2_503e m2_503f m2_504 m2_504_other)
	
	rename (what_was_the_result_of_anemia what_was_the_result_of_hiv what_was_the_result_of_hiv_viral what_was_the_result_of_syphilis what_was_the_result_of_diabetes what_was_the_result_of_hyperten)(m2_505a m2_505b m2_505c m2_505d m2_505e m2_505f)
	
	rename (since_you_last_discuss_sign_506a since_you_last_care_newborn_506c since_you_last_family_plan_506d ///
			session_of_psychological_508 do_you_know_the_number_session_o how_many_of_these_sessio_508b ///
			do_you_know_how_long_visit_508c how_many_minutes_did_this_508c)(m2_506a m2_506c m2_506d m2_508a ///
			m2_508b_number m2_508b_last m2_508c m2_508d)
	
	rename (a_since_we_last_spoke_did_509a since_we_last_spoke_did_509b since_we_last_spoke_did_509c since_we_last_spoke_did_601a since_we_last_spoke_did_601b since_we_last_spoke_did_601c since_we_last_spoke_did_601d since_we_last_spoke_did_601e since_we_last_spoke_did_601f since_we_last_spoke_did_601g since_we_last_spoke_did_601h since_we_last_spoke_did_601i since_we_last_spoke_did_601j since_we_last_spoke_did_601k since_we_last_spoke_did_601l since_we_last_spoke_did_601m since_we_last_spoke_did_601n specify_other_medicine_sup)(m2_509a m2_509b m2_509c m2_601a m2_601b m2_601c m2_601d m2_601e m2_601f m2_601g m2_601h m2_601i m2_601j m2_601k m2_601l m2_601m m2_601n m2_601n_other)
	
	rename (how_much_paid_602 in_total_how_much_did_you_602 are_you_currently_taking_603 how_often_do_you_take_604 i_would_now_like_to_ask_ab_701)(m2_602a m2_602b m2_603 m2_604 m2_701)
	
	rename (have_you_spent_money_702a how_much_money_did_you_702a have_you_spent_money_702b how_much_money_did_you_702b have_you_spent_money_702c how_much_money_did_you_702c have_you_spent_money_702d how_much_money_did_you_702d have_you_spent_money_702e how_much_money_did_you_702e so_in_total_you_spent_703 you_know_how_much_704 so_how_much_in_total_would_704)(m2_702a m2_702a_other m2_702b m2_702b_other m2_702c m2_702c_other m2_702d m2_702d_other m2_702e m2_702e_other m2_703 m2_704 m2_704_other)
	
	rename (m2_705___1 m2_705___2 m2_705___3 m2_705___4 m2_705___5 m2_705___6 m2_705___96 m2_705___998 m2_705___999 m2_705___888) (m2_705_1 m2_705_2 m2_705_3 m2_705_4 m2_705_5 m2_705_6 m2_705_96 m2_705_998_et m2_705_999_et m2_705_888_et)
	
	rename (specify_other_income_sourc m2_time_it_is_interru at_what_time_it_is_restart time_of_interview_end_103b total_duration_of_interv_103c module_2_phone_surveys_prenatal_)(m2_705_other m2_interupt_time m2_restart_time m2_endtime m2_int_duration m2_complete)
	
	
	
* MODULE 3:

rename (iic_3 cr1_permission_granted_3 date_of_interview_m3 time_of_interview_started_3 m3_birth_or_ended m3_ga1 ga_birth_mat_estimated) ///
	   (m3_start_p1 m3_permission m3_date m3_time m3_birth_or_ended m3_ga1 m3_ga2)

rename (how_many_babies_do_you_303a is_the_1st_baby_alive_303b is_the_2nd_baby_alive_303c is_the_3rd_baby_alive_303d what_is_the_1st_baby_name ///
		what_is_the_2nd_baby_name what_is_the_3rd_baby_name what_is_gender_of_1st_baby what_is_the_gender_of_2nd_baby what_is_the_gender_of_3rd_baby ///
		how_old_is_the_1st_baby when_the_1st_baby_born_was when_the_2nd_baby_born_w when_the_3rd_baby_born_was) (m3_303a m3_303b m3_303c m3_303d m3_baby1_name ///
		m3_baby2_name m3_baby3_name m3_baby1_gender m3_baby2_gender m3_baby3_gender m3_baby1_age m3_baby1_weight m3_baby2_weight m3_baby3_weight) 

rename (do_you_know_weight_1st_baby do_you_know_weight_2nd_baby do_you_know_weight_3rd_baby rate_1st_baby_overall_health rate_2nd_baby_overall_health ///
		rate_3rd_baby_overall_health other_specify other_specifya2  other_specifa3 /// 
		how_confiden_on_breastfeed how_often_per_day_in_eth1_3 born_alive_baby_1 as_you_know_this_survey_202 born_alive_baby_2 born_alive_baby_3 ///
		q313b_1 q313b_2) (m3_baby1_size m3_baby2_size m3_baby3_size m3_baby1_health m3_baby2_health m3_baby3_health m3_baby1_feed_other ///
	    m3_baby2_feed_other m3_baby3_feed_other m3_breastfeeding m3_breastfeeding_fx_et m3_baby1_born_alive m3_202 ///
		m3_baby2_born_alive m3_baby3_born_alive m3_313a_baby1 m3_313b_baby1)		
		
rename (how_you_feed_1st_baby___1 how_you_feed_1st_baby___2 how_you_feed_1st_baby___3 how_you_feed_1st_baby___4 how_you_feed_1st_baby___5 ///
		how_you_feed_1st_baby___6 how_you_feed_1st_baby___7 how_you_feed_1st_baby___96 how_you_feed_1st_baby___99 how_you_feed_1st_baby___998 ///
		how_you_feed_1st_baby___999 how_you_feed_1st_baby___888) (m3_baby1_feed_a m3_baby1_feed_b m3_baby1_feed_c m3_baby1_feed_d m3_baby1_feed_e ///
		m3_baby1_feed_f m3_baby1_feed_g m3_baby1_feed_h m3_baby1_feed_i m3_baby1_feed_998 m3_baby1_feed_999 m3_baby1_feed_888)

rename (how_you_feed_2nd_baby___1 how_you_feed_2nd_baby___2 how_you_feed_2nd_baby___3 how_you_feed_2nd_baby___4 how_you_feed_2nd_baby___5 ///
		how_you_feed_2nd_baby___6 how_you_feed_2nd_baby___7 how_you_feed_2nd_baby___96 how_you_feed_2nd_baby___99 how_you_feed_2nd_baby___998 ///
		how_you_feed_2nd_baby___999 how_you_feed_2nd_baby___888) (m3_baby2_feed_a m3_baby2_feed_b m3_baby2_feed_c m3_baby2_feed_d m3_baby2_feed_e ///
		m3_baby2_feed_f m3_baby2_feed_g m3_baby2_feed_h m3_baby2_feed_i m3_baby2_feed_998 m3_baby2_feed_999 m3_baby2_feed_888)				
		
rename (how_you_feed_3rd_baby___1 how_you_feed_3rd_baby___2 how_you_feed_3rd_baby___3 how_you_feed_3rd_baby___4 how_you_feed_3rd_baby___5 ///
		how_you_feed_3rd_baby___6 how_you_feed_3rd_baby___7 how_you_feed_3rd_baby___96 how_you_feed_3rd_baby___99 how_you_feed_3rd_baby___998 ///
		how_you_feed_3rd_baby___999 how_you_feed_3rd_baby___888) (m3_baby3_feed_a m3_baby3_feed_b m3_baby3_feed_c m3_baby3_feed_d m3_baby3_feed_e ///
		m3_baby3_feed_f m3_baby3_feed_g m3_baby3_feed_h m3_baby3_feed_i m3_baby3_feed_998 m3_baby3_feed_999 m3_baby3_feed_888)

rename (days_or_hours_die_baby_2 days_or_hours_die_baby_4 days_or_hours_die_baby_3 days_or_hours_die_baby_5) (m3_313a_baby2 m3_313b_baby2 ///
		m3_313a_baby3 m3_313b_baby3)		

rename (death_cause_baby_1___a death_cause_baby_1___b death_cause_baby_1___c death_cause_baby_1___d death_cause_baby_1___e death_cause_baby_1___f ///
		death_cause_baby_1___g death_cause_baby_1___96 death_cause_baby_1___998 death_cause_baby_1___999 death_cause_baby_1___888 other_death_case_baby_1) ///
		(m3_death_cause_baby1_a m3_death_cause_baby1_b m3_death_cause_baby1_c m3_death_cause_baby1_d m3_death_cause_baby1_e m3_death_cause_baby1_f ///
		m3_death_cause_baby1_g m3_death_cause_baby1_96 m3_death_cause_baby1_998 m3_death_cause_baby1_999 m3_death_cause_baby1_888 m3_death_cause_baby1_other)		

rename (death_cause_baby_2___a death_cause_baby_2___b death_cause_baby_2___c death_cause_baby_2___d death_cause_baby_2___e death_cause_baby_2___f ///
		death_cause_baby_2___g death_cause_baby_2___96 death_cause_baby_2___998 death_cause_baby_2___999 death_cause_baby_2___888 other_death_case_baby_2) ///
		(m3_death_cause_baby2_a m3_death_cause_baby2_b m3_death_cause_baby2_c m3_death_cause_baby2_d m3_death_cause_baby2_e m3_death_cause_baby2_f ///
		m3_death_cause_baby2_g m3_death_cause_baby2_96 m3_death_cause_baby2_998 m3_death_cause_baby2_999 m3_death_cause_baby2_888 m3_death_cause_baby2_other)	
		
rename (death_cause_baby_3___a death_cause_baby_3___b death_cause_baby_3___c death_cause_baby_3___d death_cause_baby_3___e death_cause_baby_3___f ///
		death_cause_baby_3___g death_cause_baby_3___96 death_cause_baby_3___998 death_cause_baby_3___999 death_cause_baby_3___888 other_death_case_baby_3) ///
		(m3_death_cause_baby3_a m3_death_cause_baby3_b m3_death_cause_baby3_c m3_death_cause_baby3_d m3_death_cause_baby3_e m3_death_cause_baby3_f ///
		m3_death_cause_baby3_g m3_death_cause_baby3_96 m3_death_cause_baby3_998 m3_death_cause_baby3_999 m3_death_cause_baby3_888 m3_death_cause_baby3_other)		
		
rename (when_the_miscarriage_1201 overall_how_would_you_rate_1202 did_you_go_to_a_health_fac_1203 overall_how_would_you_rate_1204 consult_before_delivery_401 ///
		number_healthcare_consult consultation_1 consultation_referral_1) (m3_1201 m3_1202 m3_1203 m3_1204 m3_401 m3_402 m3_consultation_1 m3_consultation_referral_1)

rename (consultation_visit_1___1 consultation_visit_1___2 consultation_visit_1___3 consultation_visit_1___4 consultation_visit_1___5 consultation_visit_1___96 ///
		consultation_visit_1___998 consultation_visit_1___999 consultation_visit_1___888 specify_other_reason_for_1) (m3_consultation1_reason_a ///
		m3_consultation1_reason_b m3_consultation1_reason_c m3_consultation1_reason_d m3_consultation1_reason_e m3_consultation1_reason_96 ///
		m3_consultation1_reason_998 m3_consultation1_reason_999 m3_consultation1_reason_888 m3_consultation1_reason_other)		

rename (consultation_2 consultation_referral_2 consultation_visit_2___1  consultation_visit_2___2 consultation_visit_2___3 consultation_visit_2___4 ///
		consultation_visit_2___5 consultation_visit_2___96 consultation_visit_2___998 consultation_visit_2___999 consultation_visit_2___888 ///
		list_m3) (m3_consultation_2 m3_consultation_referral_2 m3_consultation2_reason_a m3_consultation2_reason_b /// 
		m3_consultation2_reason_c m3_consultation2_reason_d m3_consultation2_reason_e m3_consultation2_reason_96 m3_consultation2_reason_998 ///
		m3_consultation2_reason_999 m3_consultation2_reason_888 m3_consultation2_reason_other)				
		
rename (consultation_3 consultation_visit_3 consultation_referral_3___1 consultation_referral_3___2 consultation_referral_3___3 ///
		consultation_referral_3___4 consultation_referral_3___5 consultation_referral_3___96 consultation_referral_3___998 consultation_referral_3___999 ///
		consultation_referral_3___888 other_reasons_spec) (m3_consultation_3 m3_consultation_referral_3 m3_consultation3_reason_a ///
		m3_consultation3_reason_b m3_consultation3_reason_c m3_consultation3_reason_d m3_consultation3_reason_e m3_consultation3_reason_96 ///
		m3_consultation3_reason_998 m3_consultation3_reason_999 m3_consultation3_reason_888 m3_consultation3_reason_other)		

		
rename (consultation_4 consultation_visit_4 consultation_referral_4___1 consultation_referral_4___2 consultation_referral_4___3 consultation_referral_4___4 ///
		consultation_referral_4___5 consultation_referral_4___96 consultation_referral_4___998 consultation_referral_4___999 consultation_referral_4___888 ///
		other_reasons_spec_2) (m3_consultation_4 m3_consultation_referral_4 m3_consultation4_reason_a m3_consultation4_reason_b m3_consultation4_reason_c  ///
		m3_consultation4_reason_d m3_consultation4_reason_e m3_consultation4_reason_96 m3_consultation4_reason_998 m3_consultation4_reason_999 ///
		m3_consultation4_reason_888 m3_consultation4_reason_other)		
		
rename (consultation_5 consultation_visit_5 consultation_referral_5___1 consultation_referral_5___2 consultation_referral_5___3 consultation_referral_5___4 ///
		consultation_referral_5___5 consultation_referral_5___96 consultation_referral_5___998 consultation_referral_5___999 consultation_referral_5___888 ///
		other_reasons_spec_3) (m3_consultation_5 m3_consultation_referral_5 m3_consultation5_reason_a m3_consultation5_reason_b m3_consultation5_reason_c m3_consultation5_reason_d ///
		m3_consultation5_reason_e m3_consultation5_reason_96 m3_consultation5_reason_998 m3_consultation5_reason_999 m3_consultation5_reason_888 ///
		m3_consultation5_reason_other)		
	
rename (bp_before_delivery_412a weight_before_delivery_412b blood_draw_before_delivery_412c blood_test_before_delivery_412d urine_test_before_delivery_412e ///
		ultrasound_before_delivery_412f other_test_before_delivery_412g m3_412g_other) (m3_412a m3_412b m3_412c m3_412d m3_413e m3_413f m3_413g m3_412g_other)	
	
rename (deliver_health_facility_501 what_kind_of_facility_was_it name_of_the_facility_deliver other_in_the_zone other_outside_of_the_zone_sp ///
		where_was_this_facility_locate subcity_this_facility_m3 before_you_delivered_505a how_long_did_you_stay_at_505b what_day_and_time_did_the_506 ///
		what_day_and_time_did_the_507 m3_506b_98) (m3_501 m3_502 m3_503 m3_503_inside_zone_other m3_503_outside_zone_other m3_504a m3_504b m3_505a ///
		m3_505b m3_506a m3_506b m3_506b_unknown)
 
rename (time_you_leave_facility_507 time_you_leave_facility_507_unk at_any_point_during_labor_508 what_was_the_main_reason_509 ///
		specify_other_reason_for_g did_you_go_to_another_510 how_many_facilities_did_yo_511 what_kind_of_facility_was_512 other_outside_of_the_zo ///
		what_is_the_name_of_513a ther_in_the_zone_specify a_97_other_outside_of_the_zone where_was_this_facility_513b facility_located_city_m3 ///
		what_time_did_you_arriv_514 what_time_did_you_arriv_514_unk why_did_you_go_to_the_2nd_515 why_did_you_or_your_family_516 specify_other_reason_to_go) ///
		(m3_507 m3_507_unknown m3_508 m3_509 m3_509_other m3_510 m3_511 m3_512 m3_512_outside_zone_other m3_513a m3_513_inside_zone_other m3_513_outside_zone_other ///
		m3_513b1 m3_513b2 m3_514 m3_514_unknown m3_515 m3_516 m3_516_other)

rename (did_the_provider_inform_yo_517 why_did_the_provider_refer_518 other_delivery_complications other_reasons_specify what_was_the_main_reason_519 ///
		specify_m at_what_time_did_you_arriv_520 m3_520_98 once_you_got_to_facility_521 m3_521_98 m3_attempt_date m3_attempt_outcome date_of_rescheduled_m3_p1 ///
		time_of_rescheduled_m3_p1 module_3_first_phone_survey_afte) (m3_517 m3_518 m3_518_other_complications m3_518_other m3_519 m3_519_other m3_520 ///
		m3_520_unknown m3_521 m3_521_unknown m3_attempt_date m3_attempt_outcome m3_p1_date_of_rescheduled m3_p1_time_of_rescheduled m3_p1_complete)

rename (iic_4 cr1_permission_granted_4 date_of_interview_m3_2 time_of_interview_started_m3_2 baby1status baby2status baby3status once_you_were_first_checke_601a ///
		once_you_were_first_chec_601b once_you_were_first_chec_601c did_the_health_care_prov_602a did_the_health_care_prov_602b a_during_your_time_in_the_603a ///
		b_during_your_time_in_the_603b c_during_your_time_in_the_603c drink_fluid_m3) (m3_start_p2 m3_permission_p2 m3_date_p2 m3_time_p2 m3_201a m3_201b m3_201c ///
		m3_601a m3_601b m3_601c m3_602a m3_602b m3_603a m3_603b m3_603c m3_603d)		

rename (a_while_you_were_in_labor_604a while_you_were_giving_bi_604b did_you_have_a_caesarean_605a when_was_the_decision_ma_605b) (m3_604a m3_604b ///
		m3_605a m3_605b)

rename (m3_605c___1 m3_605c___2 m3_605c___3 m3_605c___4 m3_605c___96 m3_605c___99 m3_605c___998 m3_605c___999 m3_605c___888 specify_other_reason_for_h) ///
	   (m3_605c_a m3_605c_b m3_605c_c m3_605c_d m3_605c_96 m3_605c_99 m3_605c_998 m3_605c_999 m3_605c_888 m3_605c_other)

rename (did_the_provider_perform_606 did_you_receive_stiches_607 eth_1_6_did_the_health_car eth_2_6_did_the_health_car eth_3_6_did_the_health_car ///
		eth_4_6_did_the_health_car eth_5_6_did_the_health_car immediately_after_delivery_608 immediately_after_delivery_609 was_were_the_baby_babies_610a ///
		was_were_the_baby_s_babi_610b did_a_health_care_provider_611 have_you_done_breask_feed_612) (m3_606 m3_607 m3_607a_et m3_607b_et m3_607c_et m3_607d_et ///
		m3_607e_et m3_608 m3_609 m3_610a m3_610b m3_611 m3_612)	   
	   
rename (how_long_after_delivery_di_614 did_anyone_check_on_baby_1 did_anyone_check_on_baby_2 did_anyone_check_on_baby_3 how_long_after_delivery_baby_1 ///
		how_long_after_delivery_baby_2 how_long_after_delivery_baby_3 receive_a_vaccine_baby_1 receive_a_vaccine_baby_2 receive_a_vaccine_baby_3 ///
		eth_6_6_did_your_1st_baby eth_6_6_did_your_2nd_baby eth_6_6_did_your_3rd_baby eth_7_6_did_your_baby_eye eth_7_6_did_your_baby_eye_2 ///
		eth_7_6_did_your_baby_eye_3 whay_baby_eat_619a) (m3_614 m3_615a m3_615b m3_615c m3_616a m3_616b m3_616c m3_617a m3_617b m3_617c m3_617d_et ///
		m3_617e_et m3_617f_et m3_617g_et m3_617h_et m3_617i_et m3_619a)	   

rename (umblical_cord_care_619b need_avoid_chilling_619c return_vaccination_619d hand_washing_619e danger_sign_or_symptom_619f danger_sign_in_yourself_619g ///
		before_you_left_the_faci_619h before_you_left_the_faci_619i before_you_left_the_faci_619j after_your_baby_was_born_620 who_assisted_the_delivery_621 ///
		did_someone_come_to_chec_621b how_long_after_giving_621c around_the_time_of_deliv_622a when_were_you_told_to_go_622b) (m3_619b m3_619c m3_619d m3_619e ///
		m3_619f m3_619g m3_619h m3_619i m3_619j m3_620 m3_621a m3_621b m3_621c m3_622a m3_622b)	
		
rename (regarding_sleep_1st_baby_today regarding_sleep_2nd_baby_today regarding_sleep_3rd_baby_today regarding_feeding_baby_1 regarding_feeding_baby_2 ///
		regarding_feeding_baby_3 regarding_breathing_baby_1 regarding_breathing_baby_2 regarding_breathing_baby_3 regarding_stooling_baby_5 ///
		regarding_stooling_baby_2 regarding_stooling_baby_3 regarding_their_mood_baby_1 regarding_their_mood_baby_2 regarding_their_mood_baby_3 ///
		regarding_their_skin_baby_1 regarding_their_skin_baby_2 regarding_their_skin_baby_3 regarding_interactivit_baby_1 regarding_interactivit_baby_2 ///
		regarding_interactivit_baby_3)	(m3_baby1_sleep m3_baby2_sleep m3_baby3_sleep m3_baby1_feed m3_baby2_feed m3_baby3_feed m3_baby1_breath m3_baby2_breath ///
		m3_baby3_breath m3_baby1_stool m3_baby2_stool m3_baby3_stool m3_baby1_mood m3_baby2_mood m3_baby3_mood m3_baby1_skin m3_baby2_skin m3_baby3_skin ///
		m3_baby1_interactivity m3_baby2_interactivity m3_baby3_interactivity)	
	
rename (at_any_time_during_labor_701 what_health_problems_did_702 would_you_say_this_problem_703 did_you_experience_seizures did_you_experience_blurvision ///
		did_you_experience_headache did_you_experience_swelling did_you_experience_labor did_you_experience_exces did_you_experience_fever did_you_receive_a_blood_705 ///
		were_you_admitted_to_an_706 how_long_did_you_stay_at_f q707_m3_unk) (m3_701 m3_702 m3_703 m3_704a m3_704b m3_704c m3_704d m3_704e m3_704f m3_70fg m3_705 ///
		m3_706 m3_707 m3_707_unknown)	
	
rename (experience_issiues_baby_1___1 experience_issiues_baby_1___2 experience_issiues_baby_1___3 experience_issiues_baby_1___4 experience_issiues_baby_1___5 ///
		experience_issiues_baby_1___6 experience_issiues_baby_1___96 experience_issiues_baby_1___98 experience_issiues_baby_1___99 experience_issiues_baby_1___998 ///
		experience_issiues_baby_1___999 experience_issiues_baby_1___888) (m3_baby1_issues_a m3_baby1_issues_b m3_baby1_issues_c m3_baby1_issues_d m3_baby1_issues_e ///
		m3_baby1_issues_f m3_baby1_issues_96 m3_baby1_issues_98 m3_baby1_issues_99 m3_baby1_issues_998 m3_baby1_issues_999 m3_baby1_issues_888)
	
rename (experience_issiues_baby_2___1 experience_issiues_baby_2___2 experience_issiues_baby_2___3 experience_issiues_baby_2___4 experience_issiues_baby_2___5 ///
		experience_issiues_baby_2___6 experience_issiues_baby_2___96 experience_issiues_baby_2___98 experience_issiues_baby_2___99 experience_issiues_baby_2___998 ///
		experience_issiues_baby_2___999 experience_issiues_baby_2___888) (m3_baby2_issues_a m3_baby2_issues_b m3_baby2_issues_c m3_baby2_issues_d m3_baby2_issues_e ///
		m3_baby2_issues_f m3_baby2_issues_96 m3_baby2_issues_98 m3_baby2_issues_99 m3_baby2_issues_998 m3_baby2_issues_999 m3_baby2_issues_888)	
		
rename (experience_issiues_baby_3___1 experience_issiues_baby_3___2 experience_issiues_baby_3___3 experience_issiues_baby_3___4 experience_issiues_baby_3___5 ///
		experience_issiues_baby_3___6 experience_issiues_baby_3___96 experience_issiues_baby_3___98 experience_issiues_baby_3___99 experience_issiues_baby_3___998 ///
		experience_issiues_baby_3___999 experience_issiues_baby_3___888) (m3_baby3_issues_a m3_baby3_issues_b m3_baby3_issues_c m3_baby3_issues_d m3_baby3_issues_e ///
		m3_baby3_issues_f m3_baby3_issues_96 m3_baby3_issues_98 m3_baby3_issues_99 m3_baby3_issues_998 m3_baby3_issues_999 m3_baby3_issues_888)	
	
rename (q708_oth write_down_baby_name_709b write_down_baby_name_709c baby_spend_710_baby_1 baby_spend_710_baby_2 baby_spend_710_baby_3 how_long_did_711_baby_1 ///
		how_long_did_711_baby_2 how_long_did_711_baby_3 over_the_past_2_weeks_on_801a b_over_the_past_2_weeks_801b since_you_last_spoke_802a ///
		how_many_of_these_sessio_802b how_many_minutes_did_802c) (m3_708_other m3_708b m3_709c m3_710a m3_710b m3_710c m3_711a m3_711b m3_711c m3_801a ///
		m3_801b m3_802a m3_802b m3_802c)	

rename (have_you_experienced_803a have_you_experienced_803b have_you_experienced_803c have_you_experienced_803d have_you_experienced_803e ///
		have_you_experienced_803f have_you_experienced_803g have_you_experienced_803h have_you_experienced_803i have_you_experienced_803j ///
		specify_any_other_health_prob since_you_gave_birth_have_805 how_many_days_after_giving_806 overall_how_much_does_807 have_you_sought_treatment_808a ///
		why_have_you_not_sought_808b specify_other_reason_not_sought did_the_treatment_stop_809) (m3_803a m3_803b m3_803c m3_803d m3_803e m3_803f m3_803g ///
		m3_803h m3_803i m3_803j m3_803j_other m3_805 m3_806 m3_807 m3_808a m3_808b m3_808b_other m3_809)		

rename (since_we_last_spoke_did_901a since_we_last_spoke_901b since_we_last_spoke_did_901c since_we_last_spoke_did_901d since_we_last_spoke_did_901e ///
		since_we_last_spoke_did_901f since_we_last_spoke_did_901g since_we_last_spoke_did_901h since_we_last_spoke_did_901i since_we_last_spoke_did_901j ///
		since_we_last_spoke_did_901k since_we_last_spoke_did_901l since_we_last_spoke_did_901m since_we_last_spoke_did_901n since_we_last_spoke_did_901o ///
		since_we_last_spoke_did_901p since_we_last_spoke_did_901q since_we_last_spoke_did_901r specify_other_treatment) (m3_901a m3_901b ///
		m3_901c m3_901d m3_901e m3_901f m3_901g m3_901h m3_901i m3_901j m3_901k m3_901l m3_901m m3_901n m3_901o m3_901p m3_901q m3_901r m3_901r_other)		
		
rename (since_they_were_born_did_902a since_they_were_born_did_902a_2 since_they_were_born_did_902a_3 since_they_were_born_did_902b ///
		since_they_were_born_did_902b_3 since_they_were_born_did_902b_2 since_they_were_born_did_902c since_they_were_born_did_902c_3 ///
		since_they_were_born_did_902c_2 since_they_were_born_did_902d since_they_were_born_did_902d_2 since_they_were_born_did_902d_3 ///
		since_they_were_born_did_902e since_they_were_born_did_902e_3 since_they_were_born_did_902e_2 since_they_were_born_did_902f) ///
		(m3_902a_baby1 m3_902a_baby2 m3_902a_baby3 m3_902b_baby1 m3_902b_baby2 m3_902b_baby3 m3_902c_baby1 m3_902c_baby2 m3_902c_baby3 ///
		m3_902d_baby1 m3_902d_baby2 m3_902d_baby3 m3_902e_baby1 m3_902e_baby2 m3_902e_baby3 m3_902f_baby1)		
		
rename (since_they_were_born_did_902f_2 since_they_were_born_did_902f_3 since_they_were_born_did_902g since_they_were_born_did_902g_2 ///
		since_they_were_born_did_902g_3 since_they_were_born_did_902h since_they_were_born_did_902h_2 since_they_were_born_did_902h_3 ///
		since_they_were_born_did_902i since_they_were_born_did_902i_2 since_they_were_born_did_902i_3 since_they_were_born_did_902j ///
		q902j_oth since_they_were_born_did_902j_2 q902j_oth_2 since_they_were_born_did_902j_3 q902j_oth_3) (m3_902f_baby2 m3_902f_baby3 ///
		m3_902g_baby1 m3_902g_baby2 m3_902g_baby3 m3_902h_baby1 m3_902h_baby2 m3_902h_baby3 m3_902i_baby1 m3_902i_baby2 m3_902i_baby3 ///
		m3_902j_baby1 m3_902j_baby1_other m3_902j_baby2 m3_902j_baby2_other m3_902j_baby3 m3_902j_baby3_other)		
		
rename (overall_taking_everything_901 how_likely_are_you_to_reco_902 did_staff_suggest_or_ask_903 rate_the_knowledge_904a rate_the_equipment_904b ///
		rate_the_level_of_respect_904c rate_the_clarity_904d rate_the_degree_904e rate_the_amount_904f rate_the_amount_904a rate_the_courtesy_904h ///
		confidentiality_m3 during_labor_m4 during_labor_m3 did_you_were_pinched_905a you_were_slapped_905b you_were_physically_tied_905c you_had_forceful_905d ///
		you_were_shouted_905e you_were_scolded_905f the_health_worker_905g other_staff_threatened_905h vaginal_examination_1006a) (m3_1001 m3_1002 m3_1003 ///
		m3_1004a m3_1004b m3_1004c m3_1004d m3_1004e m3_1004f m3_1004g m3_1004h m3_1004i m3_1004j m3_1004k m3_1005a m3_1005b m3_1005c m3_1005d m3_1005e m3_1005f ///
		m3_1005g m3_1005h m3_1006a)	
	
rename (ask_permission_viginal_exa_1006b were_vaginal_examination_1006c any_form_of_pain_relief_1007a did_you_request_pain_rel_1007b did_you_receive_pain_rel_1007c ///
		would_like_to_ask_you_1101 spend_money_on_reg_1102 how_much_spent_registra did_you_spend_money_on_med how_you_spent_on_medicin did_you_spend_money_on_test ///
		how_much_spend_on_test did_you_spend_money_on_transp how_much_spend_on_transp did_you_spend_on_food_an how_much_spend_on_food did_you_spend_on_other ///
		how_much_spend_on_other in_total_how_much_you_spen confirm_oop total_spent) (m3_1006b m3_1006c m3_1006d m3_1007b m3_1007c m3_1101 m3_1102a m3_1102a_amt ///
		m3_1102b m3_1102b_amt m3_1102c m3_1102c_amt m3_1102d m3_1102_amt m3_1102e m3_1102e_amt m3_1102f m3_1102f_amt m3_1103 m3_1103_confirm m3_1104)

rename (which_of_the_following_fin_1105 other_income_source_1105 to_conclude_this_survey_1106 time_of_interview_ended_103b ///
		c_total_duration_of_interv ot1 ot1_oth m3_attempt_outcome2 m3_attempt_outcome_p2 date_of_rescheduled_m3_p2 time_of_rescheduled_m3_p2) (m3_1105 ///
		m3_1105_other m3_1106 m3_endtime m3_duration m3_p2_outcome m3_p2_outcome_other m3_attempt_outcome2 m3_attempt_outcome_p2 ///
		m3_p2_date_of_rescheduled m3_p2_time_of_rescheduled)		
		
*===============================================================================
	
	* STEP TWO: ADD VALUE LABELS 
	** many of these value labels can be found in the "REDCap_STATA.do" file that can be downloaded from redcap

	** MODULE 1:
* Label study site values 

label define woreda 1 "Adama special district (town)" 2 "Dugda" 3 "Bora" 4 "Adami Tulu Jido Kombolcha" 5 "Olenchiti" 6 "Adama" 7 "Lume" 96 "Other, specify" 
label values study_site woreda
label define site 1 "Adama" 2 "East Shewa"

generate site = study_site 
recode site (1 = 1) ///
            (2 3 4 5 6 7 96 = 2)
label values site site 

* create new variable for sampling strata 
** we need to make sure we recode in the cleaning file the facility name and strata for st. fransisco
generate sampstrata = facility
recode sampstrata (2 3 4 5 6 8 9 10 11 14 16 17 19 = 1) (18 7 = 2) (22 13 15 1 12 23 96 = 3) (20 21 = 4) 
label values sampstrata strata

* Label Facility Name values 
label define FacilityLabel 1 "Meki Catholic Primary Clinic (01)" 2 "Bote Health Center (02)" 3 "Meki Health Center (03)" 4 "Adami Tulu Health Center (04)" 5 "Bulbula Health Center (05)" 6 "Dubisa Health Center (06)" 7 "Olenchiti Primary Hospital (07)" 8 "Awash Malkasa Health Center (08)" 9 "koka Health Center (09)" 10 "Biyo Health Center (10)" 11 "Ejersa Health Center (11)" 12 "Catholic Church Primary Clinic (12)" 13 "Noh Primary Clinic (13)" 14 "Adama Health Center (14)" 15 "Family Guidance Nazret Specialty Clinic (15)" 16 "Biftu (16)" 17 "Bokushenen (17)" 18 "Adama Teaching Hospital (18)" 19 "Hawas (19)" 20 "Medhanialem Hospital (20)" 21 "Sister Aklisiya Hospital (21)" 22 "Marie stopes Specialty Clinic (22)" 96 "Other in East Shewa or Adama (23)" 
label values facility FacilityLabel

* Label Sampling Strata 
label define strata 1 "Public Primary" 2 "Public Secondary" 3 "Private Primary" 4 "Private Secondary" 

* Label Facility Type values  
label define FacilityTypeLabel 1 "General Hospital" 2 "Primary Hospital" 3 "Health center" 4 "MCH Specialty Clinic/Center" 5 "Primary clinic" 
label values facility_type FacilityTypeLabel 

recode zone_live (96 = 9)
label define zone_live 1 "Adama special district (town)"  2	"Dugda" 3 "Bora" ///
					   4 "Adami Tulu Jido Kombolcha"  5	"Olenchiti" 6 "Adama" ///
					   7 "Lume" 8 "Another district in East Shewa zone" 9 "Outside of East Shewa and Adama town"
label values zone_live zone_live					   

label define reason_anc 1 "Low cost" 2 "Short distance" 3 "Short waiting time" 4 "Good healthcare provider skills" 5 "Staff shows respect" 6 "Medicines and equipment are available" 7 "Cleaner facility" 8 "Only facility available" 9 "covered by CBHI" 10 "Were referred or told to use this provider" 11 "Covered by other insurance" 96 "Other, specify" 99 "NR/RF" 
label values m1_405 reason_anc

recode flash (4 = 1) (5 = 2)
*label define flash 1 "Flash successful" 2 "Flash unsuccessful" 3 "Respondent did not give permission for flash"
label values flash flash

recode m1_203_et b5anc b6anc_first b6anc_first_conf continuecare (2 = 0)
label values m1_203_et b5anc b6anc_first b6anc_first_conf continuecare YN

* Demographic value labels 
label define language 1 "Oromiffa" 2 "Amharegna" 3 "Somaligna" 4 "Tigrigna" 5 "Sidamigna" 6 "Wolaytigna" 7 "Gurage" 8 "Afar" 9 "Hadiyya" 10 "Gamogna" 11 "Gedeo" 12 "Kafa" 96 "Other, specify" 98 "DK" 99 "NR/RF" 
label values m1_501 language

label define education 1 "Some primary" 2 "Completed primary" 3 "Some secondary" 4 "Completed secondary" 5 "Higher education" 99 "NR/RF" 
label values m1_503 education

label define literacy 1 "Cannot read at all" ///
	                  2 "Able to read only parts of sentence" 3 "Able to read whole sentence" 4 "Blind/visually impaired" ///
					  99 "NR/RF" 
label values m1_504 literacy

label define marriage 1 "Never married" 2 "Widowed" 3 "Divorced" 4 "Separated" 5 "Currently married" 6 "Living with partner as if married" 99 "NR/RF" 
label values m1_505 marriage 

label define occupation 1 "Government employee" 2 "Private employee" 3 "Non-government employee" 4 "Merchant/Trader" 5 "Farmer/farmworker/pastoralist" 6 "Homemaker/housewife" 7 "Student" 8 "Laborer" 9 "Unemployed" 96 "Other, specify" 98 "DK" 99 "NR/RF"
label values m1_506 occupation
 
label define religion 1 "Orthodox" 2 "Catholic" 3 "Protestant" 4 "Muslim" 5 "Indigenous" 96 "Other, specify" 98 "DK" 99 "RF"
label values m1_507 religion

label define eligconsent 1 "Eligible and signed consent" 2 "Eligible but did not consent" 3 "Eligible but does not understand [language spoken by interviewer" 0 "Ineligible" 
label values b7eligible eligconsent

label define modcomplete 0 "Incomplete" 1 "Unverified" 2 "Complete" 
label values m1_complete modcomplete

label define flash 1 "Flash successful" 2 "Unsuccessful, reenter phone number" 3 "Respondent did not give permission for flash"
label values m1_513c flash

label define residence 1 "Temporary" 2 "Permanent"
label values m1_517 residence

   ** Repeated Data Value Labels 
   * Label likert scales 
     label define likert 1 "Excellent" 2 "Very good" 3 "Good" 4 "Fair" 5 "Poor" ///
	 99 "Refused"
	 
     * Label values for variables with Likert values 
	   label values m1_201 m1_301 m1_601 likert 
	   label values m1_605a m1_605b m1_605c m1_605d m1_605e m1_605f m1_605g m1_605h m1_605i_et m1_605j_et m1_605k_et likert
	   	 
   * Label Yes/No 
	 label define YN 1 "Yes" 0 "No" 3 "Not applicable" 98 "DK" 99 "RF" 
	 *label define YN2 1 "Yes" 2 "No" 98 "DK" 99 "RF" 
	 label values m1_716a m1_716b m1_716c m1_716d m1_716e YN
   	 label values m1_717 m1_718 m1_719 m1_720 m1_721 m1_722 m1_723 YN 
	 label values m1_813a m1_813b m1_813c m1_813d m1_813e YN
	 label values m1_904 m1_905 m1_907 YN
	 label values permission YN
	 label values mobile_phone YN
	 label values kebele_intworm kebele_malaria YN

	 	 
	 * Label values for variables with Yes / No responses 
	 label values m1_502 m1_509a m1_509b m1_510a m1_510b m1_514a YN 
	 label values m1_204 YN
   	 label values m1_202a m1_202b m1_202c m1_202d m1_202e m1_202f m1_202g YN
	 label values m1_724a m1_724c m1_724d m1_724e m1_724f m1_724g m1_724h m1_724i YN
	 label values m1_801 m1_802b_et YN
	 label values m1_814a m1_814b m1_814c m1_814d m1_814e m1_814f m1_814g m1_814h m1_814i YN
	 label values m1_1004 m1_1005 m1_1006 m1_1_10_et m1_1007 m1_1008 m1_1010 YN
	 label values m1_1011a m1_1011b m1_1011c m1_1011d m1_1011e m1_1011f YN
	 label values m1_1101 m1_1103 YN
	 label values m1_1217 m1_1218a m1_1218b m1_1218c m1_1218d m1_1218e m1_1218f YN
	 label values m1_1221 YN
	*label values current_income savings health_insurance sold_items family_members borrowed other YN

	 
   * Labels for EQ5D  	 
     label define EQ5D 1 "I have no problems" 2 "I have some problems" 3 "I have severe problems" 99 "NR/RF" 
	 label define EQ5Dpain 1 "I have no pain" 2 "I have some pain" 3 "I have severe pain" 99 "NR/RF" 
	 label define EQ5Danxiety 1 "I have no anxiety" 2 "I have some anxiety" 3 "I have severe anxiety" 99 "NR/RF" 
	 
	 label values m1_205a m1_205b m1_205c EQ5D
	 label values m1_205d EQ5Dpain
	 label values m1_205e EQ5Danxiety
	 
* QoC labels 
	label define recommend 1 "Very likely" 2 "Somewhat likely" 3 "Not too likely" 4 "Not at all likely" 99 "NR/RF" 
	label values m1_602 recommend
   
	label define satisfaction 1 "Very satisfied" 2 "Satisfied" 3 "Neither satisfied nor dissatisfied" 4 "Dissatisfied" 5 "Very dissatisfied" 98 "DK" 99 "NR/RF" 
	label values m1_1223 satisfaction

	label define diarrhea  1 "Less than usual" 2 "More than usual" 3 "About the same" 4 "It doesnt matter" 98 "DK" 
	label values m1_511 diarrhea 

	label define smoke 1 "Good" 2 "Harmful" 3 "Doesnt matter" 98 "DK" 
	label values m1_512 smoke 

	label define hsview 1 "System works pretty well, minor changes" ///
	                    2 "Some good things, but major changes are needed" ///
						3 "System has so much wrong with it, completely rebuild it" ///
						98 "DK" ///
						99 "RF" 
	label values m1_302 hsview
	
	label define confidence 1 "Very confident" ///
	                        2 "Somewhat confident" ///
							3 "Not very confident" ///
							4 "Not at all confident" ///
							98 "DK" ///
							99 "NR/RF"
	label values m1_303 m1_304 m1_305a m1_305b confidence 

	label define travel_mode 1 "Walking" 2 "Bicycle" 3 "Motorcycle" 4 "Car (personal or borrowed)" 5 "Bus/train/other public transportation" 6 "Mule/horse/donkey" 7 "Bajaj" 96 "Other (specify)" 98 "DK" 99 "NR/RF" 
	label values m1_401 travel_mode

	label define bypass 1 "Yes, its the nearest" 2 "No, theres another one closer" 98 "DK" 99 "NR/RF" 
	label values m1_404 bypass 
	
	label values m1_700 m1_701 m1_702 m1_703 m1_704 m1_705 m1_706 m1_707 YN
	label values m1_712 YN
	label values m1_708a m1_708c m1_708d m1_708e m1_708f m1_710a m1_711a m1_712 YN
	
    label define yesnona 1 "Yes" 0 "No" 2 "Not applicable" 98 "DK" 99 "RF" 
	
	label values m1_704 yesnona
	
	label define test_result 1 "Positive" 2 "Negative" 98 "DK" 99 "RF" 
	label values m1_708b test_result
	label values m1_710b test_result
	label define bdsugartest 1 "Blood sugar was high/elevated" 2 "Blood sugar was normal" 98 "DK" 99 "NR/RF"
	label values m1_711b bdsugartest
	label values m1_708a YN 
    label values m1_711a YN
    label values m1_710a m1_710b YN
	label values m1_708a m1_708c m1_708d m1_708e m1_708f m1_709a m1_709b YN
    label values m1_714a m1_714b YN 
	
	label define meds 1 "Provider gave it directly" 2 "Prescription, told to get it somewhere else" 3 "Neither" 98 "DK" 99 "NR/RF" 
	label values m1_713a m1_713b m1_713c m1_713d m1_713e m1_713f m1_713g m1_713h m1_713i meds

	label define itn 1 "Yes" 0 "No" 2 "Already have one"
	label values m1_715 itn

	label define trimester 1 "First trimester" 2 "Second trimester" 3 "Third trimester" 98 "Unknown" 
	label define numbabies 1 "One baby" 2 "Two babies (twins)" 3 "Three or more babies (triplets or higher)" 98 "DK" 99 "NR/RF"
	label values m1_805 numbabies 
	label values m1_806 m1_807 m1_809 m1_811 m1_812a YN
	label define m1_810a 1 "In your home" 2 "Someone elses home" 3 "Government hospital" 4 "Government health center" 5 "Government health post" 6 "NGO or faith-based health facility" 7 "Private hospital" 8 "Private specialty maternity center" 9 "Private specialty maternity clinic" 10 "Private clinic" 11 "Another private medical facility (including pharmacy, shop, traditional healer)" 98 "DK" 99 "NR/RF" 
	
	label values m1_810a m1_810a

	label define smokeamt 1 "Every day" 2 "Some days" 3 "Not at all" 98 "DK" 99 "NR/RF" 
		
	label values m1_901 m1_903 smokeamt

	label define water_source 1 "Piped water" 2 "Water from open well" 3 "Water from covered well or borehole" 4 "Surface water" 5 "Rain water" 6 "Bottled water" 96 "Other (specify)" 98 "DK" 99 "NR/RF" 
	
	label values m1_1201 water_source
	
	label define toilet 1 "Flush or pour flush toilet" 2 "Pit toilet/latrine" 3 "No facility" 96 "Other (specify)" 98 "DK" 99 "NR/RF" 
	
	label values m1_1202 toilet
	
	label values m1_1203 m1_1204 m1_1205 m1_1206 m1_1207 YN
	
	label define cook_fuel 1 "Main electricity" 2 "Bottled gas" 3 "Paraffin/kerosene" 4 "Coal/Charcoal" 5 "Firewood" 6 "Dung" 7 "Crop residuals" 8 "Solar" 96 "Other (specify)" 98 "DK" 99 "NR/RF" 
	label values m1_1208 cook_fuel
	
	label define floor 1 "Natural floor (earth, dung)" 2 "Rudimentary floor (wood planks, palm)" 3 "Finished floor (polished wood, tiles, cement, vinyl)" 96 "Other (specify)" 98 "DK" 99 "NR/RF"
	
	label values m1_1209 floor 
	
	label define walls 1 "Grass" 2 "Poles and mud" 3 "Sun-dried bricks" 4 "Baked bricks" 5 "Timber" 6 "Cement bricks" 7 "Stones" 8 "Corrugated iron" 96 "Other (specify)" 98 "DK" 99 "NR/RF"
	
	label values m1_1210 walls

	label define roof 1 "No roof" 2 "Grass/leaves/mud" 3 "Iron sheets" 4 "Tiles" 5 "Concrete" 96 "Other (specify)" 98 "DK" 99 "NR/RF" 
	label values m1_1211 roof
	
	label values m1_1212 m1_1213 m1_1214 m1_1215 YN

	label define insurance_type 1 "Community based health insurance" 2 "Employer-provided health insurance (reimbursement)" 3 "Private health insurance" 96 "Other (specify)" 98 "DK" 99 "NR/RF"
	label values m1_1221 insurance_type
	
	** MODULE 2:
	label define m2_attempt_outcome 1 "Answered the phone, correct respondent (Start survey)" 2 "Answered but not by the respondent (Go to A4)" 3 "No answer (rings but not response or line was busy)" 4 "Number does not work (does not ring/connect to a phone)" 5 "Phone was switched off"
	label values m2_attempt_outcome m2_attempt_outcome
	
	label define m2_attempt_relationship 1 "Family member" 2 "Friend/Neighbor" 3 "Colleague" 4 "Does not know the respondent" 5 "Other, specify"
	label values m2_attempt_relationship m2_attempt_relationship
	
	label define m2_attempt_avail 1 "Yes" 0 "No"
	label values m2_attempt_avail m2_attempt_avail
	
	label define m2_attempt_contact 1 "Yes" 0 "No"
	label values m2_attempt_contact m2_attempt_contact
	
	label define m2_start 1 "Yes" 0 "No" 
	label values m2_start m2_start
	
	label define m2_permission 1 "Yes" 0 "No" 
	label values m2_permission
	
	label define maternal_death_reported 1 "Yes" 0 "No" 
	label values maternal_death_reported maternal_death_reported
	
	label define m2_hiv_status 1 "Positive" 2 "Negative" 3 "Unknown" 
	label values m2_hiv_status m2_hiv_status
	
	label define m2_maternal_death_learn 1 "Called respondent phone, someone else responded" ///
									  2 "Called spouse/partner phone, was informed" ///
									  3 "Called close friend or family member phone number, was informed" ///
									  4 "Called CHW phone number, was informed" 5 "Other"
	label values m2_maternal_death_learn m2_maternal_death_learn
	
	label define m2_201 1 "Excellent" 2 "Very good" 3 "Good" 4 "Fair" 5 "Poor" 98 "DK" 99 "RF/NR" 
	label values m2_201 m2_201

	label define m2_202 1 "Yes, still pregnant" 2 "No, delivered" 3 "No, something else happened" 
	label values m2_202 m2_202

	label define m2_203a 1 "Yes" 0 "No" 98 "DK" 99 "NR/RF" 
	label values m2_203a m2_203a
	
	label define m2_203b 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_203b m2_203b

	label define m2_203c 1 "Yes" 0 "No" 98 "DK" 99 "NR/RF" 
	label values m2_203c m2_203c

	label define m2_203d 1 "Yes" 0 "No" 98 "DK" 99 "NR/RF" 
	label values m2_203d m2_203d

	label define m2_203e 1 "Yes" 0 "No" 98 "DK" 99 "NR/RF" 
	label values m2_203e m2_203e

	label define m2_203f 1 "Yes" 0 "No" 98 "DK" 99 "NR/RF" 
	label values m2_203f m2_203f
	
	label define m2_203g 1 "Yes" 0 "No" 98 "DK" 99 "NR/RF" 
	label values m2_203g m2_203g

	label define mx2_203h 1 "Yes" 0 "No" 98 "DK" 99 "NR/RF" 
	label values m2_203h m2_203h

	label define m2_203i 1 "Yes" 0 "No" 98 "DK" 99 "NR/RF" 
	label values m2_203i m2_203i

	label define m2_204a 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_204a m2_204a

	label define m2_204b 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_204b m2_204b
	
	label define m2_204c 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_204b m2_204b
	
	label define m2_204d 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_204d m2_204d

	label define m2_204e 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_204e m2_204e

	label define m2_204f 1 "Yes" 0 "No" 98 "DK" 99 "RF"
	label values m2_204f m2_204f
 
	label define m2_204g 1 "Yes" 0 "No" 98 "DK" 99 "RF"
	label values m2_204g m2_204g

	label define m2_204h 1 "Yes" 0 "No" 98 "DK" 99 "RF"
	label values m2_204h m2_204h

	label define m2_204i 1 "Yes" 0 "No" 98 "DK" 99 "RF"
	label values m2_204i m2_204i

	label define m2_205a 0 "None of the days" 1 "Several days" 2 "More than half the days (>7)" 3 "Nearly every day" 
	label values m2_205a m2_205a

	label define m2_205b 0 "None of the days" 1 "Several days" 2 "More than half the days (>7)" 3 "Nearly every day" 
	label values m2_205b m2_205b

	label define m2_205_ 0 "None of the days" 1 "Several days" 2 "More than half the days (>7)" 3 "Nearly every day" 99 "NR/RF"
	label values m2_205c m2_205c

	label define m2_205d 0 "None of the days" 1 "Several days" 2 "More than half the days (>7)" 3 "Nearly every day" 99 "NR/RF" 
	label values m2_205d m2_205d

	label define m2_205e 0 "None of the days" 1 "Several days" 2 "More than half the days (>7)" 3 "Nearly every day" 99 "NR/RF"
	label values m2_205e m2_205e

	label define m2_205f 0 "None of the days" 1 "Several days" 2 "More than half the days (>7)" 3 "Nearly every day" 99 "NR/RF" 
	label values m2_205f m2_205f

	label define m2_205g 0 "None of the days" 1 "Several days" 2 "More than half the days (>7)" 3 "Nearly every day" 99 "NR/RF" 
	label values m2_205g m2_205g

	label define m2_205h 0 "None of the days" 1 "Several days" 2 "More than half the days (>7)" 3 "Nearly every day" 99 "NR/RF" 
	label values m2_205h m2_205h

	label define m2_205i 0 "None of the days" 1 "Several days" 2 "More than half the days (>7)" 3 "Nearly every day" 99 "NR/RF" 
	label values m2_205i m2_205i

	label define m2_206 1 "Every day" 2 "Some days" 3 "Not at all" 98 "DK" 99 "RF" 
	label values m2_206 m2_206

	label define m2_207 1 "Every day" 2 "Some days" 3 "Not at all" 98 "DK" 99 "RF" 
	label values m2_207 m2_207

	label define m2_208 1 "Every day" 2 "Some days" 3 "Not at all" 98 "DK" 99 "RF" 
	label values m2_208 m2_208

	label define m2_301 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_301 m2_301

	label define m2_302 1 "1" 2 "2" 3 "3" 4 "4" 5 "5" 
	label values m2_302 m2_302

	label define m2_303a 1 "In your home" 2 "Someone elses home" 3 "Government hospital" ///
					 4 "Government health center" 5 "Government health post" ///
					 6 "NGO or faith-based health facility" 7 "Private hospital" ///
					 8 "Private specialty maternity center" 9 "Private specialty maternity clinic" ///
					 10 "Private clinic" ///
					 11 "Another private medical facility (including pharmacy, shop, traditional healer)" ///
					 98 "DK" 99 "RF" 
	label values m2_303a m2_303a

	label define m2_303b 1 "In your home" 2 "Someone elses home" 3 "Government hospital" ///
					 4 "Government health center" 5 "Government health post" ///
					 6 "NGO or faith-based health facility" 7 "Private hospital" ///
					 8 "Private specialty maternity center" 9 "Private specialty maternity clinic" ///
					 10 "Private clinic" ///
					 11 "Another private medical facility (including pharmacy, shop, traditional healer)" ///
					 98 "DK" 99 "RF" 
	label values m2_303b m2_303b
					 
	label define m2_303c 1 "In your home" 2 "Someone elses home" 3 "Government hospital" ///
					 4 "Government health center" 5 "Government health post" ///
					 6 "NGO or faith-based health facility" 7 "Private hospital" ///
					 8 "Private specialty maternity center" 9 "Private specialty maternity clinic" ///
					 10 "Private clinic" ///
					 11 "Another private medical facility (including pharmacy, shop, traditional healer)" ///
					 98 "DK" 99 "RF"
	label values m2_303c m2_303c
					 
					 
	label define m2_303d 1 "In your home" 2 "Someone elses home" 3 "Government hospital" ///
					 4 "Government health center" 5 "Government health post" ///
					 6 "NGO or faith-based health facility" 7 "Private hospital" ///
					 8 "Private specialty maternity center" 9 "Private specialty maternity clinic" ///
					 10 "Private clinic" ///
					 11 "Another private medical facility (including pharmacy, shop, traditional healer)" ///
					 98 "DK" 99 "RF"
	label values m2_303d m2_303d
					 		
	label define m2_303e 1 "In your home" 2 "Someone elses home" 3 "Government hospital" ///
					 4 "Government health center" 5 "Government health post" ///
					 6 "NGO or faith-based health facility" 7 "Private hospital" ///
					 8 "Private specialty maternity center" 9 "Private specialty maternity clinic" ///
					 10 "Private clinic" ///
					 11 "Another private medical facility (including pharmacy, shop, traditional healer)" ///
					 98 "DK" 99 "RF" 
	label values m2_303e m2_303e			 
	
	label define m2_304a 1 "Meki Catholic Primary Clinic" 2 "Bote Health Center" 3 "Meki Health Center" 4 "Adami Tulu Health Center" 5 "Bulbula Health Center" 6 "Dubisa Health Center" 7 "Olenchiti Primary Hospital" 8 "Awash Malkasa Health Center" 9 "Koka Health Center" 10 "Biyo Health Center" 11 "Ejersa Health Center" 12 "Catholic Church Primary Clinic" 13 "Noh Primary Clinic" 14 "Adama Health Center" 15 "Family Guidance Nazret Specialty Clinic" 16 "Biftu" 17 "Bokushenen" 18 "Adama Teaching Hospital" 19 "Hawas" 20 "Medhanialem Hospital" 21 "Sister Aklisiya Hospital" 22 "Marie stopes Specialty Clinic" 23 "Other in East Shewa or Adama, Specify"
	label values m2_304a m2_304a

	label define m2_304b 1 "Meki Catholic Primary Clinic" 2 "Bote Health Center" 3 "Meki Health Center" 4 "Adami Tulu Health Center" 5 "Bulbula Health Center" 6 "Dubisa Health Center" 7 "Olenchiti Primary Hospital" 8 "Awash Malkasa Health Center" 9 "koka Health Center" 10 "Biyo Health Center" 11 "Ejersa Health Center" 12 "Catholic Church Primary Clinic" 13 "Noh Primary Clinic" 14 "Adama Health Center" 15 "Family Guidance Nazret Specialty Clinic" 16 "Biftu" 17 "Bokushenen" 18 "Adama Teaching Hospital" 19 "Hawas" 20 "Medhanialem Hospital" 21 "Sister Aklisiya Hospital" 22 "Marie stopes Specialty Clinic" 23 "Other in East Shewa or Adama, Specify"
	label values m2_304b m2_304b

	label define m2_304c 1 "Meki Catholic Primary Clinic" 2 "Bote Health Center" 3 "Meki Health Center" 4 "Adami Tulu Health Center" 5 "Bulbula Health Center" 6 "Dubisa Health Center" 7 "Olenchiti Primary Hospital" 8 "Awash Malkasa Health Center" 9 "koka Health Center" 10 "Biyo Health Center" 11 "Ejersa Health Center" 12 "Catholic Church Primary Clinic" 13 "Noh Primary Clinic" 14 "Adama Health Center" 15 "Family Guidance Nazret Specialty Clinic" 16 "Biftu" 17 "Bokushenen" 18 "Adama Teaching Hospital" 19 "Hawas" 20 "Medhanialem Hospital" 21 "Sister Aklisiya Hospital" 22 "Marie stopes Specialty Clinic" 23 "Other in East Shewa or Adama, Specify"
	label values m2_304c m2_304c

	label define m2_304d 1 "Meki Catholic Primary Clinic" 2 "Bote Health Center" 3 "Meki Health Center" 4 "Adami Tulu Health Center" 5 "Bulbula Health Center" 6 "Dubisa Health Center" 7 "Olenchiti Primary Hospital" 8 "Awash Malkasa Health Center" 9 "Koka Health Center" 10 "Biyo Health Center" 11 "Ejersa Health Center" 12 "Catholic Church Primary Clinic" 13 "Noh Primary Clinic" 14 "Adama Health Center" 15 "Family Guidance Nazret Specialty Clinic" 16 "Biftu" 17 "Bokushenen" 18 "Adama Teaching Hospital" 19 "Hawas" 20 "Medhanialem Hospital" 21 "Sister Aklisiya Hospital" 22 "Marie stopes Specialty Clinic" 23 "Other in East Shewa or Adama, Specify" 	
	label values m2_304d m2_304d

	label define m2_304e 1 "Meki Catholic Primary Clinic" 2 "Bote Health Center" 3 "Meki Health Center" 4 "Adami Tulu Health Center" 5 "Bulbula Health Center" 6 "Dubisa Health Center" 7 "Olenchiti Primary Hospital" 8 "Awash Malkasa Health Center" 9 "Koka Health Center" 10 "Biyo Health Center" 11 "Ejersa Health Center" 12 "Catholic Church Primary Clinic" 13 "Noh Primary Clinic" 14 "Adama Health Center" 15 "Family Guidance Nazret Specialty Clinic" 16 "Biftu" 17 "Bokushenen" 18 "Adama Teaching Hospital" 19 "Hawas" 20 "Medhanialem Hospital" 21 "Sister Aklisiya Hospital" 22 "Marie stopes Specialty Clinic" 23 "Other in East Shewa or Adama, Specify" 
	label values m2_304e m2_304e

	label define m2_305 1 "Yes, for a routine antenatal care" 0 "No" 98 "DK" 99 "RF" 
	label values m2_305 m2_305
	
	label define m2_306 1 "Yes, for a referral from your antenatal care provider" 0 "No" 98 "DK" 99 "RF" 
	label values m2_306 m2_306

	label define m2_308 1 "Yes, for a routine antenatal care" 0 "No" 98 "DK" 99 "RF" 
	label values m2_308 m2_308

	label define m2_309 1 "Yes, for a referral from your antenatal care provider" 0 "No" 98 "DK" 99 "RF" 
	label values m2_309 m2_309
	
	label define m2_311 1 "Yes, for a routine antenatal care" 0 "No" 98 "DK" 99 "RF" 
	label values m2_311 m2_311
 
	label define m2_312 1 "Yes, for a referral from your antenatal care provider" 0 "No" 98 "DK" 99 "RF" 
	label values m2_312 m2_312

	label define m2_314 1 "Yes, for a routine antenatal care" 0 "No" 98 "DK" 99 "RF"  
	label values m2_314 m2_314
	
	label define m2_315 1 "Yes, for a referral from your antenatal care provider" 0 "No" 98 "DK" 99 "RF" 
	label values m2_315 m2_315

	label define m2_317 1 "Yes, for a routine antenatal care" 0 "No" 98 "DK" 99 "RF"
	label values m2_317 m2_317

	label define m2_318 1 "Yes, for a referral from your antenatal care provider" 0 "No" 98 "DK" 99 "RF" 
	label values m2_318 m2_318 

	label define m2_321 0 "No" 1 "Yes, by phone" 2 "Yes, by SMS" 3 "Yes, by web" 98 "DK" 99 "NR/RF" 
	label values m2_321 m2_321

	label define m2_401 1 "Excellent" 2 "Very good" 3 "Good" 4 "Fair" 5 "Poor" 98 "DK" 99 "RF" 
	label values m2_401 m2_401

	label define m2_402 1 "Excellent" 2 "Very good" 3 "Good" 4 "Fair" 5 "Poor" 98 "DK" 99 "RF" 
	label values m2_402 m2_402
		
	label define m2_403 1 "Excellent" 2 "Very good" 3 "Good" 4 "Fair" 5 "Poor" 98 "DK" 99 "RF" 
	label values m2_403 m2_403
	
	label define m2_404 1 "Excellent" 2 "Very good" 3 "Good" 4 "Fair" 5 "Poor" 98 "DK" 99 "RF"  
	label values m2_404 m2_404
	
	label define m2_405 1 "Excellent" 2 "Very good" 3 "Good" 4 "Fair" 5 "Poor" 98 "DK" 99 "RF" 
	label values m2_405 m2_405
	
	label define m2_501a 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_501a m2_501a

	label define m2_501b 1 "Yes" 0 "No" 98 "DK" 99 "RF"  
	label values m2_501b m2_501b
	
	label define m2_501c 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_501c m2_501c
	
	label define m2_501d 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_501d m2_501d
	
	label define m2_501e 1 "Yes" 0 "No" 98 "DK" 99 "RF"  
	label values m2_501e m2_501e
	
	label define m2_501f 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_501f m2_501f
	
	label define m2_501g 1 "Yes" 0 "No" 98 "DK" 99 "RF"  
	label values m2_501g m2_501g
	
	label define m2_502 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_502 m2_502
	
	label define m2_503a 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_503a m2_503a
	
	label define m2_503b 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_503b m2_503b
	
	label define m2_503c 1 "Yes" 0 "No" 98 "DK" 99 "RF"
	label values m2_503c m2_503c
		
	label define m2_503d 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_503d m2_503d
	
	label define m2_503e 1 "Yes" 0 "No" 98 "DK" 99 "RF"
	label values m2_503e m2_503e

	label define m2_503f 1 "Yes" 0 "No" 98 "DK" 99 "RF"
	label values m2_503f m2_503f
	
	label define m2_504 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_504 m2_504
	
	label define m2_505a 1 "Anemic" 0 "Not anemic" 98 "DK" 99 "NR/RF" 
	label values m2_505a m2_505a
	
	label define m2_505b 1 "Positive" 0 "Negative" 98 "DK" 99 "NR/RF"
	label values m2_505b m2_505b
	
	label define m2_505c 1 "Viral load not suppressed" 0 "Viral load is suppressed" 98 "DK" 99 "NR/RF"
	label values m2_505c m2_505c
	
	label define m2_505d 1 "Positive" 0 "Negative" 98 "DK" 99 "NR/RF" 
	label values m2_505d m2_505d

	label define m2_505e 1 "Diabetic" 0 "Not diabetic" 98 "DK" 99 "NR/RF" 
	label values m2_505e m2_505e

	label define m2_505f 1 "Hypertensive" 0 "Not hypertensive" 98 "DK" 99 "NR/RF" 
	label values m2_505f m2_505f

	label define m2_506a 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_506a m2_506a
	
	label define m2_506b 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_506b m2_506b
	
	label define m2_506c 1 "Yes" 0 "No" 98 "DK" 99 "RF"
	label values m2_506c m2_506c
	
	label define m2_506d 1 "Yes" 0 "No" 98 "DK" 99 "RF"
	label values m2_506d m2_506d
	
	label define m2_507 0 "Nothing I did not speak about this with a health care provider" ///
						1 "Told you to come back later" ///
						2 "Told you to get a lab test or imaging (e.g., blood tests, ultrasound, x-ray, heart echo)" ///
						3 "Told you to go to hospital or see a specialist like an obstetrician or gynecologist" ///
						4 "Told you to take painkillers like acetaminophen" ///
						5 "Told you to wait and see" ///
						96 "Other, specify" ///
						98 "DK" 99 "RF" 
	label values m2_507 m2_507
	
	label define m2_508a 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_508a m2_508a
	
	label define m2_508b_number 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_508b_number m2_508b_number

	label define m2_508b_last 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_508b_last m2_508b_last
	
	label define m2_508c 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_508c m2_508c

	label define m2_509a 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_509a m2_509a
	
	label define m2_509b 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_509b m2_509b
	
	label define m2_509c 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_509c m2_509c
	
	label define m2_601a 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_601a m2_601a
	
	label define m2_601b 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_601b m2_601b
	
	label define m2_601c 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_601c m2_601c
	
	label define m2_601d 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_601d m2_601d
	
	label define m2_601e 1 "Yes" 0 "No" 98 "DK" 99 "RF"
	label values m2_601e m2_601e
	
	label define m2_601f 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_601f m2_601f
	
	label define m2_601g 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_601g m2_601g
	
	label define m2_601h 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_601h m2_601h
	
	label define m2_601i 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_601i m2_601i
	
	label define m2_601j 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_601j m2_601j
	
	label define m2_601k 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_601k m2_601k
	
	label define m2_601l 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_601l m2_601l
	
	label define m2_601m 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_601m m2_601m

	label define m2_601n 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_601n m2_601n

	label define m2_602a 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_602a m2_602a

	label define m2_603 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_603 m2_603
	
	label define m2_604 1 "Every day" 2 "Every other day" 3 "Once a week" 4 "Less than once a week" 98 "DK" 99 "NR/RF" 
	label values m2_604 m2_604

	label define m2_701 1 "Yes" 0 "No" 98 "DK" 99 "RF"
	label values m2_701 m2_701

	label define m2_702a 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_702a m2_702a

	label define m2_702b 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_702b m2_702b

	label define m2_702c 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_702c m2_702c

	label define m2_702d 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_702d m2_702d

	label define m2_702e 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_702e m2_702e

	label define m2_704 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_704 m2_704

label define m2_interview_inturrupt 1 "Yes" 0 "No" 
label values m2_interview_inturrupt m2_interview_inturrupt

label define m2_interview_restarted_ 1 "Yes" 0 "No" 
label values m2_interview_restarted m2_interview_restarted

label define m2_endstatus 1 "Active follow-up" 2 "Lost to follow-up" 3 "Decline further participation" 4 "Maternal death" 5 "No longer pregnant"
label values m2_endstatus m2_endstatus

label define m2_complete 0 "Incomplete" 1 "Unverified" 2 "Complete" 
label values m2_complete m2_complete

	* MODULE 3:

label define YN_m3 1 "Yes" 0 "No"
label values m3_start_p1 m3_permission m3_baby1_born_alive m3_baby2_born_alive ///
			 m3_baby3_born_alive m3_508 m3_start_p2 m3_permission_p2 YN_m3

label define m3_303a 1 "One" 2 "Two" 3 "Three or more" 98 "Don't Know" 99 "NR/RF"
label values m3_303a m3_303a
	
label define YNRF 1 "Yes" 0 "No" 99 "NR/RF"
label values m3_303b m3_303c m3_303d m3_505a m3_517 YNRF

label define m3_gender 1 "Male" 2 "Female" 99 "NR/RF"
label values m3_baby1_gender m3_baby2_gender m3_baby3_gender m3_gender
	
label define m3_weight 1 "Very large" 2 "Larger than average" 3 "Average" ///
					   4 "Smaller than average" 5 "Very small"
label values m3_baby1_weight m3_baby2_weight m3_baby3_weight m3_weight
	
label define m3_overallhealth 1 "Excellent" 2 "Very Good" 3 "Good" ///
							  4 "Fair" 5 "Poor" 99 "NR/RF"
label values m3_baby1_health m3_baby2_health m3_baby3_health m3_overallhealth	

label define m3_confidence 1 "Very confident" 2 "Confident" 3 "Somewhat confident" ///
						   4 "Not very confident" 5 "Not at all confident" ///
						   96 "I do not breastfeed" 98 "DK" 99 "NR/RF"
label values m3_breastfeeding m3_confidence
	
label define m3_202	3 "Delivered with still birth" 4 "Miscarriage" 5 "Abortion"
label values m3_202 m3_202

label define YNDKRF 1 "Yes" 0 "No" 98 "Don't Know" 99 "NR/RF"
label values m3_1201 m3_1203 m3_401 m3_consultation_1 m3_consultation_referral_1 ///
			 m3_consultation_2 m3_consultation_referral_2 ///
			 m3_consultation_3 m3_consultation_referral_3 ///
			 m3_consultation_4 m3_consultation_referral_4 ///
			 m3_consultation_5 m3_consultation_referral_5 ///
			 m3_412a m3_412b m3_412c m3_412d m3_412e m3_412f ///
			 m3_412g m3_501 m3_510 m3_601a m3_601b m3_601c ///
			 m3_602b m3_603a m3_603b m3_603c m3_603d m3_604b ///
			 m3_605a m3_605b m3_606 m3_607 m3_607a_et m3_607b_et ///
			 m3_607c_et m3_607d_et m3_607e_et m3_608 m3_609 m3_610a ///
			 m3_610b m3_611 m3_613 m3_615a m3_615b m3_615c m3_617a ///
			 m3_617b m3_617c m3_617d_et m3_617e_et m3_617f_et m3_617g_et ///
			 m3_617h_et m3_617i_et m3_619a m3_619b m3_619c m3_619d ///
			 m3_619e m3_619f m3_619g m3_619h m3_619i m3_619j m3_620 ///
		     m3_621b m3_622a m3_622c m3_701 m3_703 m3_704a m3_704b ///
			 m3_704c m3_704d m3_704e m3_704f m3_70fg m3_705 m3_706 ///
			 m3_710a m3_710b m3_710c m3_YNDKRF

label define confidenceDKNR 1 "Excellent" 2 "Very Good" 3 "Good" ///
							4 "Fair" 5 "Poor" 98 "Don't Know" 99 "NR/RF"
label values m3_1202 m3_1204 confidenceDKNR
	
label define numbers_chron 1 "One" 2 "Two" 3 "Three" 4 "Four" 5 "Five"
label values m3_402 numbers_chron	

label define m3_502 1 "Government hospital" 2 "Government health center" ///
					3 "Government health post" 4 "NGO or faith-based health facility" ///
					5 "Private hospital" 6 "Private specialty maternity center" ///
					7 "Private specialty maternity clinics" 8 "Private clinic" ///
					9 "Another private medical facility (including pharmacy, shop, traditional healer)" ///
					98 "Don't Know" 99 "NR/RF"
label values m3_502 m3_502

label define m3_503 1 "Meki Catholic Primary Clinic" 2 "Bote Health Center" 3 "Meki Health Center" 4 "Adami Tulu Health Center" 5 "Bulbula Health Center" ///
					6 "Dubisa Health Center" 7 "Olenchiti Primary Hospital" 8 "Awash Malkasa Health Center" 9 "Koka Health Center" 10 "Biyo Health Center" ///
					11 "Ejersa Health Center" 12 "Catholic Church Primary Clinic" 13 "Noh Primary Clinic" 14 "Adama Health Center" 15 "Family Guidance Nazret Specialty Clinic" ///
					16 "Biftu" 17 "Bokushenen" 18 "Adama Teaching Hospital" 19 "Hawas" 20 "Medhanialem Hospital" ///
					21 "Sister Aklisiya Hospital" 22 "Marie stopes Specialty Clinic" 96 "Other, in the zone, Specify" 97 "Other outside of zone, specify" 98 "Don't Know" 99 "NR/RF"
label values m3_503 m3_503					

label define m3_509 1 "High cost (e.g., high out of pocket payment, not covered by insurance)" 2 "Far distance (e.g., too far to walk or drive, transport not readily available)" ///
					3 "Long waiting time (e.g., long line to access facility, long wait for the provider)" 4 "Poor healthcare provider skills (e.g., spent too little time with patient, did not conduct a thorough exam)" ///
					5 "Staff dont show respect (e.g., staff is rude, impolite, dismissive)" 6 "Medicines and equipment are not available (e.g., medicines regularly out of stock, equipment like X-ray machines broken or unavailable)" ///
					7 "Facility not clean and/or comfortable (e.g., dirty, risk of infection)" 8 "Not necessary (e.g., able to receive enough care at home, traditional care)" 9 "COVID-19 fear" 10 "No female provider" ///
					11 "Husband/family did not allow it" 12 "Facility was closed" 13 "Delivered on the way (tried to go)" 96 "Other, specify" 99 "NR/RF" 
label values m3_509 m3_509 

label define m3_512 1 "Government hospital" 2 "Government health center" 3 "Government health post" 4 "NGO or faith-based health facility" 5 "Private hospital" ///
					6 "Private specialty maternity centers" 7 "Private specialty maternity clinics" 8 "Private clinic" ///
					9 "Another private medical facility (including pharmacy, shop, traditional healer)" 97 "Other outside of East Shewa or Adama, specify" 98 "Don't Know" 99 "NR/RF" 
label values m3_512 m3_512

label define m3_513a 1 "Meki Catholic Primary Clinic" 2 "Bote Health Center" 3 "Meki Health Center" 4 "Adami Tulu Health Center" 5 "Bulbula Health Center" 6 "Dubisa Health Center" ///
					 7 "Olenchiti Primary Hospital" 8 "Awash Malkasa Health Center" 9 "Koka Health Center" 10 "Biyo Health Center" 11 "Ejersa Health Center" 12 "Catholic Church Primary Clinic" ///
					 13 "Beza Primary Clinic" 14 "Adama Health Center" 15 "Family Guidance Nazret Specialty Clinic" 16 "Biftu" 17 "Bokushenen" 18 "Adama Teaching Hospital" 19 "Hawas" ///
					 20 "Medhanialem Hospital" 21 "Sister Aklisiya Hospital" 22 "Marie stopes Specialty Clinic" 96 "Other, in the zone, Specify" 97 "Other outside of zone, specify" 98 "Don't Know" 99 "NR/RF" 
label values m3_513a m3_513a 

label define m3_515 1 "The first facility was closed" 2 "Provider referred you to this other facility without checking you" 3 "Provider checked you but referred you to this other facility" ///
					4 "You decided to leave" 5 "A family member decided you should leave" 
label values m3_515 m3_515

label define m3_516 1 "High cost (e.g., high out of pocket payment, not covered by insurance)" 2 "Long waiting time (e.g., long line to access facility, long wait for the provider)" ///
					3 "Poor healthcare provider skills (e.g., spent too little time with patient, did not conduct a thorough exam)" 4 "Staff dont show respect (e.g., staff is rude, impolite, dismissive)" ///
					5 "Medicines and equipment are not available (e.g., medicines regularly out of stock, equipment like X-ray machines broken or unavailable)" ///
					6 "Facility not clean and/or comfortable (e.g., dirty, risk of infection)" 7 "COVID-19 fear" 8 "No female provider" 96 "Other, specify" 99 "NR/RF" 
label values m3_516 m3_516

label define m3_518 0 "The provider did not give a reason" 1 "No space or no bed available" 2 "Facility did not provide delivery care" 3 "Prolonged labor" 4 "Obstructed labor" ///
					5 "Eclampsia/pre-eclampsia" 6 "Previous cesarean section scar" 7 "Fetal distress" 8 "Fetal presentations" 9 "No fetal movement" 10 "Bleeding" ///
					96 "Other delivery complications (specify)" 97 "Other reasons(specify)" 98 "Don't Know" 99 "NR/RF" 
label values m3_518 m3_518

label define m3_519 1 "Low cost of delivery" 2 "Close to home" 3 "Short waiting time or enough HCWs" 4 "Good healthcare provider skills" 5 "Staff are respectful/nice" ///
label define m3_519 1 "Low cost of delivery" 2 "Close to home" 3 "Short waiting time or enough HCWs" 4 "Good healthcare provider skills" 5 "Staff are respectful/nice" ///
					6 "Medicine and equipment available" 7 "Facility is clean and/or comfortable" 8 "I delivered here before" 9 "Low risk of getting COVID-19" ///
					10 "Female providers available" 11 "I was told by family member" 12 "I was told by a health worker" 13 "Familiarity with health worker" ///
					14 "Familiarity with facility" 15 "Emergency care is available if need" 16 "Birth companion can come with me" 96 "Other, specify" 98 "Dont know" 99 "No response" 
label values m3_519 m3_519

label define m3_attempt_outcome 1 "Answered the phone, correct respondent (Start survey)" 2 "Answered but not by the respondent (Go to A4)" ///
								3 "No answer (rings but not response or line was busy)" 4 "Number does not work (does not ring/connect to a phone)" 5 "Phone was switched off" 6 "Rescheduled" 
label values m3_attempt_outcome m3_attempt_outcome

label define m3_p1_complete 0 "Incomplete" 1 "Unverified" 2 "Complete"
label values m3_p1_complete m3_p1_complete

label define m3_status 1 "Alive" 0 "Died"
label values m3_201a m3_201b m3_201c m3_status

label define m3_602a 1 "Yes" 0 "No" 2 "I dont have a maternal health card" 98 "Don't Know" 99 "NR/RF"
label values m3_602a m3_602a

label define m3_604a 1 "My own bed" 2 "A shared bed" 3 "A mattress on the floor" 4 "The floor" 5 "A chair" 6 "I was standing" 98 "Don't Know" 99 "NR/RF"
label values m3_604a m3_604a

label define m3_621a 1 "A relative or a friend" 2 "A traditional birth attendant" 3 "A community health worker" 4 "A nurse" 5 "A midwife" 6 "A doctor" 99 "NR/RF" 
label values m3_621a m3_621a

label define sleeping 1 "Sleeps well" 2 "Slightly affected sleep" 3 "Moderately affected sleep" 4 "Severely disturbed sleep" 
label values m3_baby1_sleep m3_baby2_sleep m3_baby3_sleep sleeping

label define feeding 1 "Normal feeding" 2 "Slight feeding problems" 3 "Moderate feeding problems" 4 "Severe feeding problems" 
label values m3_baby1_feed m3_baby2_feed m3_baby3_feed feeding

label define breathing 1 "Normal breathing" 2 "Slight breathing problems" 3 "Moderate breathing problems" 4 "Severe breathing problems" 
label values m3_baby1_breath m3_baby2_breath m3_baby3_breath

label define stooling 1 "Normal stooling/poo" 2 "Slight stooling/poo problems" 3 "Moderate stooling/poo problems" 4 "Severe stooling/poo problems" 
label values m3_baby1_stool m3_baby2_stool m3_baby3_stool stooling

label define mood 1 "Happy/content" 2 "Fussy/irritable" 3 "Crying" 4 "Inconsolable crying"
label values m3_baby1_mood m3_baby2_mood m3_baby3_mood mood

label define skin 1 "Normal skin" 2 "Dry or red skin" 3 "Irritated or itchy skin" 4 "Bleeding or cracked skin" 
label values m3_baby1_skin m3_baby2_skin m3_baby3_skin skin

label define interactivity 1 "Highly playful/interactive" 2 "Playful/interactive" 3 "Less playful/less interactive" 4 "Low energy/inactive/dull" 
label values m3_baby1_interactivity m3_baby2_interactivity m3_baby3_interactivity interactivity

label define m3_fx 0 "None of the days" 1 "Several days" 2 "More than half the days" 3 "Nearly every day" 98 "Don't Know" 99 "NR/RF" 
label values m3_801a m3_801b m3_fx


*===============================================================================
		
	*STEP THREE: RECODING MISSING VALUES 
		* Recode refused and don't know values
		* Note: .a means NA, .r means refused, .d is don't know, . is missing 
		* Need to figure out a way to clean up string "text" only vars that have numeric entries (ex. 803)

	** MODULE 1:
	recode mobile_phone kebele_malaria kebele_intworm m1_201 m1_202a m1_202b m1_202c m1_202d m1_202e m1_202f m1_202g m1_203_et m1_204 m1_205a m1_205b m1_205c m1_205d m1_205e phq9a phq9b phq9c phq9d phq9e phq9f phq9g phq9h phq9i m1_301 m1_302 m1_303 m1_304 m1_305a m1_305b m1_401 m1_404 m1_405 m1_501 m1_503 m1_504 m1_505 m1_506 m1_507 m1_601 m1_602 m1_605a m1_605b m1_605c m1_605d m1_605e m1_605f m1_605g m1_605h m1_605i_et m1_605j_et m1_605k_et m1_700 m1_701 m1_702 m1_703 m1_704 m1_705 m1_706 m1_707 m1_708a m1_708b m1_708c m1_708d m1_708e m1_708f m1_709a m1_709b m1_710a m1_710b m1_710c m1_711a m1_711b m1_712 m1_713a m1_713b m1_713c m1_713d m1_713e m1_713f m1_713g m1_713h m1_713i m1_714a m1_714b m1_716a m1_716b m1_716c m1_716d m1_716e m1_717 m1_718 m1_719 m1_720 m1_721 m1_722 m1_723 m1_724a m1_724c m1_724d m1_724e m1_724f m1_724g m1_724h m1_724i m1_801 m1_805 m1_806 m1_807 m1_810a m1_810b m1_813a m1_813b m1_813c m1_813d m1_813e m1_8a_et m1_8b_et m1_8c_et m1_8d_et m1_8e_et m1_8f_et m1_8g_et m1_2_8_et m1_814a m1_814b m1_814c m1_814d m1_814e m1_814f m1_814g m1_814h m1_814i m1_816 m1_901 m1_902 m1_903 m1_904 m1_905 m1_907 m1_1004 m1_1005 m1_1006 m1_1_10_et m1_1007 m1_1008 m1_1010 m1_1011a m1_1011b m1_1011c m1_1011d m1_1011e m1_1011f m1_1101 m1_1103 m1_1105 m1_1201 m1_1202 m1_1203 m1_1204 m1_1205 m1_1206 m1_1207 m1_1208 m1_1209 m1_1210 m1_1211 m1_1212 m1_1213 m1_1214 m1_1215 m1_1216 m1_1217 m1_1221 m1_1222 m1_1223 mobile_phone (99 = .r)

	recode m1_401 m1_404 m1_501 m1_506 m1_507 m1_509b m1_510b m1_511 m1_512 m1_700 m1_701 m1_702 m1_703 m1_704 m1_705 m1_706 m1_707 m1_708a m1_708b m1_708c m1_708d m1_708e m1_708f m1_709a m1_709b m1_710a m1_710b m1_710c m1_711a m1_711b m1_712 m1_713a m1_713b m1_713c m1_713d m1_713e m1_713f m1_713g m1_713h m1_713i m1_714a m1_714b m1_716a m1_716b m1_716c m1_716d m1_716e m1_717 m1_718 m1_719 m1_720 m1_721 m1_722 m1_723 m1_724a m1_724c m1_724d m1_724e m1_724f m1_724g m1_724h m1_724i m1_801 m1_803 m1_805 m1_806 m1_807 m1_809 m1_810a m1_810b m1_811 m1_812a m1_813a m1_813b m1_813c m1_813d m1_813e m1_8a_et m1_8b_et m1_8c_et m1_8d_et m1_8e_et m1_8f_et m1_8g_et m1_2_8_et m1_814a m1_814b m1_814c m1_814d m1_814e m1_814f m1_814g m1_814h m1_814i m1_816 m1_901 m1_902 m1_903 m1_904 m1_905 m1_907 m1_1004 m1_1005 m1_1006 m1_1_10_et m1_1007 m1_1008 m1_1010 m1_1011a m1_1011b m1_1011c m1_1011d m1_1011e m1_1011f m1_1101 m1_1105 m1_1201 m1_1202 m1_1203 m1_1204 m1_1205 m1_1206 m1_1207 m1_1208 m1_1209 m1_1210 m1_1211 m1_1212 m1_1213 m1_1214 m1_1215 m1_1216 m1_1218a m1_1218b m1_1218c m1_1218d m1_1218e m1_1218f m1_1221 m1_1223 m1_804 (98 = .d)

	** MODULE 2:
	recode m2_301 m2_203a m2_203b m2_203c m2_203d m2_203e m2_203f m2_203g m2_203h m2_203i m2_204a m2_204b m2_204c m2_204d m2_204e m2_204f m2_204g m2_204h m2_204i m2_205c m2_205d m2_205e m2_205f m2_205g m2_205h m2_205i m2_206 m2_207 m2_208 m2_301 m2_303a m2_303b m2_303c m2_303d m2_303e m2_305 m2_306 m2_308 m2_309 m2_311 m2_312 m2_314 m2_315 m2_317 m2_318 m2_321 m2_401 m2_402 m2_403 m2_404 m2_405 m2_501a m2_501b m2_501c m2_501d m2_501e m2_501f m2_501g m2_502 m2_503a m2_503b m2_503c m2_503d m2_503e m2_503f m2_504 m2_505a m2_505b m2_505c m2_505d m2_505e m2_505f m2_506a m2_506b m2_506c m2_506d m2_507 m2_508a m2_508b_number m2_508c m2_509a m2_509b m2_509c m2_601a m2_601b m2_601c m2_601d m2_601e m2_601f m2_601g m2_601h m2_601i m2_601j m2_601k m2_601l m2_601m m2_601n m2_602a m2_603 m2_604 m2_701 m2_702a m2_702b m2_702c m2_702d m2_702e m2_704 (99 = .r)
	
	recode m2_201 m2_203a m2_203b m2_203c m2_203d m2_203e m2_203f m2_203g m2_203h m2_203i m2_204a m2_204b m2_204c m2_204d m2_204e m2_204f m2_204g m2_204h m2_204i m2_206 m2_207 m2_208 m2_301 m2_303a m2_303b m2_303c m2_303d m2_303e m2_305 m2_306 m2_308 m2_309 m2_311 m2_312 m2_314 m2_315 m2_317 m2_318 m2_321 m2_401 m2_402 m2_403 m2_404 m2_405 m2_501a m2_501b m2_501c m2_501d m2_501e m2_501f m2_501g m2_502 m2_503a m2_503b m2_503c m2_503d m2_503e m2_503f m2_504 m2_505a m2_505b m2_505c m2_505d m2_505e m2_505f m2_506a m2_506b m2_506c m2_506d m2_507 m2_508a m2_508b_number m2_508c m2_509a m2_509b m2_509c m2_601a m2_601b m2_601c m2_601d m2_601e m2_601f m2_601g m2_601h m2_601i m2_601j m2_601k m2_601l m2_601m m2_601n m2_602a m2_603 m2_604 m2_701 m2_702a m2_702b m2_702c m2_702d m2_702e m2_704 kebele_malaria kebele_intworm (98 = .d)

* Recode missing values to NA for questions respondents would not have been asked 
* due to skip patterns

* MODULE 1:
* Kept these recode commands here even though everyone has given permission 
recode care_self (. = .a) if permission == 0
recode enrollage (. = .a) if permission == 0
recode zone_live (. = .a) if enrollage>15 
recode b6anc_first (. = .a) if b5anc== 2
recode b6anc_first_conf (.a = .a) if b5anc== 2
recode continuecare (. = .a) if b6anc_first_conf ==2 
recode flash (. = .a) if mobile_phone == 0 | mobile_phone == 99 | mobile_phone == .
recode phone_number (. = .a) if mobile_phone == 0 | mobile_phone == 99 | mobile_phone == .
recode m1_503 (. = .a) if m1_502 == 0 | m1_502 == .
recode m1_504 (. = .a) if m1_502 == 0 | m1_503 == 1
recode m1_509b (. = .a) if m1_509a == 0
recode m1_510b (. = .a) if m1_510a == 0
recode m1_513b m1_513c (. = .a) if m1_513a_1 == 0 | m1_513a_2 == 1 | ///
	   m1_513a_3 == 1 | m1_513a_4 == 1 | m1_513a_5 == 1 | ///
	   m1_513a_6 == 1 | m1_513a_7 == 1 | m1_513a_8 == 1 

recode m1_513d (. = .a) if m1_513a_2 == 0 | m1_513a_1 == 1 | ///
	   m1_513a_3 == 1 | m1_513a_4 == 1 | m1_513a_5 == 1 | ///
	   m1_513a_6 == 1 | m1_513a_7 == 1 | m1_513a_8 == 1 											 

recode m1_513e (. = .a) if m1_513a_3 == 0 | m1_513a_1 == 1 | ///
	   m1_513a_2 == 1 | m1_513a_4 == 1 | m1_513a_5 == 1 | m1_513a_6 == 1 | ///
	   m1_513a_7 == 1 | m1_513a_8 == 1 
												 
recode m1_513f (. = .a) if m1_513a_4 == 0 | m1_513a_1 == 1 | m1_513a_2 == 1 | ///
	   m1_513a_3 == 1 | m1_513a_5 == 1 | m1_513a_6 == 1 | ///
	   m1_513a_7 == 1 | m1_513a_8 == 1 
												 
recode m1_513g (. = .a) if m1_513a_5 == 0 | m1_513a_1 == 1 | m1_513a_2 == 1 | ///
	   m1_513a_3 == 1 | m1_513a_4 == 1 | m1_513a_6 == 1 | ///
	   m1_513a_7 == 1 | m1_513a_8 == 1 	
												 
recode m1_513h (. = .a) if m1_513a_6 == 0 | m1_513a_1 == 1 | m1_513a_2 == 1 | ///
	   m1_513a_3 == 1 | m1_513a_4 == 1 | m1_513a_5 == 1 | ///
	   m1_513a_7 == 1 | m1_513a_8 == 1 
												 
recode m1_513i (. = .a) if m1_513a_7 == 0 | m1_513a_1 == 1 | m1_513a_2 == 1 | ///
	   m1_513a_3 == 1 | m1_513a_4 == 1 | m1_513a_5 == 1 | ///
	   m1_513a_6 == 1 | m1_513a_8 == 1 												 

recode m1_514a (. = .a) if m1_513a_3 == 1 | m1_513a_4 == 1 | m1_513a_5 == 1 | ///
	   m1_513a_6 == 1 | m1_513a_7 == 1 | m1_513a_8 == 1	

recode m1_708b (. = .a) if m1_708a == 0 | m1_708a == . | m1_708a == .d
recode m1_708c (. = .a) if m1_708b	== 2 | m1_708b == . |	m1_708b == .d | m1_708b == .a 
recode m1_708d (. = .a) if m1_708c	== 0 | m1_708c == . | m1_708c == .d | m1_708c == .a 
recode m1_708e (. = .a) if m1_708b == 2 | m1_708b == . | m1_708b == .d | m1_708b == .a
recode m1_708f (. = .a) if m1_708b == 2 | m1_708b == . | m1_708b == .d | m1_708b == .a

recode m1_710b (. = .a) if m1_710a == 0 | m1_710a == . | m1_710a == .d
recode m1_710c (. = .a) if m1_710b == 2 | m1_710b == .a | m1_710b == .d

recode m1_711b (. = .a) if m1_711a == 0 | m1_711a == . | m1_711a == .d

recode m1_714c (. = .a) if m1_714b == 0 | m1_714b == . | m1_714b == .d | m1_714b == .r

* SS confirm these with Kate
replace m1_714d = ".a" if m1_714b == 0 | m1_714b == . | m1_714b == .d | m1_714b == .r
replace m1_714d = "." if m1_714d == ""
replace m1_714d = ".d" if m1_714d == "Dont know" | m1_714d == "Dont know." | m1_714d == "Dont remember"
replace m1_714d = "0" if m1_714d == "0.08"
replace m1_714d = "1" if m1_714d == "1,10/12"
replace m1_714d = "2.5" if m1_714d == "2 yr 6month"
replace m1_714d = "2.7" if m1_714d == "2yr and 8 month"
replace m1_714d = "3" if m1_714d == "3 years"
replace m1_714d = "0" if m1_714d == "3week"
encode m1_714d, generate(recm1_714d)
recode m1_714e (. = .a) if m1_714c == . | m1_714c == .r

recode m1_718 (. = .a) if m1_202a == 0 | m1_202a == .
recode m1_719 (. = .a) if m1_202b == 0 | m1_202b == .
recode m1_720 (. = .a) if m1_202c == 0 | m1_202c == .
recode m1_721 (. = .a) if m1_202d == 0 | m1_202d == .
recode m1_722 (. = .a) if m1_202e == 0 | m1_202e == .

recode m1_724b (. = .a) if m1_724a == 0 | m1_724a == .
recode m1_724f (. = .a) if m1_705 == 1 | m1_705 == . | m1_705 == .d | m1_705 == .r
recode m1_724g (. = .a) if  m1_707 == 1 | m1_707 == . | m1_707 == .d | m1_707 == .r
recode m1_724h (. = .a) if m1_708a == 1 | m1_708a == . | m1_708a == .d | m1_708a == .r
recode m1_724i (. = .a) if m1_712 == 1 | m1_712 == . | m1_712 == .d | m1_712 == .r

recode m1_804 (. = .a) if (m1_801 == 0 | m1_801 == . | m1_801 == .d | m1_801 == .r) & (m1_802b_et == 0 | m1_802b_et == .) & (m1_803 == .d |  m1_803 == . |  m1_803 == .r) 

recode m1_808_0_et (0 = .a) if m1_804 == 1 | m1_804 == . | m1_804 == .a | m1_804 == .d
recode m1_808_1_et (0 = .a) if m1_804 == 1 | m1_804 == . | m1_804 == .a | m1_804 == .d
recode m1_808_2_et (0 = .a) if m1_804 == 1 | m1_804 == . | m1_804 == .a | m1_804 == .d
recode m1_808_3_et (0 = .a) if m1_804 == 1 | m1_804 == . | m1_804 == .a | m1_804 == .d
recode m1_808_4_et (0 = .a) if m1_804 == 1 | m1_804 == . | m1_804 == .a | m1_804 == .d
recode m1_808_5_et (0 = .a) if m1_804 == 1 | m1_804 == . | m1_804 == .a | m1_804 == .d
recode m1_808_6_et (0 = .a) if m1_804 == 1 | m1_804 == . | m1_804 == .a | m1_804 == .d
recode m1_808_7_et (0 = .a) if m1_804 == 1 | m1_804 == . | m1_804 == .a | m1_804 == .d
recode m1_808_8_et (0 = .a) if m1_804 == 1 | m1_804 == . | m1_804 == .a | m1_804 == .d
recode m1_808_9_et (0 = .a) if m1_804 == 1 | m1_804 == . | m1_804 == .a | m1_804 == .d
recode m1_808_10_et (0 = .a) if m1_804 == 1 | m1_804 == . | m1_804 == .a | m1_804 == .d
recode m1_808_11_et (0 = .a) if m1_804 == 1 | m1_804 == . | m1_804 == .a | m1_804 == .d
recode m1_808_12_et (0 = .a) if m1_804 == 1 | m1_804 == . | m1_804 == .a | m1_804 == .d
recode m1_808_96_et (0 = .a) if m1_804 == 1 | m1_804 == . | m1_804 == .a | m1_804 == .d
recode m1_808_99_et (0 = .a) if m1_804 == 1 | m1_804 == . | m1_804 == .a | m1_804 == .d

* SS: Fix in redcap to add this skip pattern
recode m1_812b_0_et (. = .a) (0 = .a) if m1_812a == 0 | m1_812a ==. | m1_812a == .d 

recode m1_812b_1 (0 = .a) if m1_812b_0_et == 1 | m1_812b_0_et == 98 | m1_812b_0_et == 99
recode m1_812b_1 (0 = .) if m1_812b_0_et == 0

recode m1_812b_2 (0 = .a) if m1_812b_0_et == 1 | m1_812b_0_et == 98 | m1_812b_0_et == 99
recode m1_812b_2 (0 = .) if m1_812b_0_et == 0

recode m1_812b_3 (0 = .a) if m1_812b_0_et == 1 | m1_812b_0_et == 98 | m1_812b_0_et == 99
recode m1_812b_3 (0 = .) if m1_812b_0_et == 0

recode m1_812b_4 (0 = .a) if m1_812b_0_et == 1 | m1_812b_0_et == 98 | m1_812b_0_et == 99
recode m1_812b_4 (0 = .) if m1_812b_0_et == 0

recode m1_812b_5 (0 = .a) if m1_812b_0_et == 1 | m1_812b_0_et == 98 | m1_812b_0_et == 99
recode m1_812b_5 (0 = .) if m1_812b_0_et == 0

recode m1_812b_96 (0 = .a) if m1_812b_0_et == 1 | m1_812b_0_et == 98 | m1_812b_0_et == 99
recode m1_812b_96 (0 = .) if m1_812b_0_et == 0

recode m1_812b_98 (0 = .a) if m1_812b_0_et == 1 | m1_812b_0_et == 98 | m1_812b_0_et == 99
recode m1_812b_98 (0 = .) if m1_812b_0_et == 0

recode m1_812b_99 (0 = .a) if m1_812b_0_et == 1 | m1_812b_0_et == 98 | m1_812b_0_et == 99
recode m1_812b_99 (0 = .) if m1_812b_0_et == 0

recode m1_812b_998_et (0 = .a) if m1_812b_0_et == 1 | m1_812b_0_et == 98 | m1_812b_0_et == 99
recode m1_812b_998_et (0 = .) if m1_812b_0_et == 0

recode m1_812b_999_et (0 = .a) if m1_812b_0_et == 1 | m1_812b_0_et == 98 | m1_812b_0_et == 99
recode m1_812b_999_et (0 = .) if m1_812b_0_et == 0

recode m1_812b_888_et (0 = .a) if m1_812b_0_et == 1 | m1_812b_0_et == 98 | m1_812b_0_et == 99
recode m1_812b_888_et (0 = .) if m1_812b_0_et == 0

replace m1_812b_other = ".a" if m1_812b_96 !=1

recode m1_813e (. = .a) if (m1_813a == 0 | m1_813a == .d | m1_813a == .r) & (m1_813b == 0 | ///
	   m1_813b == .d | m1_813b == .r) & (m1_813c == 0 | m1_813c == .d | m1_813c == .r) & ///
	   (m1_813d == 0 | m1_813d == .d | m1_813d == .r)

recode m1_2_8_et (. = .a) if (m1_8a_et == 0 | m1_8a_et == .d | m1_8a_et == .r) & ///
	   (m1_8b_et == 0 | m1_8b_et == .d | m1_8b_et == .r) & ///
	   (m1_8c_et == 0 | m1_8c_et == .d | m1_8c_et == .r) & ///
	   (m1_8d_et == 0 | m1_8d_et == .d | m1_8d_et == .r) & ///
	   (m1_8e_et == 0 | m1_8e_et == .d | m1_8e_et == .r) & ///
	   (m1_8f_et == 0 | m1_8f_et == .d | m1_8f_et == .r) & ///
	   (m1_8g_et == 0 | m1_8g_et == .d | m1_8g_et == .r)

recode m1_814h (. = .a) if m1_804 == 1	| m1_804 == 2 | m1_804 == . | m1_804 == .a | m1_804 == .d								   			   
recode m1_815_0 (0 = .a) if (m1_814a == 0 | m1_814a == .d | m1_814a == .r | m1_814a == .) & ///
													(m1_814b == 0 | m1_814b == .d | m1_814b == .r | m1_814b == .) & ///
													(m1_814c == 0 | m1_814c == .d | m1_814c == .r | m1_814c == .) & ///
													(m1_814d == 0 | m1_814d == .d | m1_814d == .r | m1_814d == .) & ///
													(m1_814e == 0 | m1_814e == .d | m1_814e == .r | m1_814e == .) & ///
													(m1_814f == 0 | m1_814f == .d | m1_814f == .r | m1_814f == .) & ///
													(m1_814g == 0 | m1_814g == .d | m1_814g == .r | m1_814g == .) & ///
													(m1_814h == 0 | m1_814h == .d | m1_814h == .r | m1_814h == . | m1_814h == .a) & ///
													(m1_814i == 0 | m1_814i == .d | m1_814i == .r | m1_814i == .)
   							   
recode m1_815_0 (0 = .) if m1_814a == 1 | m1_814b ==1 | m1_814c == 1 | m1_814d == 1 | ///
												   m1_814e == 1 | m1_814f == 1 | m1_814g == 1 | m1_814h == 1 | ///
												   m1_814i == 1
													
recode m1_815_1 (0 = .a) if (m1_814a == 0 | m1_814a == .d | m1_814a == .r | m1_814a == .) & ///
						(m1_814b == 0 | m1_814b == .d | m1_814b == .r | m1_814b == .) & ///
						(m1_814c == 0 | m1_814c == .d | m1_814c == .r | m1_814c == .) & ///
						(m1_814d == 0 | m1_814d == .d | m1_814d == .r | m1_814d == .) & ///
						(m1_814e == 0 | m1_814e == .d | m1_814e == .r | m1_814e == .) & ///
						(m1_814f == 0 | m1_814f == .d | m1_814f == .r | m1_814f == .) & ///
						(m1_814g == 0 | m1_814g == .d | m1_814g == .r | m1_814g == .) & ///
						(m1_814h == 0 | m1_814h == .d | m1_814h == .r | m1_814h == . | m1_814h == .a) & ///
						(m1_814i == 0 | m1_814i == .d | m1_814i == .r | m1_814i == .)
													
recode m1_815_1 (0 = .) if m1_814a == 1 | m1_814b ==1 | m1_814c == 1 | m1_814d == 1 | ///
					   m1_814e == 1 | m1_814f == 1 | m1_814g == 1 | m1_814h == 1 | ///
					   m1_814i == 1
													
recode m1_815_2 (0 = .a) if (m1_814a == 0 | m1_814a == .d | m1_814a == .r | m1_814a == .) & ///
						(m1_814b == 0 | m1_814b == .d | m1_814b == .r | m1_814b == .) & ///
						(m1_814c == 0 | m1_814c == .d | m1_814c == .r | m1_814c == .) & ///
						(m1_814d == 0 | m1_814d == .d | m1_814d == .r | m1_814d == .) & ///
						(m1_814e == 0 | m1_814e == .d | m1_814e == .r | m1_814e == .) & ///
						(m1_814f == 0 | m1_814f == .d | m1_814f == .r | m1_814f == .) & ///
						(m1_814g == 0 | m1_814g == .d | m1_814g == .r | m1_814g == .) & ///
						(m1_814h == 0 | m1_814h == .d | m1_814h == .r | m1_814h == . | m1_814h == .a) & ///
						(m1_814i == 0 | m1_814i == .d | m1_814i == .r | m1_814i == .)
													
recode m1_815_2 (0 = .) if m1_814a == 1 | m1_814b ==1 | m1_814c == 1 | m1_814d == 1 | ///
					   m1_814e == 1 | m1_814f == 1 | m1_814g == 1 | m1_814h == 1 | ///
					   m1_814i == 1
													
recode m1_815_3 (0 = .a) if (m1_814a == 0 | m1_814a == .d | m1_814a == .r | m1_814a == .) & ///
						(m1_814b == 0 | m1_814b == .d | m1_814b == .r | m1_814b == .) & ///
						(m1_814c == 0 | m1_814c == .d | m1_814c == .r | m1_814c == .) & ///
						(m1_814d == 0 | m1_814d == .d | m1_814d == .r | m1_814d == .) & ///
						(m1_814e == 0 | m1_814e == .d | m1_814e == .r | m1_814e == .) & ///
						(m1_814f == 0 | m1_814f == .d | m1_814f == .r | m1_814f == .) & ///
						(m1_814g == 0 | m1_814g == .d | m1_814g == .r | m1_814g == .) & ///
						(m1_814h == 0 | m1_814h == .d | m1_814h == .r | m1_814h == . | m1_814h == .a) & ///
						(m1_814i == 0 | m1_814i == .d | m1_814i == .r | m1_814i == .)
													
recode m1_815_3 (0 = .) if m1_814a == 1 | m1_814b ==1 | m1_814c == 1 | m1_814d == 1 | ///
					   m1_814e == 1 | m1_814f == 1 | m1_814g == 1 | m1_814h == 1 | ///
					   m1_814i == 1
													
recode m1_815_4 (0 = .a) if (m1_814a == 0 | m1_814a == .d | m1_814a == .r | m1_814a == .) & ///
						(m1_814b == 0 | m1_814b == .d | m1_814b == .r | m1_814b == .) & ///
						(m1_814c == 0 | m1_814c == .d | m1_814c == .r | m1_814c == .) & ///
						(m1_814d == 0 | m1_814d == .d | m1_814d == .r | m1_814d == .) & ///
						(m1_814e == 0 | m1_814e == .d | m1_814e == .r | m1_814e == .) & ///
						(m1_814f == 0 | m1_814f == .d | m1_814f == .r | m1_814f == .) & ///
						(m1_814g == 0 | m1_814g == .d | m1_814g == .r | m1_814g == .) & ///
						(m1_814h == 0 | m1_814h == .d | m1_814h == .r | m1_814h == . | m1_814h == .a) & ///
						(m1_814i == 0 | m1_814i == .d | m1_814i == .r | m1_814i == .)
													
recode m1_815_4 (0 = .) if m1_814a == 1 | m1_814b ==1 | m1_814c == 1 | m1_814d == 1 | ///
					   m1_814e == 1 | m1_814f == 1 | m1_814g == 1 | m1_814h == 1 | ///
					   m1_814i == 1
													
recode m1_815_5 (0 = .a) if (m1_814a == 0 | m1_814a == .d | m1_814a == .r | m1_814a == .) & ///
						(m1_814b == 0 | m1_814b == .d | m1_814b == .r | m1_814b == .) & ///
						(m1_814c == 0 | m1_814c == .d | m1_814c == .r | m1_814c == .) & ///
						(m1_814d == 0 | m1_814d == .d | m1_814d == .r | m1_814d == .) & ///
						(m1_814e == 0 | m1_814e == .d | m1_814e == .r | m1_814e == .) & ///
						(m1_814f == 0 | m1_814f == .d | m1_814f == .r | m1_814f == .) & ///
						(m1_814g == 0 | m1_814g == .d | m1_814g == .r | m1_814g == .) & ///
						(m1_814h == 0 | m1_814h == .d | m1_814h == .r | m1_814h == . | m1_814h == .a) & ///
						(m1_814i == 0 | m1_814i == .d | m1_814i == .r | m1_814i == .)
													
recode m1_815_5 (0 = .) if m1_814a == 1 | m1_814b ==1 | m1_814c == 1 | m1_814d == 1 | ///
					   m1_814e == 1 | m1_814f == 1 | m1_814g == 1 | m1_814h == 1 | ///
					   m1_814i == 1	

recode m1_815_6 (0 = .a) if (m1_814a == 0 | m1_814a == .d | m1_814a == .r | m1_814a == .) & ///
						(m1_814b == 0 | m1_814b == .d | m1_814b == .r | m1_814b == .) & ///
						(m1_814c == 0 | m1_814c == .d | m1_814c == .r | m1_814c == .) & ///
						(m1_814d == 0 | m1_814d == .d | m1_814d == .r | m1_814d == .) & ///
						(m1_814e == 0 | m1_814e == .d | m1_814e == .r | m1_814e == .) & ///
						(m1_814f == 0 | m1_814f == .d | m1_814f == .r | m1_814f == .) & ///
						(m1_814g == 0 | m1_814g == .d | m1_814g == .r | m1_814g == .) & ///
						(m1_814h == 0 | m1_814h == .d | m1_814h == .r | m1_814h == . | m1_814h == .a) & ///
						(m1_814i == 0 | m1_814i == .d | m1_814i == .r | m1_814i == .)
													
recode m1_815_6 (0 = .) if m1_814a == 1 | m1_814b ==1 | m1_814c == 1 | m1_814d == 1 | ///
					   m1_814e == 1 | m1_814f == 1 | m1_814g == 1 | m1_814h == 1 | ///
					   m1_814i == 1	
													
recode m1_815_7 (0 = .a) if (m1_814a == 0 | m1_814a == .d | m1_814a == .r | m1_814a == .) & ///
						(m1_814b == 0 | m1_814b == .d | m1_814b == .r | m1_814b == .) & ///
						(m1_814c == 0 | m1_814c == .d | m1_814c == .r | m1_814c == .) & ///
						(m1_814d == 0 | m1_814d == .d | m1_814d == .r | m1_814d == .) & ///
						(m1_814e == 0 | m1_814e == .d | m1_814e == .r | m1_814e == .) & ///
						(m1_814f == 0 | m1_814f == .d | m1_814f == .r | m1_814f == .) & ///
						(m1_814g == 0 | m1_814g == .d | m1_814g == .r | m1_814g == .) & ///
						(m1_814h == 0 | m1_814h == .d | m1_814h == .r | m1_814h == . | m1_814h == .a) & ///
						(m1_814i == 0 | m1_814i == .d | m1_814i == .r | m1_814i == .)
													
recode m1_815_7 (0 = .) if m1_814a == 1 | m1_814b ==1 | m1_814c == 1 | m1_814d == 1 | ///
					   m1_814e == 1 | m1_814f == 1 | m1_814g == 1 | m1_814h == 1 | ///
					   m1_814i == 1	
													
recode m1_815_96 (0 = .a) if (m1_814a == 0 | m1_814a == .d | m1_814a == .r | m1_814a == .) & ///
						(m1_814b == 0 | m1_814b == .d | m1_814b == .r | m1_814b == .) & ///
						(m1_814c == 0 | m1_814c == .d | m1_814c == .r | m1_814c == .) & ///
						(m1_814d == 0 | m1_814d == .d | m1_814d == .r | m1_814d == .) & ///
						(m1_814e == 0 | m1_814e == .d | m1_814e == .r | m1_814e == .) & ///
						(m1_814f == 0 | m1_814f == .d | m1_814f == .r | m1_814f == .) & ///
						(m1_814g == 0 | m1_814g == .d | m1_814g == .r | m1_814g == .) & ///
						(m1_814h == 0 | m1_814h == .d | m1_814h == .r | m1_814h == . | m1_814h == .a) & ///
						(m1_814i == 0 | m1_814i == .d | m1_814i == .r | m1_814i == .)
													
recode m1_815_96 (0 = .) if m1_814a == 1 | m1_814b ==1 | m1_814c == 1 | m1_814d == 1 | ///
					   m1_814e == 1 | m1_814f == 1 | m1_814g == 1 | m1_814h == 1 | ///
					   m1_814i == 1	

recode m1_815_98 (0 = .d) if (m1_814a == 0 | m1_814a == .d | m1_814a == .r | m1_814a == .) & ///
						(m1_814b == 0 | m1_814b == .d | m1_814b == .r | m1_814b == .) & ///
						(m1_814c == 0 | m1_814c == .d | m1_814c == .r | m1_814c == .) & ///
						(m1_814d == 0 | m1_814d == .d | m1_814d == .r | m1_814d == .) & ///
						(m1_814e == 0 | m1_814e == .d | m1_814e == .r | m1_814e == .) & ///
						(m1_814f == 0 | m1_814f == .d | m1_814f == .r | m1_814f == .) & ///
						(m1_814g == 0 | m1_814g == .d | m1_814g == .r | m1_814g == .) & ///
						(m1_814h == 0 | m1_814h == .d | m1_814h == .r | m1_814h == . | m1_814h == .a) & ///
						(m1_814i == 0 | m1_814i == .d | m1_814i == .r | m1_814i == .)
													
recode m1_815_98 (0 = .) if m1_814a == 1 | m1_814b ==1 | m1_814c == 1 | m1_814d == 1 | ///
					   m1_814e == 1 | m1_814f == 1 | m1_814g == 1 | m1_814h == 1 | ///
					   m1_814i == 1	

recode m1_815_99 (0 = .r) if (m1_814a == 0 | m1_814a == .d | m1_814a == .r | m1_814a == .) & ///
						(m1_814b == 0 | m1_814b == .d | m1_814b == .r | m1_814b == .) & ///
						(m1_814c == 0 | m1_814c == .d | m1_814c == .r | m1_814c == .) & ///
						(m1_814d == 0 | m1_814d == .d | m1_814d == .r | m1_814d == .) & ///
						(m1_814e == 0 | m1_814e == .d | m1_814e == .r | m1_814e == .) & ///
						(m1_814f == 0 | m1_814f == .d | m1_814f == .r | m1_814f == .) & ///
						(m1_814g == 0 | m1_814g == .d | m1_814g == .r | m1_814g == .) & ///
						(m1_814h == 0 | m1_814h == .d | m1_814h == .r | m1_814h == . | m1_814h == .a) & ///
						(m1_814i == 0 | m1_814i == .d | m1_814i == .r | m1_814i == .)
													
recode m1_815_99(0 = .) if m1_814a == 1 | m1_814b ==1 | m1_814c == 1 | m1_814d == 1 | ///
					   m1_814e == 1 | m1_814f == 1 | m1_814g == 1 | m1_814h == 1 | ///
					   m1_814i == 1

* SS: confirm why 814h "and"				
recode m1_816 (. = .a) if (m1_814a == 1 | m1_814b ==1 | m1_814c == 1 | m1_814d == 1 | ///
									m1_814e == 1 | m1_814f == 1 | m1_814g == 1 | m1_814i == 1) & ///
									(m1_814h == 1 | m1_814h == .a | m1_814h == .)
									
recode m1_902 (. = .a) if m1_901 == 3 | m1_901 == .d | m1_901 == .r | m1_901 == .

recode m1_904 (. = .a) if m1_903 == 3 | m1_903 == .d | m1_903 == .r | m1_903 == .

recode m1_907 (. = .a) if m1_905 == 0 | m1_905 == . | m1_905 == .d | m1_905 == .r
					
recode m1_1002 (. = .a) if m1_1001 <= 1 | m1_1001 == .	

recode m1_1003 (. = .a) if m1_1002 <1 | m1_1002 == . | m1_1002 == .a	

recode m1_1004 (. = .a) if m1_1001 <= m1_1002

recode m1_1005 (. = .a) if (m1_1002<1 | m1_1002 ==.a | m1_1002 ==.)

recode m1_1006  (. = .a) if (m1_1002<1 | m1_1002 ==.a | m1_1002 ==.)

recode m1_1_10_et (. = .a) if (m1_1002<1 | m1_1002 ==.a | m1_1002 ==.)

recode m1_1007 (. = .a) if (m1_1002<1 | m1_1002 ==.a | m1_1002 ==.)

recode m1_1008 (. = .a) if (m1_1002<1 | m1_1002 ==.a | m1_1002 ==.)

recode m1_1009 (. = .a) if (m1_1003 <1 | m1_1003 == .a | m1_1003 == .)

recode m1_1010 (. = .a) if (m1_1003 <= m1_1009) | m1_1003 == .a 

recode m1_1011a (. = .a) if (m1_1001 <= 1 | m1_1001 ==.)

recode m1_1011b (. = .a) if m1_1004 == 0 | m1_1004 == . | m1_1004 == .a

recode m1_1011c (. = .a) if (m1_1002 <= m1_1003)	

recode m1_1011d (. = .a) if	m1_1005 == 0 | m1_1005 == . | m1_1005 == .a

recode m1_1011e (. = .a) if m1_1007 == 0 | m1_1007 == . | m1_1007 == .a

recode m1_1011f (. = .a) if m1_1010 == 0 | m1_1010 == . | m1_1010 == .a

recode m1_1102_1 (0 = .a) if m1_1101 == 0 | m1_1101 == . | m1_1101 == .r
recode m1_1102_1 (0 = .) if m1_1101 == 1
recode m1_1102_2 (0 = .a) if m1_1101 == 0 | m1_1101 == . | m1_1101 == .r
recode m1_1102_2 (0 = .) if m1_1101 == 1
recode m1_1102_3 (0 = .a) if m1_1101 == 0 | m1_1101 == . | m1_1101 == .r
recode m1_1102_3 (0 = .) if m1_1101 == 1
recode m1_1102_4 (0 = .a) if m1_1101 == 0 | m1_1101 == . | m1_1101 == .r
recode m1_1102_4 (0 = .) if m1_1101 == 1
recode m1_1102_5 (0 = .a) if m1_1101 == 0 | m1_1101 == . | m1_1101 == .r
recode m1_1102_5 (0 = .) if m1_1101 == 1
recode m1_1102_6 (0 = .a) if m1_1101 == 0 | m1_1101 == . | m1_1101 == .r
recode m1_1102_6 (0 = .) if m1_1101 == 1
recode m1_1102_7 (0 = .a) if m1_1101 == 0 | m1_1101 == . | m1_1101 == .r
recode m1_1102_7 (0 = .) if m1_1101 == 1
recode m1_1102_8 (0 = .a) if m1_1101 == 0 | m1_1101 == . | m1_1101 == .r
recode m1_1102_8 (0 = .) if m1_1101 == 1
recode m1_1102_9 (0 = .a) if m1_1101 == 0 | m1_1101 == . | m1_1101 == .r
recode m1_1102_9 (0 = .) if m1_1101 == 1
recode m1_1102_10 (0 = .a) if m1_1101 == 0 | m1_1101 == . | m1_1101 == .r
recode m1_1102_10 (0 = .) if m1_1101 == 1
recode m1_1102_96 (0 = .a) if m1_1101 == 0 | m1_1101 == . | m1_1101 == .r
recode m1_1102_96 (0 = .) if m1_1101 == 1
recode m1_1102_98 (0 = .a) if m1_1101 == 0 | m1_1101 == . | m1_1101 == .r
recode m1_1102_98 (0 = .) if m1_1101 == 1
recode m1_1102_99 (0 = .a) if m1_1101 == 0 | m1_1101 == . | m1_1101 == .r
recode m1_1102_99 (0 = .) if m1_1101 == 1

recode m1_1104_1 (0 = .a) if m1_1103 == 0 | m1_1103 == . | m1_1103 == .r
recode m1_1104_1 (0 = .) if m1_1103 == 1
recode m1_1104_2 (0 = .a) if m1_1103 == 0 | m1_1103 == . | m1_1103 == .r
recode m1_1104_2 (0 = .) if m1_1103 == 1
recode m1_1104_3 (0 = .a) if m1_1103 == 0 | m1_1103 == . | m1_1103 == .r
recode m1_1104_3 (0 = .) if m1_1103 == 1
recode m1_1104_4 (0 = .a) if m1_1103 == 0 | m1_1103 == . | m1_1103 == .r
recode m1_1104_4 (0 = .) if m1_1103 == 1
recode m1_1104_5 (0 = .a) if m1_1103 == 0 | m1_1103 == . | m1_1103 == .r
recode m1_1104_5 (0 = .) if m1_1103 == 1
recode m1_1104_6 (0 = .a) if m1_1103 == 0 | m1_1103 == . | m1_1103 == .r
recode m1_1104_6 (0 = .) if m1_1103 == 1
recode m1_1104_7 (0 = .a) if m1_1103 == 0 | m1_1103 == . | m1_1103 == .r
recode m1_1104_7 (0 = .) if m1_1103 == 1
recode m1_1104_8 (0 = .a) if m1_1103 == 0 | m1_1103 == . | m1_1103 == .r
recode m1_1104_8 (0 = .) if m1_1103 == 1
recode m1_1104_9 (0 = .a) if m1_1103 == 0 | m1_1103 == . | m1_1103 == .r
recode m1_1104_9 (0 = .) if m1_1103 == 1
recode m1_1104_10 (0 = .a) if m1_1103 == 0 | m1_1103 == . | m1_1103 == .r
recode m1_1104_10 (0 = .) if m1_1103 == 1
recode m1_1104_96 (0 = .a) if m1_1103 == 0 | m1_1103 == . | m1_1103 == .r
recode m1_1104_96 (0 = .) if m1_1103 == 1
recode m1_1104_98 (0 = .a) if m1_1103 == 0 | m1_1103 == . | m1_1103 == .r
recode m1_1104_98 (0 = .) if m1_1103 == 1
recode m1_1104_99 (0 = .a) if m1_1103 == 0 | m1_1103 == . | m1_1103 == .r
recode m1_1104_99 (0 = .) if m1_1103 == 1

recode m1_1105 (. = .a) if (m1_1101 == 0 | m1_1101 == . | m1_1101 == .r) & (m1_1103 == 0 | m1_1103 == . | m1_1103 == .r)

recode m1_1218a (. = .a) if m1_1217 == 0 | m1_1217 == . | m1_1217 == .r
recode m1_1218a_1 (. = .a) if m1_1218a == 0 | m1_1218a == .a

replace m1_1218b_1 = ".a" if m1_1218b == 0 | m1_1218b == .a 
replace m1_1218b_1 = "." if m1_1218b_1=="Unknown"
destring m1_1218b_1, replace

recode m1_1218b (. = .a) if m1_1217 == 0 | m1_1217 == . | m1_1217 == .r
recode m1_1218b_1 (. = .a) if m1_1218b == 0 | m1_1218b == .a

recode m1_1218c (. = .a) if m1_1217 == 0 | m1_1217 == . | m1_1217 == .r
recode m1_1218c_1 (. = .a) if m1_1218c == 0 | m1_1218c == .a

recode m1_1218d (. = .a) if m1_1217 == 0 | m1_1217 == . | m1_1217 == .r
recode m1_1218d_1 (. = .a) if m1_1218d == 0 | m1_1218d == .a

recode m1_1218e (. = .a) if m1_1217 == 0 | m1_1217 == . | m1_1217 == .r
recode m1_1218e_1 (. = .a) if m1_1218e == 0 | m1_1218e == .a

recode m1_1218f (. = .a) if m1_1217 == 0 | m1_1217 == . | m1_1217 == .r
recode m1_1218f_1 (. = .a) if m1_1218f == 0 | m1_1218f == .a

recode m1_1219 (. = .a) if m1_1218a_1 == .a & m1_1218b_1 == . & m1_1218c_1 ==.a & ///
						   m1_1218d_1 == .a & m1_1218e_1 == .a & m1_1218f_1 == .a
    
recode m1_1220_1 (0 = .a) if m1_1217 == 0 | m1_1217 == . | m1_1217 == .r
recode m1_1220_1 (0 = .) if m1_1217 == 1
recode m1_1220_2 (0 = .a) if m1_1217 == 0 | m1_1217 == . | m1_1217 == .r
recode m1_1220_2 (0 = .) if m1_1217 == 1
recode m1_1220_3 (0 = .a) if m1_1217 == 0 | m1_1217 == . | m1_1217 == .r
recode m1_1220_3 (0 = .) if m1_1217 == 1
recode m1_1220_4 (0 = .a) if m1_1217 == 0 | m1_1217 == . | m1_1217 == .r
recode m1_1220_4 (0 = .) if m1_1217 == 1
recode m1_1220_5 (0 = .a) if m1_1217 == 0 | m1_1217 == . | m1_1217 == .r
recode m1_1220_5 (0 = .) if m1_1217 == 1
recode m1_1220_6 (0 = .a) if m1_1217 == 0 | m1_1217 == . | m1_1217 == .r
recode m1_1220_6 (0 = .) if m1_1217 == 1
recode m1_1220_96 (0 = .a) if m1_1217 == 0 | m1_1217 == . | m1_1217 == .r
recode m1_1220_96 (0 = .) if m1_1217 == 1

recode m1_1222 (. = .a) if m1_1221 == 0 | m1_1221 == .

replace m1_1307 = ".a" if m1_1306 == 0 | m1_1306 == 96 | m1_1306 == .
replace m1_1307 = "." if m1_1307 == ""
replace m1_1307 = "12.6" if m1_1307 == "12.6g/d"
replace m1_1307 = "12.6" if m1_1307 == "12.6g/dl"
replace m1_1307 = "13" if m1_1307 == "13g/dl"
replace m1_1307 = "14" if m1_1307 == "14."
replace m1_1307 = "14.6" if m1_1307 == "14.6g/dl"
replace m1_1307 = "15" if m1_1307 == "15g/dl"
replace m1_1307 = "16.3" if m1_1307 == "16.3g/dl"
replace m1_1307 = "16.6" if m1_1307 == "16.6g/dl"
replace m1_1307 = "16" if m1_1307 == "16g/dl"
replace m1_1307 = "17.6" if m1_1307 == "17.6g/dl"
replace m1_1307 ="11.3" if m1_1307 == "113"
destring m1_1307, replace

recode m1_1308 (. = .a) if m1_1306 == 1 | m1_1306 == 96 | m1_1306 == .

recode m1_1309 (. = .a) if m1_1308 == 0 | m1_1308 == . | m1_1308 == .a

	** MODULE 2:
recode m2_attempt_relationship (. = .a) if m2_attempt_outcome == 1 | m2_attempt_outcome == 3 | m2_attempt_outcome == 4 | m2_attempt_outcome == 5

recode m2_attempt_avail (. = .a) if m2_attempt_relationship == 4 | m2_attempt_relationship == . | m2_attempt_relationship == .a

recode m2_attempt_contact (. = .a) if m2_attempt_avail == 0 | m2_attempt_avail == . | m2_attempt_avail == .a

recode m2_start (. = .a) if m2_attempt_outcome == 2 |  m2_attempt_outcome == 3 | m2_attempt_outcome == 4 | m2_attempt_outcome == 5 | m2_attempt_avail == 0

recode m2_permission (. = .a) if m2_start == 0
recode maternal_death_reported (. = .a) if m2_permission==0

recode m2_hiv_status (. = .a) if maternal_death_reported == 1 | m1_708b == 1

* SS: Fix in redcap? error says recode only allows numeric vars but it works below
* recode date_of_maternal_death (. = .a) if maternal_death_reported == 0 | ///
										  *maternal_death_reported == . | ///
										  *maternal_death_reported == .a

recode m2_maternal_death_learn (. = .a) if maternal_death_reported == 0

recode m2_maternal_death_learn_other (. = .a) if m2_maternal_death_learn == 1 | m2_maternal_death_learn == 2 | m2_maternal_death_learn == 3 | m2_maternal_death_learn == 4

recode m2_201 m2_202 (. = .a) if maternal_death_reported == 2 | maternal_death_reported == 3

* SS: fix
recode m2_date_of_maternal_death_2 (. = .a) if maternal_death_reported == 0 | ///
											maternal_death_reported == . | ///
											maternal_death_reported == .a

recode m2_203a m2_203b m2_203c m2_203d m2_203e ///
	   m2_203f m2_203g m2_203h m2_203i m2_204a ///
	   m2_204b m2_204c m2_204d m2_204e m2_204f ///
	   m2_204g m2_204h m2_204i m2_205a m2_205b ///
	   m2_205c m2_205d m2_205e m2_205f m2_205g ///
	   m2_205h m2_205i m2_206 m2_207 m2_208 m2_301 (. = .a) if m2_202 == 0

recode m2_302 (. = .a) if m2_301 == 0 | m2_301 == 98 | m2_301 == 99 | m2_301 == . | m2_301 == .a

recode m2_303a (. = .a) if m2_302 == . | m2_302 == .a

recode m2_303b (. = .a) if m2_302 == . | m2_302 == 1 |  m2_302 == .a

recode m2_303c (. = .a) if m2_302 == . | m2_302 == 1 | m2_302 == 2 | m2_302 == .a

recode m2_303d (. = .a) if m2_302 == . | m2_302 == 1 | m2_302 == 2 | m2_302 == 3 | m2_302 == .a

recode m2_303e (. = .a) if m2_302 == . | m2_302 == 1 | m2_302 == 2 | m2_302 == 3 | m2_302 == 4 | m2_302 == .a

recode m2_304a (. = .a) if m2_303a == 1 | m2_303a == 2 | m2_302 == . | m2_302 == .a

recode m2_304b (. = .a) if m2_303b == 1 | m2_303b == 2 | m2_302 == . | m2_302 == 1 | m2_302 == .a

recode m2_304c (. = .a) if m2_302 == . | m2_302 == 1 | m2_302 ==2  | m2_303c == 1 | m2_303c == 2 | m2_302 == .a

recode m2_304d (. = .a) if m2_302 == . | m2_302 == 1 | m2_302 == 2 | m2_302 == 3 | m2_303d == 1 | m2_303d == 2 | m2_302 == .a

recode m2_304e (. = .a) if m2_302 == . | m2_302 == 1 | m2_302 == 2 | m2_302 == 3  | m2_302 == 4 | m2_303e == 1 | m2_303e == 2 | m2_302 == .a

recode m2_305 (. = .a) if m2_302 == . | m2_302 == .a

recode m2_306 (. = .a) if m2_305 == 1 | m2_305 == 98 | m2_305 == 99

recode m2_306_1 (0 = .a) if m2_306 == 1 | m2_306 == 98 | m2_306 == 99
recode m2_306_1 (0 = .) if m2_306 == 0

recode m2_306_2 (0 = .a) if m2_306 == 1 | m2_306 == 98 | m2_306 == 99
recode m2_306_2 (0 = .) if m2_306 == 0

recode m2_306_3 (0 = .a) if m2_306 == 1 | m2_306 == 98 | m2_306 == 99
recode m2_306_3 (0 = .) if m2_306 == 0

recode m2_306_4 (0 = .a) if m2_306 == 1 | m2_306 == 98 | m2_306 == 99
recode m2_306_4 (0 = .) if m2_306 == 0

recode m2_306_5 (0 = .a) if m2_306 == 1 | m2_306 == 98 | m2_306 == 99
recode m2_306_5 (0 = .) if m2_306 == 0

recode m2_306_96 (0 = .a) if m2_306 == 1 | m2_306 == 98 | m2_306 == 99
recode m2_306_96 (0 = .) if m2_306 == 0

replace m2_307_other = ".a" if m2_306_96 ==1

recode m2_308 (. = .a) if m2_302 == 1 | m2_302 == . | m2_302 == .a

recode m2_309 (. = .a) if m2_308 == 1 | m2_308 == 98 | m2_308 == 99

recode m2_308_1 (0 = .a) if m2_306 == 1 | m2_306 == 98 | m2_306 == 99
recode m2_308_1 (0 = .) if m2_306 == 0

recode m2_308_2 (0 = .a) if m2_309 == 1 | m2_309 == 98 | m2_309 == 99
recode m2_308_2 (0 = .) if m2_309 == 0

recode m2_308_3 (0 = .a) if m2_309 == 1 | m2_309 == 98 | m2_309 == 99
recode m2_308_3 (0 = .) if m2_309 == 0

recode m2_308_4 (0 = .a) if m2_309 == 1 | m2_309 == 98 | m2_309 == 99
recode m2_308_4 (0 = .) if m2_309 == 0

recode m2_308_5 (0 = .a) if m2_309 == 1 | m2_309 == 98 | m2_309 == 99
recode m2_308_5 (0 = .) if m2_309 == 0

recode m2_308_96 (0 = .a) if m2_309 == 1 | m2_309 == 98 | m2_309 == 99
recode m2_308_96 (0 = .) if m2_309 == 0

replace m2_310_other = ".a" if m2_308_96 ==1

recode m2_311 (. = .a) if m2_302 == 1 | m2_302 == . | m2_302 == .a | m2_302 == 2

recode m2_312 (. = .a) if m2_311 == 1 | m2_311 == 98 | m2_311 == 99

recode m2_311_1 (0 = .a) if m2_312 == 1 | m2_312 == 98 | m2_312 == 99
recode m2_311_1 (0 = .) if m2_312 == 0

recode m2_311_2 (0 = .a) if m2_312 == 1 | m2_312 == 98 | m2_312 == 99
recode m2_311_2 (0 = .) if m2_312 == 0

recode m2_311_3 (0 = .a) if m2_312 == 1 | m2_312 == 98 | m2_312 == 99
recode m2_311_3 (0 = .) if m2_312 == 0

recode m2_311_4 (0 = .a) if m2_312 == 1 | m2_312 == 98 | m2_312 == 99
recode m2_311_4 (0 = .) if m2_312 == 0

recode m2_311_5 (0 = .a) if m2_312 == 1 | m2_312 == 98 | m2_312 == 99
recode m2_311_5 (0 = .) if m2_312 == 0

recode m2_311_96 (0 = .a) if m2_312 == 1 | m2_312 == 98 | m2_312 == 99
recode m2_311_96 (0 = .) if m2_312 == 0

replace m2_313_other = ".a" if m2_311_96 ==1

recode m2_314 (. = .a) if m2_302 == 1 | m2_302 == . | m2_302 == .a | m2_302 == 2 | m2_302 == 3

recode m2_315 (. = .a) if m2_314 == 1 | m2_314 == 98 | m2_314 == 99

recode m2_314_1 (0 = .a) if m2_315 == 1 | m2_315 == 98 | m2_315 == 99
recode m2_314_1 (0 = .) if m2_315 == 0

recode m2_314_2 (0 = .a) if m2_315 == 1 | m2_315 == 98 | m2_315 == 99
recode m2_314_2 (0 = .) if m2_315 == 0

recode m2_314_3 (0 = .a) if m2_315 == 1 | m2_315 == 98 | m2_315 == 99
recode m2_314_3 (0 = .) if m2_315 == 0

recode m2_314_4 (0 = .a) if m2_315 == 1 | m2_315 == 98 | m2_315 == 99
recode m2_314_4 (0 = .) if m2_315 == 0

recode m2_314_5 (0 = .a) if m2_315 == 1 | m2_315 == 98 | m2_315 == 99
recode m2_314_5 (0 = .) if m2_315 == 0

recode m2_314_96 (0 = .a) if m2_315 == 1 | m2_315 == 98 | m2_315 == 99
recode m2_314_96 (0 = .) if m2_315 == 0

replace m2_316_other = ".a" if m2_314_96 ==1

recode m2_317 (. = .a) if m2_302 == 1 | m2_302 == . | m2_302 == .a | m2_302 == 2 | m2_302 == 3 | m2_302 == 4
recode m2_318 (. = .a) if m2_317 == 1 | m2_317 == 98 | m2_317 == 99

recode m2_317_1 (0 = .a) if m2_318 == 1 | m2_318 == 98 | m2_318 == 99
recode m2_317_1 (0 = .) if m2_318 == 0

recode m2_317_2 (0 = .a) if m2_318 == 1 | m2_318 == 98 | m2_318 == 99
recode m2_317_2 (0 = .) if m2_318 == 0

recode m2_317_3 (0 = .a) if m2_318 == 1 | m2_318 == 98 | m2_318 == 99
recode m2_317_3 (0 = .) if m2_318 == 0

recode m2_317_4 (0 = .a) if m2_318 == 1 | m2_318 == 98 | m2_318 == 99
recode m2_317_4 (0 = .) if m2_318 == 0

recode m2_317_5 (0 = .a) if m2_318 == 1 | m2_318 == 98 | m2_318 == 99
recode m2_317_5 (0 = .) if m2_318 == 0

recode m2_317_96 (0 = .a) if m2_318 == 1 | m2_318 == 98 | m2_318 == 99
recode m2_317_96 (0 = .) if m2_318 == 0

replace m2_319_other = .a if m2_317_96 == 1

recode m2_320_0 (0 = .a) if m2_202 == 0 | m2_202 == 98 | m2_202 == 99 | m2_301 == 1 | m2_301 == 98 | m2_301 == 99 | m2_301 == . | m2_301 == .a
recode m2_320_0 (0 = .) if m2_202 == 1 & m2_301 == 0

recode m2_320_1 (0 = .a) if m2_202 == 0 | m2_202 == 98 | m2_202 == 99 | m2_301 == 1 | m2_301 == 98 | m2_301 == 99 | m2_301 == . | m2_301 == .a
recode m2_320_1 (0 = .) if m2_202 == 1 & m2_301 == 0

recode m2_320_2 (0 = .a) if m2_202 == 0 | m2_202 == 98 | m2_202 == 99 | m2_301 == 1 | m2_301 == 98 | m2_301 == 99 | m2_301 == . | m2_301 == .a
recode m2_320_2 (0 = .) if m2_202 == 1 & m2_301 == 0

recode m2_320_3 (0 = .a) if m2_202 == 0 | m2_202 == 98 | m2_202 == 99 | m2_301 == 1 | m2_301 == 98 | m2_301 == 99 | m2_301 == . | m2_301 == .a
recode m2_320_3 (0 = .) if m2_202 == 1 & m2_301 == 0

recode m2_320_4 (0 = .a) if m2_202 == 0 | m2_202 == 98 | m2_202 == 99 | m2_301 == 1 | m2_301 == 98 | m2_301 == 99 | m2_301 == . | m2_301 == .a
recode m2_320_4 (0 = .) if m2_202 == 1 & m2_301 == 0

recode m2_320_5 (0 = .a) if m2_202 == 0 | m2_202 == 98 | m2_202 == 99 | m2_301 == 1 | m2_301 == 98 | m2_301 == 99 | m2_301 == . | m2_301 == .a
recode m2_320_5 (0 = .) if m2_202 == 1 & m2_301 == 0

recode m2_320_6 (0 = .a) if m2_202 == 0 | m2_202 == 98 | m2_202 == 99 | m2_301 == 1 | m2_301 == 98 | m2_301 == 99 | m2_301 == . | m2_301 == .a
recode m2_320_6 (0 = .) if m2_202 == 1 & m2_301 == 0

recode m2_320_7 (0 = .a) if m2_202 == 0 | m2_202 == 98 | m2_202 == 99 | m2_301 == 1 | m2_301 == 98 | m2_301 == 99 | m2_301 == . | m2_301 == .a
recode m2_320_7 (0 = .) if m2_202 == 1 & m2_301 == 0

recode m2_320_8 (0 = .a) if m2_202 == 0 | m2_202 == 98 | m2_202 == 99 | m2_301 == 1 | m2_301 == 98 | m2_301 == 99 | m2_301 == . | m2_301 == .a
recode m2_320_8 (0 = .) if m2_202 == 1 & m2_301 == 0

recode m2_320_9 (0 = .a) if m2_202 == 0 | m2_202 == 98 | m2_202 == 99 | m2_301 == 1 | m2_301 == 98 | m2_301 == 99 | m2_301 == . | m2_301 == .a
recode m2_320_9 (0 = .) if m2_202 == 1 & m2_301 == 0

recode m2_320_10 (0 = .a) if m2_202 == 0 | m2_202 == 98 | m2_202 == 99 | m2_301 == 1 | m2_301 == 98 | m2_301 == 99 | m2_301 == . | m2_301 == .a
recode m2_320_10 (0 = .) if m2_202 == 1 & m2_301 == 0

recode m2_320_11 (0 = .a) if m2_202 == 0 | m2_202 == 98 | m2_202 == 99 | m2_301 == 1 | m2_301 == 98 | m2_301 == 99 | m2_301 == . | m2_301 == .a
recode m2_320_11 (0 = .) if m2_202 == 1 & m2_301 == 0

recode m2_320_96 (0 = .a) if m2_202 == 0 | m2_202 == 98 | m2_202 == 99 | m2_301 == 1 | m2_301 == 98 | m2_301 == 99 | m2_301 == . | m2_301 == .a
recode m2_320_96 (0 = .) if m2_202 == 1 & m2_301 == 0

recode m2_320_99 (0 = .a) if m2_202 == 0 | m2_202 == 98 | m2_202 == 99 | m2_301 == 1 | m2_301 == 98 | m2_301 == 99 | m2_301 == . | m2_301 == .a
recode m2_320_99 (0 = .) if m2_202 == 1 & m2_301 == 0

recode m2_321 (. = .a) if m2_202 == 2 | m2_202 == 3 | m2_202 == . | m2_202 == .a
                       
recode m2_401 (. = .a) if (m2_202 == 2 | m2_202 == 3 | m2_202 == . | m2_202 == .a) | (m2_302 == . | m2_302 == .a)

recode m2_402 (. = .a) if (m2_202 == 2 | m2_202 == 3 | m2_202 == . | m2_202 == .a) | (m2_302 == 1 | m2_302 == . | m2_302 == .a)				   

recode m2_403 (. = .a) if (m2_202 == 2 | m2_202 == 3 | m2_202 == . | m2_202 == .a) | (m2_302 == 1 | m2_302 == . | m2_302 == .a | m2_302 == 2)	

recode m2_404 (. = .a) if (m2_202 == 2 | m2_202 == 3 | m2_202 == . | m2_202 == .a) | (m2_302 == 1 | m2_302 == . | m2_302 == .a | m2_302 == 2 | m2_302 == 3)			   
recode m2_405 (. = .a) if (m2_202 == 2 | m2_202 == 3 | m2_202 == . | m2_202 == .a) | (m2_302 == 1 | m2_302 == . | m2_302 == .a | m2_302 == 2 | m2_302 == 3 | m2_302 == 4)

recode m2_501a (. = .a) if m2_301 == 0 | m2_301 == 98 | m2_301 == 99 | m2_301 == . | m2_301 == .a
recode m2_501b (. = .a) if m2_301 == 0 | m2_301 == 98 | m2_301 == 99 | m2_301 == . | m2_301 == .a
recode m2_501c (. = .a) if m2_301 == 0 | m2_301 == 98 | m2_301 == 99 | m2_301 == . | m2_301 == .a
recode m2_501d (. = .a) if m2_301 == 0 | m2_301 == 98 | m2_301 == 99 | m2_301 == . | m2_301 == .a
recode m2_501e (. = .a) if m2_301 == 0 | m2_301 == 98 | m2_301 == 99 | m2_301 == . | m2_301 == .a
recode m2_501f (. = .a) if m2_301 == 0 | m2_301 == 98 | m2_301 == 99 | m2_301 == . | m2_301 == .a
recode m2_501g (. = .a) if m2_301 == 0 | m2_301 == 98 | m2_301 == 99 | m2_301 == . | m2_301 == .a

recode m2_502 (. = .a) if m2_202 == 2 | m2_202 == 3 | m2_202 == . | m2_202 == .a | m2_301 == 0 | m2_301 == 98 | m2_301 == 99  | m2_301 == . | m2_301 == .a

recode m2_503a (. = .a) if m2_502 == 0 | m2_502 == 98 | m2_502 == 99
recode m2_503b (. = .a) if m2_502 == 0 | m2_502 == 98 | m2_502 == 99
recode m2_503c (. = .a) if m2_502 == 0 | m2_502 == 98 | m2_502 == 99
recode m2_503d (. = .a) if m2_502 == 0 | m2_502 == 98 | m2_502 == 99
recode m2_503e (. = .a) if m2_502 == 0 | m2_502 == 98 | m2_502 == 99
recode m2_503f (. = .a) if m2_502 == 0 | m2_502 == 98 | m2_502 == 99
recode m2_504 (. = .a) if m2_502 == 0 | m2_502 == 98 | m2_502 == 99

recode m2_505a (. = .a) if m2_503a == 0 | m2_503a == 98 | m2_503a == 99
recode m2_505b (. = .a) if m2_503b == 0 | m2_503b == 98 | m2_503b == 99
recode m2_506c (. = .a) if m2_503c == 0 | m2_503c == 98 | m2_503c == 99
recode m2_505d (. = .a) if m2_503d == 0 | m2_503d == 98 | m2_503d == 99
recode m2_505e (. = .a) if m2_503e == 0 | m2_503e == 98 | m2_503e == 99
recode m2_505f (. = .a) if m2_503f == 0 | m2_503f == 98 | m2_503f == 99
*recode m2_505g (. = .a) if m2_504 == 0 | m2_504 == 98 | m2_504 == 99

recode m2_506a (. = .a) if m2_202 == 2 | m2_202 == 3 | m2_202 == . | m2_202 == .a | m2_301 == 0 | m2_301 == 98 | m2_301 == 99 | m2_301 == . | m2_301 == .a

recode m2_506b (. = .a) if m2_202 == 2 | m2_202 == 3 | m2_202 == . | m2_202 == .a | m2_301 == 0 | m2_301 == 98 | m2_301 == 99 | m2_301 == . | m2_301 == .a

recode m2_506c (. = .a) if m2_202 == 2 | m2_202 == 3 | m2_202 == . | m2_202 == .a | m2_301 == 0 | m2_301 == 98 | m2_301 == 99 | m2_301 == . | m2_301 == .a

recode m2_506d (. = .a) if m2_202 == 2 | m2_202 == 3 | m2_202 == . | m2_202 == .a | m2_301 == 0 | m2_301 == 98 | m2_301 == 99 | m2_301 == . | m2_301 == .a

recode m2_507 (. = .a) if m2_203a == 0 & m2_203b == 0 & m2_203c == 0 & m2_203d == 0 & m2_203e == 0 & m2_203f == 0 & m2_203g == 0 & m2_203h == 0 & m2_203i == 0 | m2_301 == 0 | m2_301 == 98 | m2_301 == 99 | m2_301 == . | m2_301 == .a

*double check this:
recode m2_508a (. = .a) if (m2_205a+m2_205b) < 3

recode m2_508b_number (. = .a) if m2_508a == 0 | m2_508a == 98 | m2_508a == 99  | m2_508a == . | m2_508a == .a 

recode m2_508b_last (. = .a) if m2_508b_number == 0 | m2_508b_number == 98 | m2_508b_number == 99 | m2_508b_number == . | m2_508b_number == .a  

recode m2_508c (. = .a) if m2_508b_number == 0 | m2_508b_number == 98 | m2_508b_number == 99 | m2_508b_number == . | m2_508b_number == .a
 
recode m2_508d (. = .a) if m2_508c == 0 | m2_508c == 98 | m2_508c == 99 | m2_508c == . | m2_508c == .a

recode m2_509a (. = .a) if m2_301 == 0 | m2_301 == 98 | m2_301 == 99 | m2_301 == . | m2_301 == .a
recode m2_509b (. = .a) if m2_301 == 0 | m2_301 == 98 | m2_301 == 99 | m2_301 == . | m2_301 == .a
recode m2_509c (. = .a) if m2_301 == 0 | m2_301 == 98 | m2_301 == 99 | m2_301 == . | m2_301 == .a

recode m2_601a (. = .a) if m2_202 == 2 | m2_202 == 3 | m2_202 == . | m2_202 == .a
recode m2_601b (. = .a) if m2_202 == 2 | m2_202 == 3 | m2_202 == . | m2_202 == .a
recode m2_601c (. = .a) if m2_202 == 2 | m2_202 == 3 | m2_202 == . | m2_202 == .a
recode m2_601c (. = .a) if m2_202 == 2 | m2_202 == 3 | m2_202 == . | m2_202 == .a
recode m2_601d (. = .a) if m2_202 == 2 | m2_202 == 3 | m2_202 == . | m2_202 == .a
recode m2_601e (. = .a) if m2_202 == 2 | m2_202 == 3 | m2_202 == . | m2_202 == .a
recode m2_601f (. = .a) if m2_202 == 2 | m2_202 == 3 | m2_202 == . | m2_202 == .a
recode m2_601g (. = .a) if m2_202 == 2 | m2_202 == 3 | m2_202 == . | m2_202 == .a
recode m2_601h (. = .a) if m2_202 == 2 | m2_202 == 3 | m2_202 == . | m2_202 == .a
recode m2_601i (. = .a) if m2_202 == 2 | m2_202 == 3 | m2_202 == . | m2_202 == .a
recode m2_601j (. = .a) if m2_202 == 2 | m2_202 == 3 | m2_202 == . | m2_202 == .a
recode m2_601l (. = .a) if m2_202 == 2 | m2_202 == 3 | m2_202 == . | m2_202 == .a
recode m2_601m (. = .a) if m2_202 == 2 | m2_202 == 3 | m2_202 == . | m2_202 == .a
recode m2_601n (. = .a) if m2_202 == 2 | m2_202 == 3 | m2_202 == . | m2_202 == .a

recode m2_602a (. = .a) if (m2_202 == 2 | m2_202 == 3 | m2_202 == . | m2_202 == .a )| ///
						  (m2_601a !=1 & m2_601b !=1 & m2_601c !=1 & m2_601d !=1 & m2_601e !=1 & ///
						  m2_601f !=1 & m2_601g !=1 & m2_601h !=1 & m2_601i !=1 & m2_601j !=1 & ///
						  m2_601k !=1 & m2_601l !=1 & m2_601m !=1 & m2_601n !=1)
						  
recode m2_602b (. = .a) if m2_602a == 0 | m2_602a == 98 | m2_602a == 99	| m2_602a == . | m2_602a == .a

recode m2_603 (. = .a) if m2_202 == 2 | m2_202 == 3 | m2_202 == . | m2_202 == .a 
recode m2_604 (. = .a) if m2_603 == 2 | m2_603 == 3 | m2_603 == . | m2_603 == .a 
			
recode m2_701 (. = .a) if m2_202 == 2 | m2_202 == 3 | m2_202 == . | m2_202 == .a | m2_301 == 0 | m2_301 == 98 | m2_301 == 99 | m2_301 == . | m2_301 == .a

recode m2_702a (. = .a) if m2_701 == 0 | m2_701 == 98 | m2_701 == 99 | m2_701 ==. | m2_701 == .a
recode m2_702a_other (. = .a) if m2_702a !=1

recode m2_702b (. = .a) if m2_701 == 0 | m2_701 == 98 | m2_701 == 99 | m2_701 ==. | m2_701 == .a
recode m2_702b_other (. = .a) if m2_702b !=1

recode m2_702c (. = .a) if m2_701 == 0 | m2_701 == 98 | m2_701 == 99 | m2_701 ==. | m2_701 == .a
recode m2_702c_other (. = .a) if m2_702c !=1

recode m2_702d (. = .a) if m2_701 == 0 | m2_701 == 98 | m2_701 == 99 | m2_701 ==. | m2_701 == .a
recode m2_702d_other (. = .a) if m2_702d !=1

recode m2_702e (. = .a) if m2_701 == 0 | m2_701 == 98 | m2_701 == 99 | m2_701 ==. | m2_701 == .a
recode m2_702e_other (. = .a) if m2_702e !=1

* SS: Ask Kate if we should add 98 into branching logic for 704_other
recode m2_703 m2_704 (. = .a) if m2_701 == 0 | m2_701 == 98 | m2_701 == 99 | m2_701 ==. | m2_701 == .a

recode m2_704_other (. = .a) if m2_704 != 1 

recode m2_705_1 (0 = .a) if m2_701 == 0 | m2_701 == 98 | m2_701 == 99 | m2_701 ==. | m2_701 == .a
recode m2_705_1 (0 = .) if m2_701 == 1

recode m2_705_2 (0 = .a) if m2_701 == 0 | m2_701 == 98 | m2_701 == 99 | m2_701 ==. | m2_701 == .a
recode m2_705_2 (0 = .) if m2_701 == 1

recode m2_705_3 (0 = .a) if m2_701 == 0 | m2_701 == 98 | m2_701 == 99 | m2_701 ==. | m2_701 == .a
recode m2_705_3 (0 = .) if m2_701 == 1

recode m2_705_4 (0 = .a) if m2_701 == 0 | m2_701 == 98 | m2_701 == 99 | m2_701 ==. | m2_701 == .a
recode m2_705_4 (0 = .) if m2_701 == 1

recode m2_705_5 (0 = .a) if m2_701 == 0 | m2_701 == 98 | m2_701 == 99 | m2_701 ==. | m2_701 == .a
recode m2_705_5 (0 = .) if m2_701 == 1

recode m2_705_6 (0 = .a) if m2_701 == 0 | m2_701 == 98 | m2_701 == 99 | m2_701 ==. | m2_701 == .a
recode m2_705_6 (0 = .) if m2_701 == 1

recode m2_705_96 (0 = .a) if m2_701 == 0 | m2_701 == 98 | m2_701 == 99 | m2_701 ==. | m2_701 == .a
recode m2_705_96 (0 = .) if m2_701 == 1

recode m2_interview_inturrupt (. = .a) if m2_permission == 0 | m2_permission == . | m2_permission == .a | m2_202 == 2 | m2_202 == 3 | m2_202 == . | m2_202 == .a 
 
recode m2_interview_restarted (. = .a) if m2_permission == 0 | m2_permission == . | m2_permission == .a | m2_202 == 2 | m2_202 == 3 | m2_202 == . | m2_202 == .a  | m2_interview_inturrupt == 0 | m2_interview_inturrupt == . | m2_interview_inturrupt == .a

recode m2_int_duration (. = .a) if m2_permission == 0 | m2_permission == . | m2_permission == .a | m2_202 == 2 | m2_202 == 3 | m2_202 == . | m2_202 == .a 

recode m2_endstatus (. = .a) if m2_endtime == ""

*------------------------------------------------------------------------------*
* drop variables after recoding/renaming

drop m1_714d m1_803 module_3_second_phone_survey_aft
ren rec* *

*===============================================================================					   
	
	* STEP FOUR: LABELING VARIABLES
label variable country "Country"
label variable site "Study site - adama/east shewa" 
label variable sampstrata "Facility type and level"
label variable redcap_record_id "Redcap Record ID"
label variable redcap_event_name "Redcap Event Name"
label variable redcap_repeat_instrument "Redcap Repeat Instrument"
label variable redcap_repeat_instance "Redcap Repeat Instance"
label variable redcap_data_access_group "Redcap Data Access Group"
label variable study_id "Study ID"
label variable interviewer_id "Interviewer ID"

	** MODULE 1:		

lab var date_m1 "A2. Date of interview"
lab var m1_start_time "A3. Time of interview"
lab var study_site "A4. Study site"
lab var study_site_sd "A4_Other. Specify other study site"
lab var facility "A5. Facility name"
lab var facility_other "A5_Other. Specify other facility name"
lab var facility_type "A5. Facility type"
lab var interviewer_name_a7 "A7. Interviewer Name"
lab var permission "B1. May we have your permission to explain why we are here today, and to ask some questions?"
lab var care_self "B2. Are you here today to receive care for yourself or someone else?"
lab var enrollage "B3. How old are you?"
lab var zone_live "B4. In which zone/district/ sub city are you living?"
lab var b5anc "B5. By that I mean care related to a pregnancy?"
lab var b6anc_first "B6. Is this the first time you've come to a health facility to talk to a healthcare provider about this pregnancy?"
lab var b6anc_first_conf "01. Data collector confirms with provider that this is the woman's first visit. Data collector confirms with maternal health card that it is the woman's first visit."
lab var continuecare "ETH-1-B. Do you plan to continue receiving care for your pregnancy in the East Shewa zone or Adama town?"
lab var b7eligible "B7. Is the respondent eligible to participate in the study AND signed a consent form?"
lab var first_name "101. What is your first name?"
lab var family_name "102. What is your family name?"
lab var respondentid "103. Assign respondent ID"
lab var mobile_phone "104. Do you have a mobile phone with you today?"
lab var phone_number "105. What is your phone number?"
lab var flash "106. Can I 'flash' this number now to make sure I have noted it correctly?"
lab var kebele_malaria "Eth-1-1 Interviewer check whether the area that the woman living is malarias or not?"
lab var kebele_intworm "Eth-2-1. Interviewer check whether the area that the woman living is endemic for intestinal worm or not?"
lab var m1_201 "201. In general, how would you rate your overall health?"
lab var m1_202a "202a. BEFORE you got pregnant, did you know that you had Diabetes?"
lab var m1_202b "202b. BEFORE you got pregnant, did you know that you had High blood pressure or hypertension?"
lab var m1_202c "202c. BEFORE you got pregnant, did you know that you had a cardiac disease or problem with your heart?"
lab var m1_202d "202d. BEFORE you got pregnant, did you know that you had A mental health disorder such as depression, anxiety, bipolar disorder, or schizophrenia?"
lab var m1_202e "202e. BEFORE you got pregnant, did you know that you had HIV?"
lab var m1_202f "202f. BEFORE you got pregnant, did you know that you had Hepatitis B?"
lab var m1_202g "202g. BEFORE you got pregnant, did you know that you had Renal disorder?"
lab var m1_203_et "203. Before you got pregnant, were you diagnosed with any other major health problems?"
lab var m1_203_other "203_Other. Specify the diagnosis health problem"
lab var m1_204 "204. Are you currently taking any medications?"
lab var m1_205a "205a. I am going to read three statements about your mobility, by which I mean your ability to walk around. Please indicate which statement best describe your own health state today?"
lab var m1_205b "205b. I am now going to read three statements regarding your ability to self-care, by which I mean whether you can wash and dress yourself without assistance. Please indicate which statement best describe your own health state today"
lab var m1_205c "205c. I am going to read three statements regarding your ability to perform your usual daily activities, by which I mean your ability to work, take care of your family or perform leisure activities. Please indicate which statement best describe your own health state today"
lab var m1_205d "205d. I am going to read three statements regarding your experience with physical pain or discomfort. Please indicate which statement best describe your own health state today"
lab var m1_205e "205e. I am going to read three statements regarding your experience with anxiety or depression. Please indicate which statements best describe your own health state today"
lab var phq9a "206a. Over the past 2 weeks, how many days have you been bothered by little interest or pleasure in doing things?"
lab var phq9b "206b. Over the past 2 weeks, on how many days have you been bothered by feeling down, depressed, or hopeless?"
lab var phq9c "206c. Over the past 2 weeks, on how many days have you been bothered by trouble falling or staying asleep, or sleeping too much?"
lab var phq9d "206d. Over the past 2 weeks, on how many days have you been bothered by feeling tired or having little energy?"
lab var phq9e "206e. Over the past 2 weeks, on how many days have you been bothered by poor appetite or overeating?"
lab var phq9f "206f. Over the past 2 weeks, on how many days have you been bothered by feeling bad about yourself or that you are a failure or have let yourself or your family down?"
lab var phq9g "206g. Over the past 2 weeks, on how many days have you been bothered by trouble concentrating on things, such as your work or home duties?"
lab var phq9h "206h. Over the past 2 weeks, on how many days have you been bothered by moving or speaking so slowly that other people could have noticed? Or so fidgety or restless that you have been moving a lot more than usual?"
lab var phq9i "206i. Over the past 2 weeks, on how many days have you been bothered by Thoughts that you would be better off dead, or thoughts of hurting yourself in some way?"
lab var m1_207 "207. Over the past 2 weeks, on how many days did health problems affect your productivity while you were working? Work may include formal employment, a business, sales or farming, but also work you do around the house, childcare, or studying. Think about days you were limited in the amount or kind of work you could do, days you accomplished less than you would like, or days you could not do your work as carefully as usual."
lab var m1_301 "301. How would you rate the overall quality of medical care in Ethiopia?"
lab var m1_302 "302. Overall view of the health care system in your country"
lab var m1_303 "303. Confidence that you would receive good quality healthcare from the health system if you got very sick?"
lab var m1_304 "304. Confidence you would be able to afford the healthcare you needed if you became very sick?"
lab var m1_305a "305a. Confidence that you that you are the person who is responsible for managing your overall health?"
lab var m1_305b "305b. Confidence that you that you can tell a healthcare provider concerns you have even when he or she does not ask "
lab var m1_401 "401. How did you travel to the facility today?"
lab var m1_401_other "401_Other. Other specify"
lab var m1_402 "402. How long in minutes did it take you to reach this facility from your home?"
lab var m1_403a "403a. Do you know the distance from your home to the / facility?"
lab var m1_403b "403b. How far in kilometers is your home from this facility?"
lab var m1_404 "404. Is this the nearest health facility to your home that provides antenatal care for pregnant women?"
lab var m1_405 "405. What is the most important reason for choosing this facility for your visit today?"
lab var m1_405_other "405_Other. Specify other reason"
lab var m1_501 "501. What is your first language?"
lab var m1_501_other "501_Other. Specify other language"
lab var m1_502 "502. Have you ever attended school?"
lab var m1_503 "503. What is the highest level of education you have completed?"
lab var m1_504 "504. Now I would like you to read this sentence to me. 1. PARENTS LOVE THEIR CHILDREN. 3. THE CHILD IS READING A BOOK. 4. CHILDREN WORK HARD AT SCHOOL."
lab var m1_505 "505. What is your current marital status?"
lab var m1_506 "506. What is your occupation, that is, what kind of work do you mainly do?"
lab var m1_506_other "506_Other. Specify other occupation"
lab var m1_507 "507. What is your religion?"
lab var m1_507_other "507_Other. Specify other religion"
lab var m1_508 "508. How many people do you have near you that you can readily count on for help in times of difficulty such as to watch over children, bring you to the hospital or store, or help you when you are sick?"
lab var m1_509a "509a. Now I would like to talk about something else. Have you ever heard of an illness called HIV/AIDS?"
lab var m1_509b "509b. Do you think that people can get the HIV virus from mosquito bites?"
lab var m1_510a "510a. Have you ever heard of an illness called tuberculosis or TB?"
lab var m1_510b "510b. Do you think that TB can be treated using herbal or traditional medicine made from plants?"
lab var m1_511 "511. When children have diarrhea, do you think that they should be given less to drink than usual, more to drink than usual, about the same or it doesn't matter?"
lab var m1_512 "512. Is smoke from a wood burning traditional stove good for health, harmful for health or do you think it doesn't really matter?"
lab var m1_513a_1 "513a. What phone numbers can we use to reach you in the coming months? / Primary personal phone"
lab var m1_513a_2 "513a. What phone numbers can we use to reach you in the coming months? / Secondary personal phone"
lab var m1_513a_3 "513a. What phone numbers can we use to reach you in the coming months? / Spouse or partner phone"
lab var m1_513a_4 "513a. What phone numbers can we use to reach you in the coming months? / Community health worker phone"
lab var m1_513a_5 "513a. What phone numbers can we use to reach you in the coming months? / Friend or other family member phone 1"
lab var m1_513a_6 "513a. What phone numbers can we use to reach you in the coming months? / Friend or other family member phone 2"
lab var m1_513a_7 "513a. What phone numbers can we use to reach you in the coming months? / Other phone"
lab var m1_513a_8 "513a. What phone numbers can we use to reach you in the coming months? / Does not have any phone numbers"
lab var m1_513a_999 "513a. Unknown"
lab var m1_513a_998 "513a. Refuse to answer"
lab var m1_513a_888 "513a. No information"
lab var m1_513b "513b. Primary personal phone number"
lab var m1_513c "513c. Can I flash this number now to make sure I have noted it correctly?"
lab var m1_513d "513d. Secondary personal phone number"
lab var m1_513e "513e. Spouse or partner phone number"
lab var m1_513f "513f. Community health worker phone"
lab var m1_513g "513g. Close friend or family member phone"
lab var m1_513h "513h. Close friend or family member phone number 2"
lab var m1_513i "513i. Other phone number"
lab var m1_514a "514a. We would like you to be able to participate in this study. We can give you a mobile phone for you to take home so that we can reach you. Would you like to receive a mobile phone?"
lab var m1_514b "514b. Interviewer enters the number of the phone provided. Interviewer flashes the number to ensure it is entered correctly."
lab var m1_515a "515a. Where is your town/district?"
lab var m1_515b "515b. Where is your zone or sub-city?"
lab var m1_515c "515c. Where is your Kebele you live?"
lab var m1_515d "515d. What is your village name/block"
lab var m1_516 "516. Could you please describe directions to your residence? Please give us enough detail so that a data collection team member could find your residence if we needed to ask you some follow up questions"
lab var m1_517 "517. Is this a temporary residence or a permanent residence?"
lab var m1_518 "518. Until when will you be at this residence?"
lab var m1_519_district "519a. Where will your district be after this date?"
lab var m1_519_ward "519b. Where will your kebele be after this date"
lab var m1_519_village "519c. Where will your village be after this date"
lab var m1_601 "601. Overall how would you rate the quality of care you received today?"
lab var m1_602 "602. How likely are you to recommend this facility or provider to a family member or friend to receive care for their pregnancy?"
lab var m1_603 "603. How long in minutes did you spend with the health provider today?"
lab var m1_604 "604. How long in minutes did you wait between the time you arrived at this facility and the time you were able to see a provider for the consultation?"
lab var m1_604b_et "Eth-1-6-1. How long in hours did you spend at this facility today for all aspects of your care, including wait time, the consultation, and any other components of your care today?"
lab var m1_604c_et "Eth-1-6.2. How long in hours did you spend at this facility today for all aspects of your care, including wait time, the consultation, and any other components of your care today?"
lab var m1_605a "605a. How would you rate the knowledge and skills of your provider?"
lab var m1_605b "605b. How would you rate the equipment and supplies that the provider had available such as medical equipment or access to lab?"
lab var m1_605c "605c. How would you rate the level of respect the provider showed you?"
lab var m1_605d "605d. How would you rate the clarity of the provider's explanations?"
lab var m1_605e "605e. How would you rate the degree to which the provider involved you as much as you wanted to be in decisions about your care?"
lab var m1_605f "605f. How would you rate the amount of time the provider spent with you?"
lab var m1_605g "605g. How would you rate the amount of time you waited before being seen?"
lab var m1_605h "605h. How would you rate the courtesy and helpfulness of the healthcare facility staff, other than your provider?"
lab var m1_605i_et "605i. How would you rate the confidentiality of care or diagnosis?"
lab var m1_605j_et "605j. How would you rate the privacy (Auditory or visual)?"
lab var m1_605k_et "605k. How would you rate the affordability of charge or bill to the service?"
lab var m1_700 "700. Measure your blood pressure?"
lab var m1_701 "701. Measure your weight?"
lab var m1_702 "702. Measure your height?"
lab var m1_703 "703. Measure your upper arm?"
lab var m1_704 "704. Listen to the heart rate of the baby (that is, where the provider places a listening device against your belly to hear the baby's heart beating)?"
lab var m1_705 "705. Take a urine sample (that is, you peed in a container)?"
lab var m1_706 "706. Take a blood drop using a finger prick (that is, taking a drop of blood from your finger)"
lab var m1_707 "707. Take a blood draw (that is, taking blood from your arm with a syringe)"
lab var m1_708a "708a. Do an HIV test?"
lab var m1_708b "708b. Would you please share with me the result of the HIV test? Remember this information will remain confidential."
lab var m1_708c "708c. Did the provider give you medicine for HIV?"
lab var m1_708d "708d. Did the provider explain how to take the medicine for HIV?"
lab var m1_708e "708e. Did the provider do an HIV viral load test?"
lab var m1_708f "708f. Did the provider do a CD4 test?"
lab var m1_709a "709a. Did the provider do an HIV viral load test?"
lab var m1_709b "709b. Did the provider do a CD4 test?"
lab var m1_710a "710a. Did they do a syphilis test?"
lab var m1_710b "710b. Would you please share with me the result of the syphilis test?"
lab var m1_710c "710c. Did the provider give you medicine for syphilis directly, gave you a prescription or told you to get it somewhere else, or neither?"
lab var m1_711a "711a. Did they do a blood sugar test for diabetes?"
lab var m1_711b "711b. Do you know the result of your blood sugar test?"
lab var m1_712 "712. Did they do an ultrasound (that is, when a probe is moved on your belly to produce a video of the baby on a screen)"
lab var m1_713a "713a_1. Iron and folic acid pills?"
lab var m1_713b "713b_1. Calcium pills?"
lab var m1_713c "713c_1. The food supplement like Super Cereal or Plumpynut?"
lab var m1_713d "713d_1. Medicine for intestinal worms?"
lab var m1_713e "713e_1. Medicine for malaria (endemic only)?"
lab var m1_713f "713f_1. Medicine for your emotions, nerves, or mental health?"
lab var m1_713g "713g_1. Multivitamins?"
lab var m1_713h "713h_1. Medicine for hypertension?"
lab var m1_713i "713i_1. Medicine for diabetes, including injections of insulin?"
lab var m1_714a "714a. During the visit today, were you given an injection in the arm to prevent the baby from getting tetanus, that is, convulsions after birth?"
lab var m1_714b "714b. At any time BEFORE the visit today, did you receive any tetanus injections?"
lab var m1_714c "714c. Before today, how many times did you receive a tetanus injection?"
lab var m1_714d "714d. How many years ago did you receive that tetanus injection?"
lab var m1_714e "714e. How many years ago did you receive the last tetanus injection?"
lab var m1_715 "715. Were you provided with an insecticide treated bed net to prevent malaria?"
lab var m1_716a "716a. Did you discuss about Nutrition or what is you to be eating during your pregnancy?"
lab var m1_716b "716b. Did you discuss about Exercise or physical activity during your pregnancy?"
lab var m1_716c "716c. Did you discuss about Your level of anxiety or depression?"
lab var m1_716d "716d. Did you discuss about how to use a mosquito net that has been treated with an insecticide? (Malaria endemic zones only)?"
lab var m1_716e "716e. Did you discuss about Signs of pregnancy complications that would require you to go to the health facility?"
lab var m1_717 "717. Did you discuss that you were feeling down or depressed, or had little interest in doing things?"
lab var m1_718 "718. Did you discuss your diabetes, or not?"
lab var m1_719 "719. Did you discuss your high blood pressure or hypertension, or not?"
lab var m1_720 "720. Did you discuss your cardiac problems or problems with your heart, or not?"
lab var m1_721 "721. During the visit today, did you and the healthcare provider discuss your mental health disorder, or not?"
lab var m1_722 "722. Did you discuss your HIV, or not?"
lab var m1_723 "723. Did you discuss the medications you are currently taking, or not?"
lab var m1_724a "724a. Were you told you should come back for another antenatal care visit at this facility?"
lab var m1_724b "724b. When did he tell you to come back? In how many weeks?"
lab var m1_724c "724c. Were you told to go see a specialist like an obstetrician or a gynecologist?"
lab var m1_724d "724d. That you should see a mental health provider like a psychologist?"
lab var m1_724e "724e. To go to the hospital for follow-up antenatal care?"
lab var m1_724f "724f. To go somewhere else to do a urine test such as a lab or another health facility?"
lab var m1_724g "724g. To go somewhere else to do a blood test such as a lab or another health facility?"
lab var m1_724h "724h. To go somewhere else to do an HIV test such as a lab or another health facility?"
lab var m1_724i "724i. Were you told to go somewhere else to do an ultrasound such as a hospital or another health facility?"
lab var m1_801 "801. Did the healthcare provider tell you the estimated date of delivery, or not?"
lab var m1_802a "802a. What is the estimated date of delivery the provider told you?"
lab var m1_802b_et "802b. Do you know your last normal menstrual period?"
lab var m1_802c_et "802c. What is the date of your last normal menstrual period"
lab var m1_802d_et "802d. Gestational age in weeks based on LNMP"
*lab var m1_803 "803. How many weeks pregnant do you think you are?" // dropped above
lab var m1_804 "804. Interviewer calculates the gestational age in trimester based on Q802 (estimated due date) or on Q803 (self-reported number of months pregnant)."
lab var m1_805 "805. How many babies are you pregnant with?"
lab var m1_806 "806. During the visit today, did the healthcare provider ask when you had your last period, or not?"
lab var m1_807 "807. When you got pregnant, did you want to get pregnant at that time?"
lab var m1_808_0_et "808. Didn't realize you were pregnant"
lab var m1_808_1_et "808. Tried to come earlier and were sent away"
lab var m1_808_2_et "808. You received care at home"
lab var m1_808_3_et "808. High cost (e.g., high out of pocket payment, not covered by insurance)"
lab var m1_808_4_et "808. Far distance (e.g., too far to walk or drive, transport not readily available)"
lab var m1_808_5_et "808. Long waiting time (e.g., long line to access facility, long wait for the provider)"
lab var m1_808_6_et "808. Poor healthcare provider skills (e.g., spent too little time with patient, did not conduct a thorough exam)"
lab var m1_808_7_et "808. Staff don't show respect (e.g., staff is rude, impolite, dismissive) "
lab var m1_808_8_et "808. Medicines and equipment are not available (e.g., medicines regularly out of stock, equipment like X-ray machines broken or unavailable)"
lab var m1_808_9_et "808. COVID-19 fear"
lab var m1_808_10_et "808. Don't know where to go (e.g., too complicated)"
lab var m1_808_11_et "808. Fear of discovering serious problems"
lab var m1_808_12_et "808. Do not know advantage of early coming"
lab var m1_808_96_et "808. Other, specify"
lab var m1_808_99_et "808. NR/RF"
lab var m1_808_888_et "808. Unknown"
lab var m1_808_998_et "808. Refuse to answer"
lab var m1_808_999_et "808. No information"
lab var m1_808_other "808_Other. Specify other reason not to receive care earlier in your pregnancy."
lab var m1_809 "809. During the visit today, did you and the provider discuss your birth plan?"
lab var m1_810a "810a. Where do you plan to give birth?"
lab var m1_810b "810b. What is the name of the [facility type from 810a] where you plan to give birth?"
lab var m1_810_other "810b_Other. Other than the list above, specify"
lab var m1_811 "811. Do you plan to stay at a maternity waiting home before delivering your baby?"
lab var m1_812a "812a. During the visit today, did the provider tell you that you might need a C-section?"
lab var m1_812b_0_et "812b.0. Have you told the reason why you might need a c-section?"
lab var m1_812b_1 "812b. Because I had a c-section before"
lab var m1_812b_2 "812b. Because I am pregnant with more than one baby"
lab var m1_812b_3 "812b. Because of the baby's position"
lab var m1_812b_4 "812b. Because of the position of the placenta"
lab var m1_812b_5 "812b. Because I have health problems"
lab var m1_812b_96 "812b. Other, specify"
lab var m1_812b_98 "812b. DK"
lab var m1_812b_99 "812b. NR/RF"
lab var m1_812b_888_et "812b. Unknown"
lab var m1_812b_998_et "812b. Refuse to answer"
lab var m1_812b_999_et "812b. No information"
lab var m1_812b_other "812_Other. Specify other reason for C-section"
lab var m1_813a "813a. Some women experience common health problems during pregnancy. Did you experience nausea in your pregnancy so far, or not?"
lab var m1_813b "813b. Some women experience common health problems during pregnancy. Did you experience heartburn in your pregnancy so far, or not?"
lab var m1_813c "813c. Some women experience common health problems during pregnancy. Did you experience leg cramps in your pregnancy so far, or not?"
lab var m1_813d "813d. Some women experience common health problems during pregnancy. Did you experience back pain in your pregnancy so far, or not?"
lab var m1_813e "813e. During the visit today did the provider give you treatment or advice for addressing these kinds of problems?"
lab var m1_8a_et "Eth-1-8a. Did you experience Preeclampsia / Eclampsia in your pregnancy so far, or not?"
lab var m1_8b_et "Eth-1-8b. Some women experience medical and obstetric health problems during pregnancy. Did you experience Hyperemesis gravidarum during pregnancy in your pregnancy so far, or not?"
lab var m1_8c_et "Eth-1-8c. Some women experience medical and obstetric health problems during pregnancy. Did you experience Anemia during pregnancy in your pregnancy so far, or not?"
lab var m1_8d_et "Eth-1-8d. Some women experience medical and obstetric health problems during pregnancy. Did you experience Amniotic fluid volume problems (Oligohydramnios / Polyhydramnios) during pregnancy in your pregnancy so far, or not?"
lab var m1_8e_et "Eth-1-8e. Some women experience medical and obstetric health problems during pregnancy. Did you experience Asthma during pregnancy in your pregnancy so far, or not?"
lab var m1_8f_et "Eth-1-8f. Some women experience medical and obstetric health problems during pregnancy. Did you experience RH isoimmunization during pregnancy in your pregnancy so far, or not?"
lab var m1_8g_et "Eth - 1 - 8g. Any other pregnancy problem"
lab var m1_8gother_et "Eth-1-8g_Other. Specify any other experience in your pregnancy so far"
lab var m1_2_8_et "Eth-2-8. During the visit today, did the provider give you a treatment or advice for addressing these kinds of problems?"
lab var m1_814a "814a. Could you please tell me if you have experienced Severe or persistent headaches in your pregnancy so far, or not?"
lab var m1_814b "814b. Could you please tell me if you have experienced Vaginal bleeding of any amount in your pregnancy so far, or not?"
lab var m1_814c "814c. Could you please tell me if you have experienced a fever in your pregnancy so far, or not?"
lab var m1_814d "814d. Could you please tell me if you have experienced Severe abdominal pain, not just discomfort in your pregnancy so far, or not?"
lab var m1_814e "814e. Could you please tell me if you have experienced a lot of difficulty breathing even when you are resting in your pregnancy so far, or not?"
lab var m1_814f "814f. Could you please tell me if you have experienced Convulsions or seizures in your pregnancy so far, or not?"
lab var m1_814g "814g. Could you please tell me if you have experienced repeated fainting or loss of consciousness in your pregnancy so far, or not?"
lab var m1_814h "814h. Could you please tell me if you have experienced noticing that the baby has completely stopped moving in your pregnancy so far, or not?"
lab var m1_814i "814i. Could you please tell me if you have experienced blurring of vision in your pregnancy so far, or not?"
lab var m1_815_0 "815. Nothing, we did not discuss this"
lab var m1_815_1 "815.Told me to come back to this health facility"
lab var m1_815_2 "815.They told you to get a lab test or imaging (e.g., ultrasound, blood tests, x-ray, heart echo)"
lab var m1_815_3 "815.They provided a treatment in the visit"
lab var m1_815_4 "815. They prescribed a medication"
lab var m1_815_5 "815. They told you to come back to this health facility "
lab var m1_815_6 "815. They told you to go somewhere else for higher level care"
lab var m1_815_7 "815. They told you to wait and see"
lab var m1_815_96 "815. Other (specify)"
lab var m1_815_98 "815. DK"
lab var m1_815_99 "815. NR/RF"
lab var m1_815_888_et "815. Unknown"
lab var m1_815_998_et "815. Refuse to answer"
lab var m1_815_999_et "815. No information"
lab var m1_815_other "815_Other. Other (specify)"
lab var m1_816 "816. You said that you did not have any of the symptoms I just listed. Did the health provider ask you whether or not you had these symptoms, or did this topic not come up today?"
lab var m1_901 "901. How often do you currently smoke cigarettes or use any other type of tobacco? Is it every day, some days, or not at all?"
lab var m1_902 "902. During the visit today, did the health provider advise you to stop smoking or using tobacco products?"
lab var m1_903 "903. How often do you chew khat? Is it every day, some days, or not at all?"
lab var m1_904 "904. During the visit today, did the health provider advise you to stop chewing khat?"
lab var m1_905 "905. Have you consumed an alcoholic drink (i.e., Tela, Tej, Areke, Bira, Wine, Borde, Whisky) within the past 30 days?"
lab var m1_906 "906. When you do drink alcohol, how many standard drinks do you consume on average?"
lab var m1_907 "907. During the visit today, did the health provider advise you to stop drinking alcohol?"
lab var m1_1001 "1001. How many pregnancies have you had, including the current pregnancy and regardless of whether you gave birth or not?"
lab var m1_1002 "1002. How many births have you had (including babies born alive or dead)?"
lab var m1_1003 "1003. In how many of those births was the baby born alive?"
lab var m1_1004 "1004. Have you ever lost a pregnancy after 20 weeks of being pregnant?"
lab var m1_1005 "1005. Have you ever had a baby that came too early, more than 3 weeks before the due date / Small baby?"
lab var m1_1006 "1006. Have you ever bled so much in a previous pregnancy or delivery that you needed to be given blood or go back to the delivery room for an operation?"
lab var m1_1_10_et "Eth-1-10. Have you ever had a baby born with a congenital anomaly? I mean a neural tube defect"
lab var m1_1007 "1007. Have you ever had cesarean section?"
lab var m1_1008 "1008. Have you ever had a delivery that lasted more than 12 hours of you pushing?"
lab var m1_1009 "1009. How many of your children are still alive?"
lab var m1_1010 "1010. Have you ever had a baby die within the first month of their life?"
lab var m1_1011a "1011a. Did you discuss about your previous pregnancies, or not?"
lab var m1_1011b "1011b. Did you discuss about that you lost a baby after 5 months of pregnancy, or not?"
lab var m1_1011c "1011c. Did you discuss about that you had a baby who was born dead before, or not?"
lab var m1_1011d "1011d. Did you discuss about that you had a baby born early before, or not?"
lab var m1_1011e "1011e. Did you discuss about that you had a c-section before, or not?"
lab var m1_1011f "1011f. Did you discuss about that you had a baby die within their first month of life?"
lab var m1_1101 "1101. At any point during your current pregnancy, has anyone ever hit, slapped, kicked, or done anything else to hurt you physically?"
lab var m1_1102_1 "1102. Current husband / partner"
lab var m1_1102_2 "1102. Parent (Mother; Father, step-parent, in-law)"
lab var m1_1102_3 "1102. Sibling"
lab var m1_1102_4 "1102. Child"
lab var m1_1102_5 "1102. Late /last / ex-husband/partner"
lab var m1_1102_6 "1102. Other relative"
lab var m1_1102_7 "1102. Friend /acquaintance/"
lab var m1_1102_8 "1102. Teacher"
lab var m1_1102_9 "1102. Employer"
lab var m1_1102_10 "1102. Stranger"
lab var m1_1102_96 "1102. Other, specify"
lab var m1_1102_98 "1102. DK"
lab var m1_1102_99 "1102. NR/RF"
lab var m1_1102_888_et "1102. Unknown"
lab var m1_1102_998_et "1102. Refuse to answer"
lab var m1_1102_999_et "1102. No information"
lab var m1_1102_other "1102_Oth. Specify who else hit, kick, slapped, ... you"
lab var m1_1103 "1103. At any point during your current pregnancy, has anyone ever said or done something to humiliate you, insulted you or made you feel bad about yourself?"
lab var m1_1104_1 "1104. Current husband / partner"
lab var m1_1104_2 "1104. Parent (Mother; Father, step-parent, in-law)"
lab var m1_1104_3 "1104. Sibling"
lab var m1_1104_4 "1104. Child"
lab var m1_1104_5 "1104. Late /last / ex-husband/partner"
lab var m1_1104_6 "1104. Other relative"
lab var m1_1104_7 "1104. Friend /acquaintance"
lab var m1_1104_8 "1104. Teacher"
lab var m1_1104_9 "1104. Employer"
lab var m1_1104_10 "1104. Stranger"
lab var m1_1104_96 "1104. Other (specify)"
lab var m1_1104_98 "1104. DF"
lab var m1_1104_99 "1104. NR/RF"
lab var m1_1104_888_et "1104. Unknown"
lab var m1_1104_998_et "1104. Refuse to answer"
lab var m1_1104_999_et "1104. No information"
lab var m1_1104_other "1104_Other. Specify others who humiliates you"
lab var m1_1105 "1105. During the visit today, did the health provider discuss with you where you can seek support for these things?"
lab var m1_1201 "1201. What is the main source of drinking water for members of your household?"
lab var m1_1201_other "1201_Other. Specify other source of drink water"
lab var m1_1202 "1202. What kind of toilet facilities does your household have?"
lab var m1_1202_other "1202_Other. Specify other kind of toilet facility"
lab var m1_1203 "1203. Does your household have electricity?"
lab var m1_1204 "1204. Does your household have a radio?"
lab var m1_1205 "1205. Does your household have a television?"
lab var m1_1206 "1206. Does your household have a telephone or a mobile phone?"
lab var m1_1207 "1207. Does your household have a refrigerator?"
lab var m1_1208 "1208. What type of fuel does your household mainly use for cooking?"
lab var m1_1208_other "1208_Other. Specify other fuel type for cooking"
lab var m1_1209 "1209. What is the main material of your floor?"
lab var m1_1209_other "1209_Other. Specify other fuel type for cooking"
lab var m1_1210 "1210. What is the main material your walls are made of?"
lab var m1_1210_other "1210_Other. Specify other fuel type for cooking"
lab var m1_1211 "1211. What is the main material your roof is made of?"
lab var m1_1211_other "1211_Other. Specify other fuel type for cooking"
lab var m1_1212 "1212. Does any member of your household own a bicycle?"
lab var m1_1213 "1213. Does any member of your household own a motorcycle or motor scooter?" 
lab var m1_1214 "1214. Does any member of your household own a car or truck?"
lab var m1_1215 "1215. Does any member of your household have a bank account?"
lab var m1_1216 "1216. Do you know number of meals does your household usually have per day?"
lab var m1_1216_1 "1216.1. How many meals does your household usually have per day?"
lab var m1_1217 "1217. Did you pay money out of your pocket for this visit, including for the consultation or other indirect costs like your transport to the facility?"
lab var m1_1218a "1218a. Have you spent money for registration or consultation?"
lab var m1_1218a_1 "1218a.1. How much money did you spend on Registration / Consultation?"
lab var m1_1218b "1218b. Have you spent money for Medicine/vaccines (including outside purchase)"
lab var m1_1218b_1 "1218b.1. How much money do you spent for medicine/vaccines (including outside purchase)"
lab var m1_1218c "1218c. Have you spent money for Test/investigations (x-ray, lab etc.)?"
lab var m1_1218c_1 "1218c.1. How much money have you spent on Test/investigations (x-ray, lab etc.)?"
lab var m1_1218d "1218d. Have you spent money for Transport (round trip) including that of person accompanying you?"
lab var m1_1218d_1 "1218d.1. How much money have you spent for transport (round trip) including that of person accompanying you?"
lab var m1_1218e "1218e. Have you spent money for food and accommodation including that of person accompanying you?"
lab var m1_1218e_1 "1218e.1. How much money have you spent on food and accommodation including that of the person accompanying you?"
lab var m1_1218f "1218f. Have you spent money for other purpose?"
lab var m1_1218f_1 "1218f.1. How much money have you spent for other purpose?"
lab var m1_1219 "Total amount spent"
lab var m1_1220_1 "1220. Current income of any household members"
lab var m1_1220_2 "1220. Saving(bank account"
lab var m1_1220_3 "1220. Payment or reimbursement from a health insurance plan"
lab var m1_1220_4 "1220. Sold items (e.g. furniture, animals, jewellery, furniture)"
lab var m1_1220_5 "1220. Family members or friends from outside the household"
lab var m1_1220_6 "1220. Borrowed (from someone other than a friend or family)"
lab var m1_1220_96 "1220. Other (specify)"
lab var m1_1220_888_et "1220. Unknown"
lab var m1_1220_998_et "1220. Refuse to answer"
lab var m1_1220_999_et "1220. No information"
lab var m1_1220_other "1220_Other. Specify other financial source for household use to pay for this"
lab var m1_1221 "1221. Are you covered with a health insurance?"
lab var m1_1222 "1222. What type of health insurance coverage do you have?"
lab var m1_1222_other "1222_Other. Specify other health insurance"
lab var m1_1223 "1223. To conclude this survey, overall, please tell me how satisfied you are with the health services you received at this establishment today?"
lab var height_cm "Height in centimeters"
lab var weight_kg "Weight in kilograms"
lab var bp_time_1_systolic "Time 1 (Systolic)"
lab var bp_time_1_diastolic "Time 1 (Diastolic)"
lab var time_1_pulse_rate "Time 1 (Pulse Rate)"
lab var bp_time_2_systolic "Time 2 (Systolic)"
lab var bp_time_2_diastolic "Time 2 (Diastolic)"
lab var time_2_pulse_rate "Time 2 (Heart Rate)"
lab var bp_time_3_systolic "Time 3 (Systolic)"
lab var bp_time_3_diastolic "Time 3 (Diastolic)"
lab var pulse_rate_time_3 "Time 3 (Heart Rate)"
lab var muac "Measured Upper arm circumference"
lab var m1_1306 "1306. Hemoglobin level available in maternal health card"
lab var m1_1307 "1307. HEMOGLOBIN LEVEL FROM MATERNAL HEALTH CARD "
lab var m1_1308 "1308. Will you take the anemia test?"
lab var m1_1309 "1309. HEMOGLOBIN LEVEL FROM TEST PERFORMED BY DATA COLLECTOR"
lab var m1_1401 "1401. What period of the day is most convenient for you to answer the phone survey?"
lab var m1_1402_1_et "1402. Which is the best phone number to use to contact you: The phone provided for the study"
lab var m1_1402_2_et "1402. Which is the best phone number to use to contact you: Primary personal phone"
lab var m1_1402_3_et "1402. Which is the best phone number to use to contact you: Secondary personal phone"
lab var m1_1402_4_et "1402. Which is the best phone number to use to contact you: Spouse or partner phone"
lab var m1_1402_5_et "1402. Which is the best phone number to use to contact you: Community health worker phone"
lab var m1_1402_6_et "1402. Which is the best phone number to use to contact you: Friend or other family member phone 1 "
lab var m1_1402_7_et "1402. Which is the best phone number to use to contact you: Friend or other family member phone 2"
lab var m1_1402_8_et "1402. Which is the best phone number to use to contact you: Other phone"
lab var m1_1402_9_et "1402. Which is the best phone number to use to contact you: Does not have any phone numbers"
lab var m1_1402_888_et "1402. Unknown"
lab var m1_1402_998_et "1402. Refuse to answer"
lab var m1_1402_999_et "1402. No information"
lab var m1_end_time "Interview end time"
lab var interview_length "Total Duration of interview"
lab var m1_complete "Complete?"


	** MODULE 2:
label variable m2_attempt_date "CALL TRACKING: What is the date of this attempt?"
label variable m2_attempt_outcome "CALL TRACKING: What was the outcome of the call?"
label variable m2_attempt_relationship "Interviewer read: Hello, my name is [your name] and I work with EPHI, I would like to talk with [what_is_your_first_name_101] [what_is_your_family_name_102]. A6. May I Know what the relationship between you and [what_is_your_first_name_101] [what_is_your_family_name_102]?"
label variable m2_attempt_other "CALL TRACKING: Specify other relationship with the respondent"
label variable m2_attempt_avail "CALL TRACKING: Is [what_is_your_first_name_101] [what_is_your_family_name_102] nearby and available to speak now?   Can you pass the phone to them?"
label variable m2_attempt_contact "CALL TRACKING: Is this still the best contact to reach [what_is_your_first_name_101] [what_is_your_family_name_102]?"
label variable m2_attempt_bestnumber "CALL TRACKING: Could you please share the best number to contact [what_is_your_first_name_101] [what_is_your_family_name_102]"
label variable m2_attempt_goodtime "CALL TRACKING: Do you know when would be a good time to reach [what_is_your_first_name_101] [what_is_your_family_name_102]?"
label variable m2_start "IIC. May I proceed with the interview?"
label variable m2_103 "102. Date of interview (D-M-Y)"
label variable m2_permission "CR1. Permission granted to conduct call"
label variable m2_date "102. Date of interview (D-M-Y)"
label variable m2_time_start "103A. Time of interview started"
label variable maternal_death_reported "108. Maternal death reported"
label variable m2_ga "107a. Gestational age at this call based on LNMP (in weeks)"
label variable m2_ga_estimate "107b. Gestational age based on maternal estimation (in weeks)"
label variable m2_hiv_status "109. HIV status"
label variable date_of_maternal_death "110. Date of maternal death (D-M-Y)"
label variable m2_maternal_death_learn "111. How did you learn about the maternal death?"
label variable m2_maternal_death_learn_other "111-Oth. Specify other way of learning maternal death"
label variable m2_201 "201. I would like to start by asking about your health and how you have been feeling since you last spoke to us. In general, how would you rate your overall health?"
label variable m2_202 "202. As you know, this survey is about health care that women receive during pregnancy, delivery and after birth. So that I know that I am asking the right questions, I need to confirm whether you are still pregnant?"
label variable m2_date_of_maternal_death_2 "110. Date of maternal death (D-M-Y)"
label variable m2_203a "203a. Since you last spoke to us, have you experienced severe or persistent headaches?"
label variable m2_203b "203b. Since you last spoke to us, have you experienced vaginal bleeding of any amount?"
label variable m2_203c "203c. Since you last spoke to us, have you experienced fever?"
label variable m2_203d "203d. Since you last spoke to us, have you experiencedsevere abdominal pain, not just discomfort?"
label variable m2_203e "203e. Since you last spoke to us, have you experienced a lot of difficult breathing?"
label variable m2_203f "203f. Since you last spoke to us, have you experienced convulsions or seizures?"
label variable m2_203g "203g. Since you last spoke to us, have you experienced fainting or loss of consciousness?"
label variable m2_203h "203h. Since you last spoke to us, have you experienced that the baby has completely stopped moving?"
label variable m2_203i "203i. Since you last spoke to us, have you experienced blurring of vision?"
label variable m2_204a "204a. Since you last spoke to us, have you experienced Preeclapsia/eclampsia?"
label variable m2_204b "204b. Since you last spoke to us, have you experienced Bleeding during pregnancy?"
label variable m2_204c "204c. Since you last spoke to us, have you experienced Hyperemesis gravidarum?"
label variable m2_204d "204d. Since you last spoke to us, have you experienced Anemia?"
label variable m2_204e "204e. Since you last spoke to us, have you experienced Cardiac problem?"
label variable m2_204f "204f. Since you last spoke to us, have you experienced Amniotic fluid volume problems(Oligohydramnios/ Polyhadramnios)?"
label variable m2_204g "204g. Since you last spoke to us, have you experienced Asthma?"
label variable m2_204h "204h. Since you last spoke to us, have you experienced RH isoimmunization?"
label variable m2_204i "204i. Since you last spoke to us, have you experienced any other major health problems?"
label variable m2_204i_other "204i-oth. Specify any other feeling since last visit"
label variable m2_205a "205a. Over the past 2 weeks, on how many days have you been bothered by little interest or pleasure in doing things?"
label variable m2_205b "205b. Over the past 2 weeks, on how many days have you been bothered by feeling down, depressed, or hopeless?"
label variable m2_205c "205c. Over the past 2 weeks, on how many days have you been bothered by trouble falling or staying asleep, or sleeping too much?"
label variable m2_205d "205d. Over the past 2 weeks, on how many days have you been bothered by feeling tired or having little energy?"
label variable m2_205e "205e. Over the past 2 weeks, on how many days have you been bothered by poor appetite or overeating?"
label variable m2_205f "205f. Over the past 2 weeks, on how many days have you been bothered by feeling bad about yourself or that you are a failure or have let yourself or your family down?"
label variable m2_205g "205g. Over the past 2 weeks, on how many days have you been bothered by trouble concentrating on things, such as your work or home duties?"
label variable m2_205h "205h. Over the past 2 weeks, on how many days have you been bothered by moving or speaking so slowly that other people could have noticed? Or so fidgety or restless that you have been moving a lot more than usual?"
label variable m2_205i "205i. Over the past 2 weeks, on how many days have you been bothered by Thoughts that you would be better off dead, or thoughts of hurting yourself in some way?"
label variable m2_206 "206. How often do you currently smoke cigarettes or use any other type of tobacco? Types of tobacco includes: Snuff tobacco, Chewing tobacco,  Cigar"
label variable m2_207 "207. How often do you currently chewing khat?(Interviewer: Inform that Khat is a leaf green plant use as stimulant and chewed in Ethiopia)"
label variable m2_208 "208. How often do you currently drink alcohol or use any other type of alcoholic?   A standard drink is any drink containing about 10g of alcohol, 1 standard drink= 1 tasa or wancha of (tella or korefe or borde or shameta), ½ birile of  Tej, 1 melekiya of Areke, 1 bottle of beer, 1 single of draft, 1 melkiya of spris(Uzo, Gine, Biheraw etc) and 1 melekiya of Apratives"
label variable m2_301 "301. Since we last spoke, did you have any new healthcare consultations for yourself, or not?"
label variable m2_302 "302. Since we last spoke, how many new healthcare consultations have you had for yourself?"
label variable m2_303a "303a. Where did this/this new first healthcare consultation(s) for yourself take place?"
label variable m2_303b "303b.  Where did the 2nd healthcare consultation(s) for yourself take place?"
label variable m2_303c "303c. Where did the 3rd healthcare consultation(s) for yourself take place?"
label variable m2_303d "303d. Where did the 4th healthcare consultation(s) for yourself take place?"
label variable m2_303e "303e. Where did the 5th healthcare consultation(s) for yourself take place?"
label variable m2_304a "304a. What is the name of the facility where this/this first healthcare consultation took place?"
label variable m2_304a_other "304a-oth. Other facility for 1st health consultation"
label variable m2_304b "304b. What is the name of the facility where this/this second healthcare consultation took place?"
label variable m2_304b_other "304b-oth. Other facility for 2nd health consultation"
label variable m2_304c "304c. What is the name of the facility where this/this third healthcare consultation took place?"
label variable m2_304c_other "304c-oth. Other facility for 3rd health consultation"
label variable m2_304d "304d. What is the name of the facility where this/this fourth healthcare consultation took place?"
label variable m2_304d_other "304d-oth. Other facility for 4th health consultation"
label variable m2_304e "304e. What is the name of the facility where this/this fifth healthcare consultation took place?"
label variable m2_304e_other "304e-oth. Other facility for 5th health consultation"
label variable m2_305 "305. Was the first consultation for a routine antenatal care visit?"
label variable m2_306 "306. Was the first consultation for a referral from your antenatal care provider?"
label variable m2_306_1 "307. Was the first consultation for any of the following? A new health problem, including an emergency or an injury"
label variable m2_306_2 "307. Was the first consultation for any of the following? An existing health problem"
label variable m2_306_3 "307. Was the first consultation for any of the following? A lab test, x-ray, or ultrasound"
label variable m2_306_4 "307. Was the first consultation for any of the following? To pick up medicine"
label variable m2_306_5 "307. Was the first consultation for any of the following? To get a vaccine"
label variable m2_306_96 "307. Was the first consultation for any of the following? Other reasons"
label variable m2_306_888_et "307. No information"
label variable m2_306_998_et "307. Unknown"
label variable m2_306_999_et "307. Refuse to answer"
label variable m2_307_other "307-oth. Specify other reason for the 1st visit"
label variable m2_308 "308. Was the second consultation is for a routine antenatal care visit?"
label variable m2_309 "309. Was the second consultation is for a referral from your antenatal care provider?"
label variable m2_308_1 "310. Was the second consultation for any of the following? A new health problem, including an emergency or an injury"
label variable m2_308_2 "310. Was the second consultation for any of the following? An existing health problem"
label variable m2_308_3 "310. Was the second consultation for any of the following? A lab test, x-ray, or ultrasound"
label variable m2_308_4 "310. Was the second consultation for any of the following? To pick up medicine"
label variable m2_308_5 "310. Was the second consultation for any of the following? To get a vaccine"
label variable m2_308_96 "310. Was the second consultation for any of the following? Other reasons"
label variable m2_308_888_et "310. No information"
label variable m2_308_998_et "310. Unknown"
label variable m2_308_999_et "310. Refuse to answer"
label variable m2_310_other "310-oth. Specify other reason for second consultation"
label variable m2_311 "311. Was the third consultation is for a routine antenatal care visit?"
label variable m2_312 "312. Was the third consultation is for a referral from your antenatal care provider?"
label variable m2_311_1 "313. Was the third consultation for any of the following? A new health problem, including an emergency or an injury"
label variable m2_311_2 "313. Was the third consultation for any of the following? An existing health problem"
label variable m2_311_3 "313. Was the third consultation for any of the following? A lab test, x-ray, or ultrasound"
label variable m2_311_4 "313. Was the third consultation for any of the following? To pick up medicine"
label variable m2_311_5 "313. Was the third consultation for any of the following? To get a vaccine"
label variable m2_311_96 "313. Was the third onsultation for any of the following? Other reasons"
label variable m2_311_888_et "313. No information"
label variable m2_311_998_et "313. Unknown"
label variable m2_311_999_et "313. Refuse to answer"
label variable m2_313_other "313-oth. Specify any other reason for the third consultation"
label variable m2_314 "314. Was the fourth consultation is for a routine antenatal care visit?"
label variable m2_315 "315. Was the fourth consultation is for a referral from your antenatal care provider?"
label variable m2_314_1 "316. Was the fourth consultation for any of the following? A new health problem, including an emergency or an injury"
label variable m2_314_2 "316. Was the fourth consultation for any of the following? An existing health problem"
label variable m2_314_3 "316. Was the fourth consultation for any of the following? A lab test, x-ray, or ultrasound"
label variable m2_314_4 "316. Was the fourth consultation for any of the following? To pick up medicine"
label variable m2_314_5 "316. Was the fourth consultation for any of the following? To get a vaccine"
label variable m2_314_96 "316. Was the fourth onsultation for any of the following? Other reasons"
label variable m2_314_888_et "316. No information"
label variable m2_314_998_et "316. Unknown"
label variable m2_314_999_et "316. Refuse to answer"
label variable m2_316_other "316-oth. Specify other reason for the fourth consultation"
label variable m2_317 "317. Was the fifth consultation is for a routine antenatal care visit?"
label variable m2_318 "318. Was the fifth consultation is for a referral from your antenatal care provider?"
label variable m2_317_1 "319. Was the fifth consultation is for any of the following? A new health problem, including an emergency or an injury"
label variable m2_317_2 "319. Was the fifth consultation is for any of the following? An existing health problem"
label variable m2_317_3 "319. Was the fifth consultation is for any of the following? A lab test, x-ray, or ultrasound"
label variable m2_317_4 "319. Was the fifth consultation is for any of the following? To pick up medicine"
label variable m2_317_5 "319. Was the fifth consultation is for any of the following? To get a vaccine"
label variable m2_317_96 "319. Was the fifth consultation is for any of the following? Other reasons"
label variable m2_317_888_et "319. No information"
label variable m2_317_998_et "319. Unknown"
label variable m2_317_999_et "319. Refuse to answer"
label variable m2_319_other "319-oth. Specify other reason for the fifth consultation"
label variable m2_320_0 "320. Are there any reasons that prevented you from receiving more antenatal care since you last spoke to us? No reason or you didn't need it"
label variable m2_320_1 "320. Are there any reasons that prevented you from receiving more antenatal care since you last spoke to us? You tried but were sent away (e.g., no appointment available) "
label variable m2_320_2 "320. Are there any reasons that prevented you from receiving more antenatal care since you last spoke to us? High cost (e.g., high out of pocket payment, not covered by insurance)"
label variable m2_320_3 "320. Are there any reasons that prevented you from receiving more antenatal care since you last spoke to us? Far distance (e.g., too far to walk or drive, transport not readily available)"
label variable m2_320_4 "320. Are there any reasons that prevented you from receiving more antenatal care since you last spoke to us? Long waiting time (e.g., long line to access facility, long wait for the provider)"
label variable m2_320_5 "320. Are there any reasons that prevented you from receiving more antenatal care since you last spoke to us? Poor healthcare provider skills (e.g., spent too little time with patient, did not conduct a thorough exam)"
label variable m2_320_6 "320. Are there any reasons that prevented you from receiving more antenatal care since you last spoke to us? Staff don't show respect (e.g., staff is rude, impolite, dismissive)"
label variable m2_320_7 "320. Are there any reasons that prevented you from receiving more antenatal care since you last spoke to us? Medicines or equipment are not available (e.g., medicines regularly out of stock, equipment like X-ray machines broken or unavailable)"
label variable m2_320_8 "320. Are there any reasons that prevented you from receiving more antenatal care since you last spoke to us? COVID-19 restrictions (e.g., lockdowns, travel restrictions, curfews) "
label variable m2_320_9 "320. Are there any reasons that prevented you from receiving more antenatal care since you last spoke to us? COVID-19 fear"
label variable m2_320_10 "320. Are there any reasons that prevented you from receiving more antenatal care since you last spoke to us? Don't know where to go/too complicated"
label variable m2_320_11 "320. Are there any reasons that prevented you from receiving more antenatal care since you last spoke to us? Fear of discovering serious problem"
label variable m2_320_96 "320. Are there any reasons that prevented you from receiving more antenatal care since you last spoke to us? Other, specify"
label variable m2_320_99 "320. Are there any reasons that prevented you from receiving more antenatal care since you last spoke to us? Refused"
label variable m2_320_888_et "320. No information"
label variable m2_320_998_et "320. Unknown"
label variable m2_320_999_et "320. Refuse to answer"
label variable m2_320_other "320-oth. Specify other reason preventing receiving more antenatal care"
label variable m2_321 "321. Other than in-person visits, did you have contacted with a health care provider by phone, SMS, or web regarding your pregnancy?"
label variable m2_401 "401. Overall, how would you rate the quality of care that you received from the health facility where you took the 1st consultation?"
label variable m2_402 "402. Overall, how would you rate the quality of care that you received from the health facility where you took the 2nd consultation?"
label variable m2_403 "403. Overall, how would you rate the quality of care that you received from the health facility where you took the 3rd consultation?"
label variable m2_404 "404. Overall, how would you rate the quality of care that you received from the health facility where you took the 4th consultation?"
label variable m2_405 "405. Overall, how would you rate the quality of care that you received from the health facility where you took the 5th consultation?"
label variable m2_501a "501a. Since you last spoke to us, did you get your blood pressure measured (with a cuff around your arm)?"
label variable m2_501b "501b. Since you last spoke to us, did you get your weight taken (using a scale)?"
label variable m2_501c "501c.  Since you last spoke to us, did you get a blood draw (that is, taking blood from your arm with a syringe)?"
label variable m2_501d "501d.  Since you last spoke to us, did you get a blood test using a finger prick (that is, taking a drop of blood from your finger)?"
label variable m2_501e "501e.  Since you last spoke to us, did you get a urine test (that is, where you peed in a container)?"
label variable m2_501f "501f. Since you last spoke to us, did you get an ultrasound (that is, when a probe is moved on your belly to produce a video of the baby on a screen)?"
label variable m2_501g "501g.  Since you last spoke to us, did you get any other tests?"
label variable m2_501g_other "501g-oth. Specify any other test you took since you last spoke to us"
label variable m2_502 "502. Since we last spoke, did you receive any new test results from a health care provider?   By that I mean, any result from a blood or urine sample or from blood pressure measurement.Do not include any results that were given to you during your first antenatal care visit or during the first survey, only new ones."
label variable m2_503a "503a. Remember that this information will remain confidential. Did you receive a result for Anemia?"
label variable m2_503b "503b. Remember that this information will remain confidential. Did you receive a result for HIV?"
label variable m2_503c "503c. Remember that this information will remain confidential. Did you receive a result for HIV viral load?"
label variable m2_503d "503d. Remember that this information will remain confidential. Did you receive a result for Syphilis?"
label variable m2_503e "503e. Remember that this information will remain confidential. Did you receive a result for diabetes?"
label variable m2_503f "503f. Remember that this information will remain confidential. Did you receive a result for Hypertension?"
label variable m2_504 "504. Did you receive any other new test results?"
label variable m2_504_other "504-oth. Specify other test result you receive"
label variable m2_505a "505a. What was the result of the test for anemia? Remember that this information will remain fully confidential."
label variable m2_505b "505b. What was the result of the test for HIV? Remember that this information will remain fully confidential."
label variable m2_505c "505c. What was the result of the test for HIV viral load? Remember that this information will remain fully confidential."
label variable m2_505d "505d. What was the result of the test for syphilis? Remember that this information will remain fully confidential."
label variable m2_505e "505e. What was the result of the test for diabetes? Remember that this information will remain fully confidential."
label variable m2_505f "505f. What was the result of the test for hypertension? Remember that this information will remain fully confidential."
label variable m2_505g "505g. What was the result of the test for other tests? Remember that this information will remain fully confidential."
label variable m2_506a "506a. Since you last spoke to us, did you and a healthcare provider discuss about the signs of pregnancy complications that would require you to go to the health facility?"
label variable m2_506b "506b. Since you last spoke to us, did you and a healthcare provider discuss about your birth plan that is, where you will deliver, how you will get there, and how you need to prepare, or didnt you?"
label variable m2_506c "506c. Since you last spoke to us, did you and a healthcare provider discuss about care for the newborn when he or she is born such as warmth, hygiene, breastfeeding, or the importance of postnatal care?"
label variable m2_506d "506d. Since you last spoke to us, did you and a healthcare provider discuss about family planning options for after delivery?"
label variable m2_507 "507. What did the health care provider tell you to do regarding these new symptoms?"
label variable m2_508a "508a. Since we last spoke, did you have a session of psychological counseling or therapy with any type of professional?  This could include seeing a mental health professional (like a phycologist, social worker, nurse, spiritual advisor or healer) for problems with your emotions or nerves."
label variable m2_508b_number "508b. Do you know the number of psychological counseling or therapy session you had?"
label variable m2_508b_last "508b. How many of these sessions did you have since you last spoke to us?"
label variable m2_508c "508c. Do you know how long this/these visits took?"
label variable m2_508d "508d. How many minutes did this/these visit(s) last on average?"
label variable m2_509a "509a.  Since we last spoke, did a healthcare provider tells you that you needed to go see a specialist like an obstetrician or a gynecologist?"
label variable m2_509b "509b. Since we last spoke, did a healthcare provider tells you that you needed to go to the hospital for follow-up antenatal care?"
label variable m2_509c "509c. Since we last spoke, did a healthcare provider tell you that you will need a C-section?"
label variable m2_601a "601a. Did you get Iron or folic acid pills?"
label variable m2_601b "601b. Did you get Calcium pills?"
label variable m2_601c "601c. Did you get Multivitamins?"
label variable m2_601d "601d. Did you get Food supplements like Super Cereal or Plumpynut?"
label variable m2_601e "601e. Did you get medicine for intestinal worm?"
label variable m2_601f "601f. Did you get medicine for malaria?"
label variable m2_601g "601g. Did you get Medicine for HIV?"
label variable m2_601h "601h. Did you get Medicine for your emotions, nerves, depression, or mental health?"
label variable m2_601i "601i. Did you get Medicine for hypertension?"
label variable m2_601j "601j. Did you get Medicine for diabetes, including injections of insulin?"
label variable m2_601k "601k. Did you get Antibiotics for an infection?"
label variable m2_601l "601l. Did you get Aspirin?"
label variable m2_601m "601m. Did you get Paracetamol, or other pain relief drugs?"
label variable m2_601n "601n. Did you get Any other medicine or supplement?"
label variable m2_601n_other "601n-oth. Specify other medicine or supplement you took"
label variable m2_602a "602a. Do you know how much in total you pay for this new medication?"
label variable m2_602b "602b. In total, how much did you pay for these new medications or supplements (ETB)?"
label variable m2_603 "603. Are you currently taking iron and folic acid pills, or not?"
label variable m2_604 "604. How often do you take iron and folic acid pills?"
label variable m2_701 "701. I would now like to ask about the cost of these new health care visits.  Did you pay any money out of your pocket for these new visits, including for the consultation or other indirect costs like your transport to the facility?  Do not include the cost of medicines that you have already told me about."
label variable m2_702a "702a. Did you spend money on Registration/Consultation?"
label variable m2_702a_other "702a-oth. How much money did you spend on Registration/Consultation?"
label variable m2_702b "702b. Did you spend money on Test or investigations (lab tests, ultrasound etc.?"
label variable m2_702b_other "702b-oth. How much money did you spend on Test or investigations (lab tests, ultrasound etc.)"
label variable m2_702c "702c. Did you spend money on Transport (round trip) including that of the person accompanying you?"
label variable m2_702c_other "702c-oth. How much money did you spend on Transport (round trip) including that of the person accompanying you?"
label variable m2_702d "702d. Did you spend money on Food and accommodation including that of person accompanying you?"
label variable m2_702d_other "702d-oth. How much money did you spend on Food and accommodation including that of person accompanying you?"
label variable m2_702e "702e. Did you spend money for other services?"
label variable m2_702e_other "702e-oth. How much money did you spend on other item/service?"
label variable m2_703 "703. So, in total you spent"
label variable m2_704 "704. Is the total cost correct?"
label variable m2_704_other "704-oth. So how much in total would you say you spent?"
label variable m2_705_1 "705. Which of the following financial sources did your household use to pay for this? Current income of any household members"
label variable m2_705_2 "705. Which of the following financial sources did your household use to pay for this? Savings (e.g., bank account)"
label variable m2_705_3 "705. Which of the following financial sources did your household use to pay for this? Payment or reimbursement from a health insurance plan"
label variable m2_705_4 "705. Which of the following financial sources did your household use to pay for this? Sold items (e.g., furniture, animals, jewellery, furniture)"
label variable m2_705_5 "705. Which of the following financial sources did your household use to pay for this? Family members or friends from outside the household"
label variable m2_705_6 "705. Which of the following financial sources did your household use to pay for this? Borrowed (from someone other than a friend or family)"
label variable m2_705_96 "705. Which of the following financial sources did your household use to pay for this? Other (please specify)"
label variable m2_705_888_et "705. No information"
label variable m2_705_998_et "705. Unknown"
label variable m2_705_999_et "705. Refuse to answer"
label variable m2_705_other "705-oth. Please specify"
label variable m2_interview_inturrupt "Is the interview inturrupted?"
label variable m2_interupt_time "At what time it is interrupted?"
label variable m2_interview_restarted "Is the interview restarted?"
label variable m2_restart_time "At what time it is restarted?"
label variable m2_endtime "103B. Time of Interview end"
label variable m2_int_duration "103C. Total Duration of interview (In minutes)"
label variable m2_endstatus "What is this womens current status at the end of the interview?"
label variable m2_complete "Complete?"

*===============================================================================

	* STEP FIVE: ORDER VARIABLES
	
*===============================================================================

	* STEP SIX: SAVE DATA TO RECODED FOLDER
	* note: as of 7-27 we are dropping M3-M5 data until it is cleaned
	
* drop unncessary vars and de-identify dataset
drop iic_3-module_5_end_line_facetoface_sur first_name family_name phone_number m1_513b ///
     m1_513c m1_513d m1_513e m1_513f m1_513g m1_513h m1_513i m1_514b m1_515a_town ///
	 m1_515b_zone m1_515c_ward m1_515d_house m1_516 m1_517 m1_518 m1_519_district ///
	 m1_519_village m1_519_ward q1501 age gravid lmp edd para ///
	 number_of_children_alive previous_stillbirth history_of_3 birthweight2500 birthweight4000 ///
	 last_pregnancy previous_survey diagnosed age_less_than_16_years-maternal_integrated_cards_comple ///
	 m1_714d date 	 
	 
	 
order m1_* m2_*, sequential

order m2_start m2_date m2_date m2_permission m2_103 m2_time_start m2_maternal_death_reported m2_ga m2_ga_estimate m2_hiv_status ///
	 m2_date_of_maternal_death m2_maternal_death_learn m2_maternal_death_learn_other m2_111 m2_111_other m2_201,after(m1_end_time)

order height_cm weight_kg bp_time_1_systolic bp_time_1_diastolic time_1_pulse_rate bp_time_2_systolic bp_time_2_diastolic time_2_pulse_rate bp_time_3_systolic bp_time_3_diastolic pulse_rate_time_3 muac m1_1306 m1_1307 m1_1309,after(m1_1223)


order phq9a phq9b phq9c phq9d phq9e phq9f phq9g phq9h phq9i, after(m1_205e)

order country redcap_record_id study_id interviewer_name_a7 redcap_event_name redcap_repeat_instrument redcap_repeat_instance redcap_data_access_group date_m1 m1_start_time country site study_site study_site_sd facility facility_other sampstrata facility_type permission care_self  site sampstrata study_site study_site_sd facility interviewer_id date_m1 m1_start_time permission ////
care_self enrollage zone_live b5anc b6anc_first b6anc_first_conf continuecare b7eligible respondentid mobile_phone flash kebele_malaria kebele_intworm

*===============================================================================

save "$et_data_final/eco_m1m2_et.dta", replace
	