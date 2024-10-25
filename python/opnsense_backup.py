import json
import requests

# define endpoint and credentials
api_key = '0PlpDa4CTZobNrDi6wF5YYC30upsP26DDRWh8LjOBCgeF7HdlEr1k9S6ZWddp10MSiQQEj1VBhJGfBlq'
api_secret = 'XC87n68GS3xH0gABRJtNhbH+0rJxvcOmuevVNwj8zan532uoTbKnGrN5adyPCoLA++GjaTJ4/D8wv/e8'

url_pattern = 'https://router.homedns.pro/api/{}/{}/{}'

def do_request(module, controller, command):
    url = url_pattern.format(module, controller, command)
    return requests.get(url, auth=(api_key, api_secret))


def check_for_update(module, controller, command):
    r = do_request(module, controller, command)
    if r.status_code == 200:
        response = json.loads(r.text)

        if response['status'] == 'ok':
            print ('OPNsense can be upgraded')
            print ('download size : %s' % response['download_size'])
            print ('number of packages : %s' % response['updates'])

            if response['upgrade_needs_reboot'] == '1':
                print ('REBOOT REQUIRED')
        elif 'status_msg' in response:
            print (response['status_msg'])
    else:
        print ('Connection / Authentication issue, response received:')
        print (r.text)


check_for_update('core','firmware','status')
