# Example of overfitting algorithm
library(kernlab); 
data(spam); 
set.seed(333)

smallSpam <- spam[sample(dim(spam)[1],size=10),]
spamLabel <- (smallSpam$type=="spam")*1 + 1
plot(smallSpam$capitalAve,col=spamLabel)

rule1 <- function(x){
  prediction <- rep(NA,length(x))
  prediction[x > 2.7] <- "spam"
  prediction[x < 2.40] <- "nonspam"
  prediction[(x >= 2.40 & x <= 2.45)] <- "spam"
  prediction[(x > 2.45 & x <= 2.70)] <- "nonspam"
  return(prediction)
}

table(rule1(smallSpam$capitalAve),smallSpam$type)

# Less overfitted rule for spam detection
rule2 <- function(x) {
  
  prediction <- rep(NA, length(x))
  prediction[x > 2.8] <- "spam"
  prediction[x <= 2.8] <- "nonspam"
  return(prediction)
}

table(rule2(smallSpam$capitalAve), smallSpam$type)

# Now apply to large data set
table(rule1(spam$capitalAve), spam$type)
table(rule2(spam$capitalAve), spam$type)

# Check accuracy
sum(rule1(spam$capitalAve)==spam$type)

sum(rule2(spam$capitalAve)==spam$type)


