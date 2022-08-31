 -- MANIFEST
 resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

 -- GAME
 fx_version "bodacious"
 games {"gta5"}

 -- CLIENT
 client_scripts {
   'nh_cfg.lua',
   'nh_cl.lua'
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',   
   'nh_cfg.lua',
   'nh_sv.lua',
}