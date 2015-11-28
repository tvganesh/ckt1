relBatsmenPerf <- function(batsmen,func,matchType) {
    cat("name=",batsmen)
    
    file <- NULL
    if(matchType == "Test") {
        
        for(i in 1:length(batsmen)){
              batsman <- mapBatsman(batsmen[i])
              file[i] <- paste("./data/test/batsman/",batsman,".csv",sep="")
        
        }
    } else if (matchType == "ODI"){
        for(i in 1:length(batsmen)){
            batsman <- mapBatsman(batsmen[i])
            file[i] <- paste("./data/odi/batsman/",batsman,".csv",sep="")
            
        }
    } else {
        for(i in 1:length(batsmen)){
            batsman <- mapBatsman(batsmen[i])
            file[i] <- paste("./data/tt/batsman/",batsman,".csv",sep="")
            
        }
    }
    cat(file)
    
    
    cat(file)
    if(func =="Relative Batsman Strike Rate"){
        if(matchType == "Test"){
             relativeBatsmanSR(file,batsmen)
        } else{
            relativeBatsmanSRODTT(file,batsmen)
        }
        
    } else if (func == "Relative Runs Freq Performance"){
        relativeRunsFreqPerf(file,batsmen)
    }
}