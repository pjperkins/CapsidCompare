#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

options(shiny.maxRequestSize=30*1024^2)

shinyUI(navbarPage(inverse = T,"CapsidCompare",
                   tabPanel("File Processing", #Start page for welcome message, uploading files, and data preprocessing
                            sidebarLayout(
                              sidebarPanel(
                                #actionButton("go", "Go"),
                                #numericInput("n", "n", 50),
                                fileInput( "comp_dataset", "Please Choose a Dataset", multiple = T),
                                #fileInput( "RPFfile", "Please Choose Footprinting BAM Files", multiple = T),
                                #fileInput( "ANNOfile", "Please Choose Annotation GFF3 File", multiple = T),
                                #fileInput( "FASTAfile", "Choose FASTA File (Optional)", multiple = T),
                                #fileInput( "TESTfile1", "Choose Reference RNA File (Optional)", multiple = T),
                                #fileInput( "TESTfile2", "Choose Reference RPF File (Optional)", multiple = T),
                                #checkboxInput("prepro", "Preprocess")
                                actionButton("file_process", "Preprocess",icon("paper-plane"), 
                                             style="color: #fff; background-color: #337ab7; border-color: #2e6da4")
                                #submitButton("Submit")
                              ),
                              mainPanel(
                                h3("Facilitating comprehensive Comparison of AAV Capsids", align = "center"),
                                br(),
                                span("Welcome to ", strong("CapsidCompare") , ", a suite of tools for comparing AAV Capsid amino acid sequences."),
                                p("Get started by uploading a file of combined AAV sequences from multiple tissues or samples  and hitting ", span("Preprocess.", style = "color:blue")),
                                p("Once you recieve conifrmation below that your file has been successfully uploaded and processed, you can utilize the analysis tools listed in the toolbar above."),
                                dataTableOutput(outputId = 'summary_table1'),
                                hr(), 
                                reactableOutput(outputId = 'summary_table2')
                                
                                
                              )
                            )
                   ),
                  tabPanel("Sample Comparison", #Start page for welcome message, uploading files, and data preprocessing
                            sidebarLayout(
                              sidebarPanel(
                                #fileInput("comp_dataset", "Choose a dataset:"),
                                #selectInput("comp_type", "Comparison Type", choices = list('Rank' = 1, "Frequency" = 2), selected = 1),
                                sliderInput("comp_num", "Top N Sequences", min = 1, max = 100, value = 20),
                                uiOutput('comp_tissue'),
                                actionButton("comp_button", "Apply Changes")
                                
                              ),
                              mainPanel(
                                tabsetPanel(
                                  tabPanel("Heatmap",
                                           plotOutput("cross_heatmap", height = 800)),
                                  tabPanel("Line Plot",
                                           plotOutput("cross_lineplot", height = 800)),
                                  tabPanel("Barplot",
                                           plotOutput("cross_barplot", height = 800))
                                  
                                )
                                
                                
                              )
                            )
                   )
))

#library(rsconnect)
#rsconnect::deployApp('C:/Users/pperkins/OneDrive - StrideBio, Inc/Documents/R Scripts/StrideSeq/')