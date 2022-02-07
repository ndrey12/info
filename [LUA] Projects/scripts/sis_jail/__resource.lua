resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

client_script "sis_jail-c.lua"

server_scripts 
{
    "@ghmattimysql/ghmattimysql-server.lua",
    "sis_jail-s.lua"

}
dependency 'playerdata'
dependency 'motiontext'