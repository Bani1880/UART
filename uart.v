`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/28/2025 01:46:16 AM
// Design Name: 
// Module Name: uart
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
module uart_tx(
    input clk,
    input rst,
    input tx_start,
    input [7:0] tx_data,
    output reg tx,
    output reg tx_busy
);
    parameter CLK_PER_BIT = 434; // for 9600 baud at 50MHz

    reg [9:0] tx_shift;
    reg [3:0] bit_idx;
    reg [15:0] clk_count;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            tx <= 1'b1;
            tx_busy <= 0;
            tx_shift <= 10'b1111111111;
            bit_idx <= 0;
            clk_count <= 0;
        end else begin
            if (tx_start & !tx_busy) begin
                tx_shift <= {1'b1, tx_data, 1'b0}; // stop, data[7:0], start
                tx_busy <= 1;
                bit_idx <= 0;
                clk_count <= 0;
            end else if (tx_busy) begin
                if (clk_count < CLK_PER_BIT - 1) begin
                    clk_count <= clk_count + 1;
                end else begin
                    tx <= tx_shift[0];
                    tx_shift <= {1'b1, tx_shift[9:1]};
                    clk_count <= 0;
                    bit_idx <= bit_idx + 1;
                    if (bit_idx == 9) begin
                        tx_busy <= 0;
                        tx <= 1'b1;
                    end
                end
            end
        end
    end
endmodule

module uart_rx(
    input clk,
    input rst,
    input rx,
    output reg [7:0] rx_data,
    output reg rx_ready
);
    parameter CLK_PER_BIT = 434; // for 9600 baud at 50MHz

    reg [3:0] bit_idx;
    reg [15:0] clk_count;
    reg [7:0] rx_shift;
    reg rx_busy;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            rx_data <= 8'b0;
            rx_ready <= 0;
            bit_idx <= 0;
            clk_count <= 0;
            rx_busy <= 0;
            rx_shift <= 8'b0;
        end else begin
            rx_ready <= 0;
            if (!rx_busy) begin
                if (!rx) begin // Start bit detected
                    rx_busy <= 1;
                    clk_count <= CLK_PER_BIT/2; // sample in the middle
                    bit_idx <= 0;
                end
            end else begin
                if (clk_count < CLK_PER_BIT - 1) begin
                    clk_count <= clk_count + 1;
                end else begin
                    clk_count <= 0;
                    if (bit_idx < 8) begin
                        rx_shift[bit_idx] <= rx;
                        bit_idx <= bit_idx + 1;
                    end else begin
                        rx_data <= rx_shift;
                        rx_ready <= 1;
                        rx_busy <= 0;
                    end
                end
            end
        end
    end
endmodule


