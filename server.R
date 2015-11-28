#########################################################################################################
#
# Title : Literacy in India : A DeepR dive
# Designed and developed by: Tinniam V Ganesh
# Date : 5 Nov 2015
# File: server.R
# More details: https://gigadom.wordpress.com/
#
#########################################################################################################
library(shiny)
#library(shinyjs)
#library(devtools)
#install_github("tvganesh/cricketr")
library(cricketr)

source("analyzeBatsman.R")
source("analyzeBowler.R")
source("relBatsmenPerf.R")
source("relBowlersPerf.R")
source("definitions.R")


shinyServer(function(input, output,session) {
   
   
    # Analyze and display batsmen plots
    output$batsmanPlot <- renderPlot({  
        # Include the list to display in the drop downs on choice of matchType
        if(input$matchType == "Test"){
            player = testBatsman
            f = funcs
        } else if(input$matchType == "ODI"){
            player = odiBatsman
            f = funcsODITT
        }
        else {
            player = ttBatsman
            f = funcsODITT
        }
    output$players = renderUI({
        selectInput('batsman', 'Columns',choices=player,selected=input$batsman)
    })
    output$functions = renderUI({
        selectInput('batsmanFunc', 'Column1',choices=f,selected=input$batsmanFunc)
    })
 
    print(input$batsman)
    analyzeBatsman(input$batsman,input$batsmanFunc,input$matchType)
    
    })
    
    
})
