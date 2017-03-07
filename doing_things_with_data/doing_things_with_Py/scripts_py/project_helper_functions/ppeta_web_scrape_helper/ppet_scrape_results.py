from ppet_scrape_function import ppet_scrape

##scrape data 
base = 'http://ppet.pccd.pa.gov'
a = 'http://ppet.pccd.pa.gov/Selection/Search%20PA%20Juvenile%20Justice%20and%20Delinquency%20Prevention%20Programs%20by%20Target%20Population.aspx'
ppet_programs1 = ppet_scrape(a, base)
#ppet_programs1.to_csv("programs_a.csv")

b = 'http://ppet.pccd.pa.gov/Selection/Search%20PA%20Juvenile%20Justice%20and%20Delinquency%20Prevention%20Programs%20by%20General%20Program%20Information.aspx'
ppet_programs2 = ppet_scrape(b, base)
#ppet_programs2.to_csv("programs_b.csv")
