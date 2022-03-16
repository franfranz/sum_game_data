#
#   Analysis of the output of Sum_game  
#
#   https://github.com/franfranz/sum_game_data
#

# run on last epochs of testing of S0 runs 

#
#   inputs
#

# round to 3rd digit
roundnum=3

# graphical parameters 
pal_1= c("grey30", "grey90")


#
# import data

# path 
wd="path"
setwd(wd)

# load data 
dat=read.csv("s0_runs_lastep.csv")

# number of runs analyzed
run_nums=length(unique(dat$run))

# distribution of Input Couples (IC)
inputcouples= unique(dat$in_couples)
n_unique_couples=length(inputcouples)
freq_ic=table(inputcouples)
ic_probs=freq_ic/length(inputcouples)
# entropy for IC
H_ic=round(-sum(ic_probs*log2(ic_probs)), roundnum)

# distribution of Sum Labels (SL)
sum_labels=dat[dat$run=="r001", "labels"]
n_unique_labels=length(unique(sum_labels))
len_labels=length(sum_labels)
freq_labels=table(sum_labels)
sl_probs=round((freq_labels/len_labels), roundnum)
# entropy for SL
H_sl=round(-sum(sl_probs*log2(sl_probs)), roundnum)



#
# values for each run
#

single_runs= NULL
  
for (eachrun in unique(dat$run)){
  print (eachrun)
  rdat= dat[dat$run == eachrun, ]
  
  
  # accuracy
  racc= round(mean(rdat$acc), roundnum)
  rsd= round(sd(rdat$acc), roundnum)
  
  
  #
  # messages
  
  rdat$messages
  rmes=length(unique(rdat$messages))
  
  # entropy: messages
  rmes_freqs_mes=table(rdat$messages)
  rmes_probs_mes=rmes_freqs_mes/length(rdat$messages)
  H_rmes= round(-sum(rmes_probs_mes*log2(rmes_probs_mes)),3)
  
  # bind data
  single_runs=rbind(single_runs, 
                    c(rmes, # number of messages of AC
                      H_rmes, # entropy of AC
                      racc,  # accuracy 
                      # rsd, # sd accuracy
                      eachrun
                      ))
  
 }

colnames(single_runs)=list("n_messages", 
                           "code_entropy", 
                           "acc_mean", 
                           #"acc_sd",
                           "run"
                           )

# output in a table 
xtable::xtable(single_runs)
single_runs=as.data.frame(single_runs)
single_runs$n_messages=as.integer(single_runs$n_messages)
single_runs$code_entropy=as.integer(single_runs$code_entropy)

# mean values
mean(single_runs$n_messages)
mean(single_runs$code_entropy)

#
# accuracy
acc=round(mean(dat$acc), 3)
sdacc=round(sd(dat$acc), 3)

#
# unique vecs
length(unique(dat$in_couples))
vec_freqs=table(dat$in_couples)
vec_probs=vec_freqs/length(vec_freqs)


#
# Sum Labels SL

dat$labels
length(unique(dat$labels))
hist(dat$labels, breaks= length(dat$labels+1))



#
# Messages

dat$messages
length(unique(dat$messages))
hist(dat$messages, breaks= length(dat$messages+1))



# Accuracy  - Sum Labels
# barplot
barplot(table(dat$acc, dat$labels), 
            #border= "white"
             main = "Accuracy in S0 - Sum Labels",  
             xlab= "Sum Label", 
             ylab= "Frequency", 
             )

legend("topleft", 
       legend = c(0,1), 
       fill= c("grey30", "grey90"), 
       bty= "n", 
       title = "Accuracy") 

#spine plot
table(dat$acc, dat$labels)
spineplot((table(dat$labels, dat$acc)), 
          col=pal_1[c(2:1)],
          xlab= "Sum Label",
          main = "Accuracy in S0 - Sum Labels",
          #border= "white"
) 

# Accuracy - Input Couples
barplot(table(dat$acc, dat$in_couples), 
        las=2,
        #border= "white"
        main = "Accuracy in S0 - Input Couples", 
        xlab= "Input Couples", 
        ylab= "Frequency",
        )

xtable::xtable(single_runs)


# correlation accuracy - number of messages
single_runs$acc=as.numeric(single_runs$acc)
cor.test(single_runs$n_messages, single_runs$acc)

# qualitative exploration of frequent messages
datr006=dat[dat$run== "r006", ]
table(datr006$labels, datr006$messages)
table(datr006$in_couples, datr006$messages)


m311=datr006[datr006$messages=="311", ]
table(m311$acc, m311$in_couples)
table(m311$acc, m311$labels)


m285=datr006[datr006$messages=="285", ]
table(m285$acc, m285$in_couples)
table(m285$acc, m285$labels)


hist(datr006$messages, breaks = length(unique(datr006$messages)))
