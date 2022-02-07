resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

client_script 
{
    "sis_houses-c.lua"
}
server_scripts 
{
    "@ghmattimysql/ghmattimysql-server.lua",
    "sis_houses-s.lua"

}
dependency 'playerdata'

server_export 'getPosX'
server_export 'getPosY'
server_export 'getPosZ'