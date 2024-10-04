import UIKit

struct ConfigureModel : Codable {
    let vpnServers : [VpnServers]?
    let colors : Colors?
    let images : Images?
    let texts : Texts?
}

struct VpnServers : Codable, Equatable {
    let id : String?
    let countryName : String?
    let countryImageMax : String?
    let countryImageMin : String?
    let ip : String?
    let ipsecPsk : String?
    let username : String?
    let password : String?
    var isPay: Bool? = false
}

struct Images : Codable {
    let startupBackground : String?
    let centralLogo : String?
    let onboard1 : String?
    let onboard2 : String?
    let onboard3 : String?
    let vpnService: String?
    let vpnServiceSelected: String?
    let deviceSearch: String?
    let deviceSearchSelected: String?
    let passwordSecurity: String?
    let passwordSecuritySelected: String?
    let options: String?
    let optionsSelected: String?
    let shield: String?
    let сhooseServerBackButton: String?
    let dots: String?
    let serverNotSelected: String?
    let connectedImage: String?
    let disconnectedImage: String?
    let swipeToConnect: String?
    let swipeToDisconnect: String?
    let plus: String?
    
    
    let aboutApOptionIMG : String?
    let adsFeatureIMG : String?
    let analizingWifiIMG : String?
    let appOneAds : String?
    let appThreeAds : String?
    let appTwoAds : String?
    let arrowOptionIMG : String?
    let backgroundUnlimitedVpnIMG : String?
    let bannerOptionIMG : String?
    let centerChangeIMG : String?
    let checkPlanIMG : String?
    let checkUnlimitedVpnIMG : String?
    let closeUnlimitedVpnIMG : String?
    let cubeStatisticIMG : String?
    let deleteIMG : String?
    let docOptionIMG : String?
    let emptyLinkVaultIMG : String?
    let emptyScannerIMG : String?
    let emptyStatisitcIMG : String?
    let fourOnbIMG : String?
    let indicatorStatisticIMG : String?
    let infoIMG : String?
    let loaderLaunchIMG : String?
    let nameLinkIMG : String?
    let noAccessIMG : String?
    let oneOnbIMG : String?
    let openLinkIMG : String?
    let openSettingWifiIMG : String?
    let settingTabBarIMG : String?
    let shieldBigVpnIMG : String?
    let shieldVpnIMG : String?
    let siteFeatureIMG : String?
    let starsIMG : String?
    let statisticTabBarIMG : String?
    let supportOptionIMG : String?
    let swipeLeftVpnIMG : String?
    let swipeRightVpnIMG : String?
    let threeOnbIMG : String?
    let twoOnbIMG : String?
    let urlLinkIMG : String?
    let vaultTabBarIMG : String?
    let vpnTabBarIMG : String?
    let wifiAnilizingIconIMG : String?
    let wifiOptionIMG : String?
    let wifiScanFeatureIMG : String?
}

struct Colors : Codable {
    let loadingBar : String?
    let loadingIndicator : String?
}

