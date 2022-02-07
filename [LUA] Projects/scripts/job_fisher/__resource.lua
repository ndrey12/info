resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

client_script 
{
    "@RageUI-2.1/RMenu.lua",
    "@RageUI-2.1/menu/RageUI.lua",
    "@RageUI-2.1/menu/Menu.lua",
    "@RageUI-2.1/menu/MenuController.lua",
    
    "@RageUI-2.1/components/Audio.lua",
    "@RageUI-2.1/components/Enum.lua",
    "@RageUI-2.1/components/Keys.lua",
    "@RageUI-2.1/components/Rectangle.lua",
    "@RageUI-2.1/components/Sprite.lua",
    "@RageUI-2.1/components/Text.lua",
    "@RageUI-2.1/components/Visual.lua",    
    
    "@RageUI-2.1/menu/elements/ItemsBadge.lua",
    "@RageUI-2.1/menu/elements/ItemsColour.lua",
    "@RageUI-2.1/menu/elements/PanelColour.lua",
    
    "@RageUI-2.1/menu/items/UIButton.lua",
    "@RageUI-2.1/menu/items/UICheckBox.lua",
    "@RageUI-2.1/menu/items/UIList.lua",
    "@RageUI-2.1/menu/items/UISeparator.lua",
    "@RageUI-2.1/menu/items/UISlider.lua",
    "@RageUI-2.1/menu/items/UISliderHeritage.lua",
    "@RageUI-2.1/menu/items/UISliderProgress.lua",    

    "@RageUI-2.1/menu/panels/UIColourPanel.lua",
    "@RageUI-2.1/menu/panels/UIGridPanel.lua",
    "@RageUI-2.1/menu/panels/UIPercentagePanel.lua",
    "@RageUI-2.1/menu/panels/UISpritPanel.lua",
    "@RageUI-2.1/menu/panels/UIStatisticsPanel.lua",
    
    "@RageUI-2.1/menu/windows/UIHeritage.lua",
    "job_fisher-c.lua"
}
server_scripts 
{
    "@ghmattimysql/ghmattimysql-server.lua",
    "job_fisher-s.lua"

}
dependency 'playerdata'
dependency 'sis_business'
