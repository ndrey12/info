resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

client_script 
{
    "job_miner-c.lua"
}
server_scripts 
{
    "@ghmattimysql/ghmattimysql-server.lua",
    "job_miner-s.lua"

}
dependency 'playerdata'
