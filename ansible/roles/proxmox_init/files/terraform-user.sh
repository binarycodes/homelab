pveum role add TerraformProv -privs "Datastore.AllocateSpace Datastore.Audit Pool.Allocate Sys.Audit Sys.Console Sys.Modify VM.Allocate VM.Audit VM.Clone VM.Config.CDROM VM.Config.Cloudinit VM.Config.CPU VM.Config.Disk VM.Config.HWType VM.Config.Memory VM.Config.Network VM.Config.Options VM.Migrate VM.Monitor VM.PowerMgmt SDN.Use"

pveum user add tfuser@pve
pveum aclmod / -user tfuser@pve -role TerraformProv
pveum user token add tfuser@pve terraform --privsep 0

# Please save the token secret as there isn't any way to fetch it at a later point.
