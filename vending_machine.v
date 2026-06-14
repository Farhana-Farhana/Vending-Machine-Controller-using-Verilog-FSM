`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.06.2026 01:51:16
// Design Name: 
// Module Name: vending_machine
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module vending_machine(
    input clk,
    input reset,
    input coin5,
    input coin10,
    output reg dispense
);

reg [1:0] state;

parameter S0  = 2'b00;
parameter S5  = 2'b01;
parameter S10 = 2'b10;

always @(posedge clk or posedge reset)
begin
    if(reset)
    begin
        state <= S0;
        dispense <= 0;
    end
    else
    begin
        dispense <= 0;

        case(state)

            S0:
            begin
                if(coin5)
                    state <= S5;
                else if(coin10)
                    state <= S10;
            end

            S5:
            begin
                if(coin5)
                    state <= S10;
                else if(coin10)
                begin
                    state <= S0;
                    dispense <= 1;
                end
            end

            S10:
            begin
                if(coin5 || coin10)
                begin
                    state <= S0;
                    dispense <= 1;
                end
            end

        endcase
    end
end

endmodule
