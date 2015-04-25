library(rCharts)
library(shiny)
library(datasets)
library(ISOcodes)
data(ISO_3166_1)
shinyUI(pageWithSidebar(
        headerPanel("BMI(Body Mass Index) 비만도 측정"),
        sidebarPanel(
                numericInput(inputId="heightM", label="당신의 키는? (cm)", value= 0,min=0),
                numericInput(inputId="weightM", label="당신의 몸무게는? (kg)", value= 0,min=0),
                radioButtons(inputId="gender", label="성별", choices=c("여성","남성")),
                selectInput(inputId="country", label="국가", choices=sort(ISO_3166_1$Alpha_3),
                multiple = FALSE,selected="KOR"),
                conditionalPanel(
                        condition = "input.country == 'USA'",
                        p("If you live in USA, please choose a state"),
                        selectInput(inputId="state", label="State", choices=state.name,
                        multiple = FALSE,selected=NULL)),
                actionButton("goButton", "Go!"),
                br(),
                p(strong(em("Documentation:",a("BMI 분류 설명서",href="READMe.html")))),
                p(strong(em("GitHub 저장소:",a("Developing Data Products - Peer Assessment Project; Shiny App",href="https://github.com/irichgreen/BMI_Classification"))))
        ),
        mainPanel(
                tabsetPanel(
                        tabPanel('측정 결과',
                                h5('Your BMI coefficient kg/m^2'),
                                verbatimTextOutput("oiBMI"),
                                verbatimTextOutput("oiBMIclass"),
                                img(src="WHOBMI.png", height = 600, width =600),
                                p("Source: ", a("WHO BMI classification", 
                                    href = "http://apps.who.int/bmi/index.jsp?introPage=intro_3.html"))
                                ),
                        tabPanel('데이터 요약',
                                 h5('Available data for'),
                                 verbatimTextOutput("oicountry"),
                                 h5('Gender'),
                                 verbatimTextOutput("oigender"),
                                 h5('Mean BMI (kg/m2) (crude estimate) and 95% CI'),
                                 verbatimTextOutput("oiBMIcrude"),
                                 p("Source: ", a("WHO Global Health Observatory Data Repository", 
                                                 href = "http://apps.who.int/gho/data/node.main.A903?lang=en")),
                                 h5('Recent BMI Indicators'),
                                 dataTableOutput("oiBMIcattable"),
                                 p("Source: ", a("KNOEMA-WHO Global Database on Body Mass Index (BMI)", 
                                        href = "http://knoema.com/WHOGDOBMIMay/who-global-database-on-body-mass-index-bmi"))
                                ),
                        tabPanel('비만도 지표 그래프(Plot)',
                                 h5('Recent BMI Indicators'),
                                 p("Plotted data are for your gender for your specific country"),
                                 p("If there are no data for your gender, plotted data are for adults for your specific country"),
                                 verbatimTextOutput("oiPlotYear"),
                                 showOutput("Plot1","highcharts"),
                                 p("Worldwide Data: ", a("KNOEMA-WHO Global Database on Body Mass Index (BMI)", href = "http://knoema.com/WHOGDOBMIMay/who-global-database-on-body-mass-index-bmi"))
                                 ),
                        tabPanel('표준 비만도 동향(Plot)',
                                 h5('Mean BMI Trend per Years'),
                                 showOutput("Plot2","highcharts"),
                                 p("Source: ", a("WHO Global Health Observatory Data Repository", 
                                                 href = "http://apps.who.int/gho/data/node.main.A903?lang=en"))
                                 ),
                        tabPanel('비만지 지표 for US States(Plot)',
                                 h5('2012 US States BMI Indicators for Adults '),
                                 verbatimTextOutput("oiState"),
                                 showOutput("Plot3","highcharts"),
                                 p("US States Data: ", a("CDC-Behavioral Risk Factor Surveillance System; Prevalence and Trends Data; Overweight and Obesity(BMI) 2012", href = "http://apps.nccd.cdc.gov/brfss/list.asp?cat=OB&yr=2012&qkey=8261&state=All"))
                                 )
                ),
                p(strong("All you need is love. But a little chocolate now and then doesn't hurt. Charles M. Schulz"))
               )
)
)