struct Texts : Codable {
    let other_cancel_subscription : String?
    let tab_bar_options : String?
    let tab_bar_statisctics : String?
    let tab_bar_vault : String?
    let tab_bar_vpn : String?
    let onboard_load : String?
    let onboard_month : String?
    let onboard_continue : String?
    let onboard_text : String?
    let onboard_one_title : String?
    let onboard_one_sub_title : String?
    let onboard_two_title : String?
    let onboard_two_sub_title : String?
    let onboard_three_title : String?
    let onboard_three_sub_title : String?
    let onboard_four_title : String?
    let onboard_four_sub_title : String?
    let vpn_service_daily_limit : String?
    let vpn_service_disconnected : String?
    let vpn_service_connected : String?
    let vpn_service_swipe_right : String?
    let vpn_service_swipe_left : String?
    let vpn_service_connect : String?
    let vpn_service_vip : String?
    let vpn_service_selected : String?
    let connecting_to_title : String?
    let connecting_to_connection : String?
    let server_change_title : String?
    let server_change_change : String?
    let server_change_cancel : String?
    let automatic_redirection_title : String?
    let automatic_redirection_follow : String?
    let automatic_redirection_redirection : String?
    let link_vault_auto_connect : String?
    let link_vault_open_link : String?
    let link_vault_empty_title : String?
    let link_vault_empty_sub_title : String?
    let link_vault_connected : String?
    let link_vault_disconnected : String?
    let link_vault_title : String?
    let add_link_after_connecting : String?
    let add_link_url : String?
    let add_link_link_title : String?
    let add_link_enter_url : String?
    let add_link_enter_title : String?
    let add_link_save : String?
    let add_link_cancel : String?
    let add_link_add : String?
    let edit_link_close : String?
    let edit_link_cancel : String?
    let edit_link_edit : String?
    let edit_link_edit_bt : String?
    let replace_link_title : String?
    let replace_link_replace : String?
    let replace_link_leave : String?
    let delete_link_title : String?
    let delete_link_cancel : String?
    let delete_link_delete : String?
    let info_automatic_link_title : String?
    let info_automatic_link_continue : String?
    let statistics_title : String?
    let statistics_usage_time : String?
    let statistics_favorite_server : String?
    let statistics_average_time : String?
    let statistics_enough_information : String?
    let statistics_in : String?
    let statistics_days : String?
    let statistics_day : String?
    let plans_one_title : String?
    let plans_two_title : String?
    let plans_one_one_cell : String?
    let plans_one_two_cell : String?
    let plans_one_three_cell : String?
    let plans_two_two_cell : String?
    let plans_three_two_cell : String?
    let plans_learn : String?
    let plans_cancel : String?
    let plans_plans : String?
    let unlimited_vpn_plan_load : String?
    let unlimited_vpn_plan_month : String?
    let unlimited_vpn_plan_privacy : String?
    let unlimited_vpn_plan_terms : String?
    let unlimited_vpn_plan_restore : String?
    let unlimited_vpn_plan_title : String?
    let unlimited_vpn_plan_sub_title : String?
    let unlimited_vpn_plan_anytime : String?
    let unlimited_vpn_plan_continue : String?
    let unlimited_vpn_plan_text : String?
    let unlimited_vpn_plan_one_cell : String?
    let unlimited_vpn_plan_two_cell : String?
    let unlimited_vpn_plan_three_cell : String?
    let unlimited_vpn_plan_one_comment_title : String?
    let unlimited_vpn_plan_one_comment_sub_title : String?
    let unlimited_vpn_plan_two_comment_title : String?
    let unlimited_vpn_plan_three_comment_title : String?
    let unlimited_vpn_plan_two_comment_sub_title : String?
    let unlimited_vpn_plan_three_comment_sub_title : String?
    let features_plan_load : String?
    let features_plan_month : String?
    let features_plan_cancel : String?
    let features_plan_title : String?
    let features_plan_continue : String?
    let features_plan_text : String?
    let features_plan_one_cell : String?
    let features_plan_two_cell : String?
    let features_plan_three_cell : String?
    let analizing_wifi_permission : String?
    let analizing_wifi_access : String?
    let analizing_wifi_feature : String?
    let analizing_wifi_available : String?
    let analizing_wifi_information : String?
    let analizing_wifi_free : String?
    let analizing_wifi_cancel : String?
    let analizing_wifi_title : String?
    let analizing_wifi_start : String?
    let analizing_wifi_unlock : String?
    let analizing_wifi_loader : String?
    let analizing_wifi_no_name : String?
    let info_amalizing_wifi_title : String?
    let info_amalizing_wifi_bt : String?
    let open_setting_wifi_title : String?
    let open_setting_wifi_bt : String?
    let options_analizing_wifi : String?
    let options_about_app : String?
    let options_terms : String?
    let options_privacy : String?
    let options_contact : String?
    let options_view_plans : String?
    let options_banner_title : String?
    let options_options : String?
    let doc_info_privacy_title : String?
    let doc_info_terms_title : String?
    let doc_info_about_title : String?
    let doc_info_privacy_text : String?
    let doc_info_terms_text : String?
    let doc_info_about_text : String?
    let doc_info_cancel : String?
    let contact_support_cancel : String?
    let contact_support_copy : String?
    let contact_support_title : String?
    let contact_support_text : String?
    let new_available : String?
    let new_section : String?
}
