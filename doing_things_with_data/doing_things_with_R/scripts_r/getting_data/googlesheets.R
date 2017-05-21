library(googlesheets)

gs_user()
#gs_auth(new_user = T)
gs_ls()

#mtcars_ggs <- gs_new("ads_googlesheet_example1", ws_title = "example1", input = mtcars)
gss_example <- gs_title("ads_googlesheet_example") #read in workbook 
ggs_cars <- gs_read(ss = gss_example, ws = "example1")
head(ggs_cars)





