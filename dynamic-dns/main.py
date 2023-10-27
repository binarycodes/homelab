import requests
import json
import argparse

# sync dns records for domains hosted with porkbun


def load_secrets(secret_file_path):
    # expects json structure
    # {'secretapikey': 'xxx', 'apikey': 'xxx'}
    with open(secret_file_path) as secret_file:
        secret = json.load(secret_file)
    return secret


def load_domains(domains_file_path):
    # expects json structure
    # [{'name': 'xxx', 'subdomains': ['xxx', 'xxx', ...]} ...]
    with open(domains_file_path) as domains_file:
        domains = json.load(domains_file)
        data = dict([(domain["name"], domain["subdomains"]) for domain in domains])
    return data


def public_ip():
    response = requests.request("GET", "https://checkip.amazonaws.com/")

    if response.status_code == requests.codes.ok:
        return response.text.strip()

    print(
        "Request to fetch the public ip failed with status code:", response.status_code
    )
    return None


def update_dns_record(domain, sub_domain, public_ip, secret):
    url = f"https://porkbun.com/api/json/v3/dns/editByNameType/{domain}/A/{sub_domain}"

    data = {
        "secretapikey": secret["secretapikey"],
        "apikey": secret["apikey"],
        "content": public_ip,
        "ttl": "600",
    }

    response = requests.post(url, data=json.dumps(data))

    if response.status_code == requests.codes.ok:
        print(f"DNS records updated")
        return True
    else:
        print(
            "Request to update dns record failed with status code:",
            response.status_code,
        )
        print("Reason: ", response.reason)

    return False


def get_current_ip(domain, sub_domain, secret):
    url = f"https://porkbun.com/api/json/v3/dns/retrieveByNameType/{domain}/A/{sub_domain}"

    response = requests.post(url, data=json.dumps(secret))
    if response.status_code == requests.codes.ok:
        records = response.json()["records"]
        if records:
            return records[0]["content"]
        else:
            print(f"No records entry exists for {sub_domain}.{domain}")
            return None

    print(
        "Request to fetch existing dns failed with status code:", response.status_code
    )
    print("Reason:", response.reason)
    return None


def change_my_dns(domain, sub_domain, secret):
    my_ip = public_ip()
    prev_ip = get_current_ip(domain, sub_domain, secret)

    if my_ip is not None and prev_ip is not None:
        if my_ip != prev_ip:
            update_dns_record(domain, sub_domain, my_ip, secret)
        else:
            print("Public IP has not changed since last time")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Sync DNS records in Porkbun")
    parser.add_argument(
        "-a",
        "--api-keys-path",
        dest="api_file",
        type=str,
        required=True,
        help="path of the json file containing the porkbun api keys",
    )
    parser.add_argument(
        "-d",
        "--domains-path",
        dest="domain_file",
        type=str,
        required=True,
        help="path of the json file containing the domain/sub-domains to sync",
    )
    args = parser.parse_args()

    secret = load_secrets(args.api_file)
    domains = load_domains(args.domain_file)

    for domain, sub_domains in domains.items():
        for sub_domain in sub_domains:
            print(f"setting up {sub_domain}.{domain} ...")
            change_my_dns(domain, sub_domain, secret)
