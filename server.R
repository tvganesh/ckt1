#########################################################################################################
#
# Title : Sixer - cricketr's Shiny avatar
# Designed and developed by: Tinniam V Ganesh
# Date : 28 Nov 2015
# File: server.R
# More details: https://gigadom.wordpress.com/
#
#########################################################################################################
library(shiny)
library(cricketr)


# Source files
source("analyzeBatsman.R")
source("analyzeBowler.R")
source("relBatsmenPerf.R")
source("relBowlersPerf.R")
source("definitions.R")


shinyServer(function(input, output,session) {
    
    # Analyze and display batsmen plots
    output$batsmanPlot <- renderPlot({  
        # Setup dynamic UI
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
        # Dynamic list update. Set the selected so that it does not flip to the first!!
        output$batsmanList = renderUI({
            selectInput('batsman', 'Choose batsman',choices=player,selected=input$batsman)
        })
        output$batsmanFunctionList = renderUI({
            selectInput('batsmanFunc', 'Choose chart type',choices=f,selected=input$batsmanFunc)
        })
        
        # Call the plots for the batsman
        analyzeBatsman(input$batsman,input$batsmanFunc,input$matchType)
        
    })
    
    # Analyze and display bowler's plots
    output$bowlerPlot <- renderPlot({  
        
        
        # Include the list to display in the drop downs on choice of matchType
        if(input$matchType1 == "Test"){
            player = testBowler
            f1 = funcs1
        } else if(input$matchType1 == "ODI"){
            player = odiBowler
            f1 = funcs1ODI
        }
        else {
            player = ttBowler
            f1 = funcs1TT
        }
        # Render dynamic UI
        output$bowlerList = renderUI({
            selectInput('bowler', 'Choose bowler',choices=player,selected=input$bowler)
        })
        output$bowlerFunctionList = renderUI({
            selectInput('bowlerFunc', 'Choose chart type',choices=f1,selected=input$bowlerFunc)
        })
        
        analyzeBowler(input$bowler,input$bowlerFunc,input$matchType1)
        
        
    })
    # Analyze and display relative batsman plots
    output$relBatsmenPlot <- renderPlot({  
        # Include the list to display in the drop downs on choice of matchType
        if(input$matchType3 == "Test"){
            player = testBatsman
            f2 = funcsRelBatsman
        } else if(input$matchType3 == "ODI"){
            player = odiBatsman
            f2 = funcsRelBatsman
        }
        else {
            player = ttBatsman
            f2 = funcsRelBatsman
        }
        # Set up for multiple selection
        output$relBatsmen = renderUI({
            selectInput('batsmen', 'Choose batsmen',choices=player,selected=input$batsmen,multiple=TRUE)
        })
        output$relBatsmenFunction = renderUI({
            selectInput('batsmenFunc', 'Choose chart type',choices=f2,selected=input$batsmenFunc)
        })
        
        if(length(input$batsmen != 0)){
            relBatsmenPerf(input$batsmen,input$batsmenFunc,input$matchType3)
        }
        
        
    })
    
    # Analyze and display relative bowler plots
    output$relBowlersPlot <- renderPlot({  
        
        if(input$matchType4 == "Test"){
            player = testBowler
            f3 = funcsRelBowlerTestODI
        } else if(input$matchType4 == "ODI"){
            player = odiBowler
            f3 = funcsRelBowlerTestODI
        }
        else {
            player = ttBowler
            f3 = funcsRelBowlerTT
        }
        
        # Setup for multiple input
        output$relBowlers = renderUI({
            selectInput('bowlers', 'Choose bowlers',choices=player,selected=input$bowlers,multiple=TRUE)
        })
        output$relBowlersFunction = renderUI({
            selectInput('bowlersFunc', 'Choose chart type',choices=f3,selected=input$bowlersFunc)
        })
        if(length(input$bowlers != 0)){
            
            relBowlersPerf(input$bowlers,input$bowlersFunc,input$matchType4)
        }
        
        
    })
    
    
})
