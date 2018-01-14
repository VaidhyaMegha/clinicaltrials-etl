import requests

from lxml import html

USERNAME = "sandeep.kunkunuru@gmail.com"
PASSWORD = "Mahalaxmi$7"
APIKEY = "579b464db66ec23bdd0000013909768f85ab43d265ee826acf566584"

LOGIN_URL = "https://auth.mygov.in/user/login?destination=oauth2/authorize"
URL = "https://data.gov.in/ogpl_apis?sort=desc&order=Updated&org_type=Select&sector=Select&org=Select&org_l1=Select&org_l2=Select&page_size=100&ogpl_apis_title="

def main():
    session_requests = requests.session()

    # Get login csrf token
    result = session_requests.get(LOGIN_URL)
    tree = html.fromstring(result.text)

    # Create payload
    payload = {
        "username": USERNAME,
        "password": PASSWORD,
    }

    # Perform login
    result = session_requests.post(LOGIN_URL, data = payload, headers = dict(referer = LOGIN_URL))

    # Scrape url
    result = session_requests.get(URL, headers = dict(referer = URL))
    tree = html.fromstring(result.content)
    bucket_names = tree.xpath("/html/body/div[1]/div[1]/div/div[7]/div/div/section/div/div/div/div/div/table[2]/thead/tr/th[2]/text()")

    #//div[@class='repo-list--repo']/a/text()

    print(bucket_names)

if __name__ == '__main__':
    main()