`timescale 1ns / 1ps
module forwardingUnit
(
    input EX_MEM_RegWrite,
    input MEM_WB_RegWrite,
    input [4:0] EX_MEM_RegisterRd,
    input [4:0] ID_EX_RegisterRs1,
    input [4:0] ID_EX_RegisterRs2,
    input [4:0] MEM_WB_RegisterRd,
    output reg [1:0]ForwardA,
    output reg [1:0]ForwardB
 );
 
    always@(*) begin
        //EX hazard handled through the following conditions
        if(EX_MEM_RegWrite && (EX_MEM_RegisterRd != 0) && (EX_MEM_RegisterRd == ID_EX_RegisterRs1)) 
            ForwardA = 2'b10;
        else 
        
         if ((MEM_WB_RegWrite && (MEM_WB_RegisterRd != 0) && (MEM_WB_RegisterRd == ID_EX_RegisterRs1)) ) 
                   ForwardA = 2'b01;
                else 
                   ForwardA = 2'b00;       //else return to the selection line 00, hence no forwarding
        
        
        
         if(EX_MEM_RegWrite && (EX_MEM_RegisterRd != 0) && (EX_MEM_RegisterRd == ID_EX_RegisterRs2)) 
                ForwardB = 2'b10;
      
        //MEM hazard handled through the following conditions
       
            
         else if ((MEM_WB_RegWrite && (MEM_WB_RegisterRd != 0) && (MEM_WB_RegisterRd == ID_EX_RegisterRs2))) 
                ForwardB = 2'b01;
             else 
                ForwardB = 2'b00;   //no forwarding
            end
           
endmodule
