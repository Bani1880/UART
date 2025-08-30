`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/28/2025 01:52:14 AM
// Design Name: 
// Module Name: uart_tb
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
`timescale 1ns/1ps
module uart_tb;
    reg clk = 0, rst = 0;
    reg tx_start = 0;
    reg [7:0] tx_data = 8'h00;
    wire tx, rx_ready, tx_busy;
    wire [7:0] rx_data;
    reg rx;
    uart_tx #(.CLK_PER_BIT(10)) uart_tx_inst (
        .clk(clk),
        .rst(rst),
        .tx_start(tx_start),
        .tx_data(tx_data),
        .tx(tx),
        .tx_busy(tx_busy)
    );
    uart_rx #(.CLK_PER_BIT(10)) uart_rx_inst (
        .clk(clk),
        .rst(rst),
        .rx(tx), // use transmitter output for receiver input
        .rx_data(rx_data),
        .rx_ready(rx_ready)
    );
    always #10 clk = ~clk;
    initial begin
        rst = 1;
        #100;
        rst = 0;
        #100;
        tx_data = 8'hAB;
        tx_start = 1;
        #20;
        tx_start = 0;
        wait(rx_ready);
        $display("Received: %h", rx_data);
        #1000;
        $finish;
    end
endmodule
