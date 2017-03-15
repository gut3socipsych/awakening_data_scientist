from urllib.request import urlopen
import bs4 as bs
import re
import pandas as pd

def scrape_fun(url, parser_type = "html.parser"):
    result = bs.BeautifulSoup(urlopen(url), parser_type)
    return(result)

def get_tags(url):
    tag_list = list(bs.BeautifulSoup(urlopen(url), "html.parser").body.findAll())
    names = []
    attributes = []
    for t in tag_list:
        names.append(t.name)
        attributes.append(str(t.attrs.items()))
    df = pd.DataFrame([names, attributes]).transpose()
    df.columns = ["name","attrs"]
    df = df.drop_duplicates()
    df = df.sort_values(by = "name")
    print("From", len(names), "HTML tags ", "Found", len(df), "HTML tags with unique attributes.") 
    return(df)

