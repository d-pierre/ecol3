library(shiny)

# Define server logic required to plot various variables against mpg
shinyServer(function(input, output) {
  calculs <- reactive({
    param <- matrix(0, nrow=9, ncol=1)
    param[1, 1] <- input$K1 
    param[2, 1] <- input$K2 
    param[3, 1] <- input$r1
    param[4, 1] <- input$r2
    param[5, 1] <- input$Alpha12
    param[6, 1] <- input$Alpha21
    param[7, 1] <- input$n01
    param[8, 1] <- input$n02  
    param[9, 1] <- input$t
    
      Nb=matrix(0,param[9, 1],2)
    
    Nb[1,1]=param[7, 1]
    Nb[1,2]= param[8, 1]
    for (i in 1:((param[9, 1])-1)) {
      Nb[i+1,1]= Nb[i,1]+param[3, 1]*Nb[i,1]*((param[1, 1]-Nb[i,1]-param[5, 1]*Nb[i,2])/param[1, 1])
      if(Nb[i+1,1]<=0)(Nb[i+1,1]=0)else (Nb[i+1,1]=Nb[i+1,1])
      Nb[i+1,2]= Nb[i,2]+param[4, 1]*Nb[i,2]*(( param[2, 1]-Nb[i,2]-param[6, 1]*Nb[i,1])/ param[2, 1])
      if(Nb[i+1,2]<=0)(Nb[i+1,2]=0)else (Nb[i+1,2]=Nb[i+1,2])
    }
    
    N1=param[2, 1]/param[6, 1]
    N2=param[1, 1]/param[5, 1]
    
    
    list(param=param, Nb=Nb,N1=N1,N2=N2)
  })
    output$plot <- renderPlot({
      out <- calculs()
     with(out, {
        layout(matrix(1:2))
        plot(Nb[,2], type="l",col="red",xlab="Temps",ylab="Effectifs",ylim=c(0,max(Nb[,2],Nb[,1])),
             main=paste("K1=",param[1, 1],", K2=",param[2, 1],", r1=",param[3, 1],", r2=",param[4, 1]))
        points(Nb[,1],type="l", col="blue")
        
        plot(Nb[,2]~Nb[,1],col="green",lwd=2,type="l",xlim=c(0,max(param[1, 1],N1)),ylim=c(0,max(param[2, 1],N2)),xlab="",ylab="",main=paste(" Alpha=", param[5, 1],", Beta=", param[6, 1],", N1=", param[7, 1],", N2=", param[8, 1]))
        mtext("Population 1",1,line=2, col="blue", cex=1.2)
        mtext("Population 2",2,line=2, col="red", cex=1.2)
        lines(c(param[1, 1],0),c(0,N2),type="l",col="blue")
        lines(c(N1,0),c(0,param[2, 1]),type="l",col="red")
        abline(v=0)
        abline(h=0) 
        text(0,N2,(expression(K1/alpha)),col="blue",pos=1)
        text(N1,0,(expression(K2/beta)),col="red",pos=3)
        text(param[1, 1],0,(expression(K1)),col="blue",pos=3)
        text(0,param[2, 1],(expression(K2)),col="red",pos=1)   
        points(Nb[(param[9, 1]),1],Nb[(param[9, 1]),2],col="red",pch=19)
        points(Nb[1,1],Nb[1,2],col="green",pch=19)
        
        
        
     })
  
  
})
}) 
