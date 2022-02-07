resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

client_script 
{
    "job_constructor-c.lua"
}
server_scripts 
{
    "@ghmattimysql/ghmattimysql-server.lua",
    "job_constructor-s.lua"

}
dependency 'playerdata'
