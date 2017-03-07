##packages 
import urllib.request, pandas as pd, bs4 as bs, re

##helper function 
def ppet_scrape(start_url, base_url, parser_type = 'html.parser', java_pattern = '/Selection(.+?)["]', href_content = 'javascript:', table_attrs = 'ms-listviewtable'):
    url_list = [start_url]
    url1 = start_url
    soup = bs.BeautifulSoup(urllib.request.urlopen(url1).read(), parser_type)
    while 'Next' in str(soup.find_all(href = href_content)[-1]):
        url1 = base_url + re.sub('amp;', '', re.search(java_pattern, str(soup.find_all(href = href_content)[-1])).group()[:-1])
        url_list.append(url1)
        soup = bs.BeautifulSoup(urllib.request.urlopen(url1).read(), parser_type)

    #df = pd.read_html(start_url, header = 0, attrs = table_attrs)[0]
    df = pd.DataFrame()
    for u in url_list:
        df = pd.DataFrame.append(df, pd.read_html(u, header = 0, attrs = table_attrs)[0])
    return(df)









