library(Rfacebook)
library(ggplot2)

##the FB access token expires every two hours
temp_token <- "EAACEdEose0cBAJq027RKCGrWEVwsp3qmBPrd8oVS2bQZAsWqCr0A2EjC1iLaJVY7R291cmWb3dSesvHv2mMZA0ZAFqRc7mQLsQddLHaG9CBytcY4uZC5JYBikhmpLDCtZB80AztqOtpBNERfr8T829ZBaDag4YISLZBmj2dwibyLYCEgDBCYIGCDZAlXYaBZApfkZD"

##retrieve user information 
#single user
fb_user <- getUsers(users = "senatorsanders", token = temp_token)
fb_user
#multiple users
fb_users <- getUsers(users = c("DonaldTrump","HillaryClinton","senatorsanders"), token = temp_token) 
fb_users
##getting posts
#getPage retrieves information from a public Facebook page
#basic post scrape from selected users 
trump_posts <- getPage(page = fb_users$id[fb_users$name == "Donald J. Trump"], 
                              token = temp_token)
str(trump_posts)

#deliberate post scrape 
#getPage retrieves information from a public Facebook page
clinton_posts <- getPage(page = fb_users$id[fb_users$name == "Hillary Clinton"], 
                         token = temp_token, 
                         reactions = TRUE,
                         since = "2016/01/01", until = "2016/01/31", n = 500)

str(clinton_posts)
colnames(clinton_posts)
#messages
head(clinton_posts$message)

#post characteristics 
clinton_posts[1:6, c("created_time","type","story")]

#post follower reactions
clinton_posts[1:6, grep("_count", colnames(clinton_posts))]

######
#multiple users
fb_news <- getUsers(users = c("cnn","NPR"), token = temp_token)
fb_news

##getting posts 
cnn_posts <- getPage(page = fb_news$id[fb_news$name == "CNN"], 
                     token = temp_token, 
                     reactions = TRUE)
str(cnn_posts)

#take first message from cnn page scrape 
cnn_posts$message[1]

#explore follower reactions 
cnn_post1_reactions <- cnn_posts[1,grep("_count", colnames(cnn_posts))]
cnn_post1_reactions

compile_reactions <- NULL
for(i in colnames(cnn_post1_reactions)){
  compile_reactions <- c(compile_reactions, rep(x = sub(pattern = "_count", replacement = "", x =  i),
                        times = cnn_post1_reactions[i]))
}
compile_reactions <- data.frame(reactions = compile_reactions)
str(compile_reactions)
table(compile_reactions)

ggplot(compile_reactions, aes(x = reactions)) + 
  geom_bar(stat = "count") + 
  labs(title = "Reactions to a Single Post")

######
fb_scrape <- function(start_date, end_date, page_id, token){
  #process date range 
  sd <- as.POSIXlt(start_date)
  ed <- as.POSIXlt(end_date) 
  month_count <- 12*(ed$year-sd$year)+(ed$mon-sd$mon)
  sd_range <- seq(sd, length = month_count, by = "month")
  ed_range <- seq(seq(sd, length = 2, by = "month")[2], length = month_count, by = "month")-1
  date_df <- data.frame(sd_range, ed_range)
  #scrape page based on dates
  post_df <- data.frame()
  for(d in 1:dim(date_df)[1]){
    temp <- getPage(page = page_id, token = token, reactions = T, n = 10000, 
                    since = date_df[d,1], until = date_df[d,2])
    post_df <- rbind(post_df, temp)
  }
  return(post_df)
}


