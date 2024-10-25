import base64
import json

def file2base64(filename):
    return base64.b64encode(open(filename, 'rb').read())


cert="homedns.pro_fullchain.cer"
key="homedns.pro_prv.pem"

OutputDict = {
    "certificate": file2base64(cert).decode('utf-8'),
    "key": file2base64(key).decode('utf-8'),
    "Store": 'default',
}


f = open("homedns.pro_json", "w")
f.write(json.dumps(OutputDict, indent=4))
f.close()

cert="proxmox.homedns.pro_fullchain.cer"
key="proxmox.homedns.pro_prv.pem"

OutputDict = {
    "certificate": file2base64(cert).decode('utf-8'),
    "key": file2base64(key).decode('utf-8'),
    "Store": 'default',
}


f = open("proxmox.homedns.pro_json", "w")
f.write(json.dumps(OutputDict, indent=4))
f.close()


key="private_key.key"
OutputDict = {
    "key": file2base64(key).decode('utf-8'),
}

f = open("private_key.key_json", "w")
f.write(json.dumps(OutputDict, indent=4))
f.close()
