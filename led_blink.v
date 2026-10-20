
`timescale 1ns/1ps

// Educational recreation of a counter-based LED blinker.
// This is not the original HAL source code.
module led_blink #(
    parameter integer CLK_FREQ_HZ = 50_000_000,
    parameter integer BLINK_INTERVAL_SEC = 1
)(
    input  wire clk,
    input  wire rst,
    output reg  led
);

    localparam integer COUNT_LIMIT =
        (CLK_FREQ_HZ * BLINK_INTERVAL_SEC) - 1;

    localparam integer COUNTER_WIDTH =
        (COUNT_LIMIT < 1) ? 1 : $clog2(COUNT_LIMIT + 1);

    reg [COUNTER_WIDTH-1:0] counter;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            counter <= 0;
            led     <= 1'b0;
        end else begin
            if (counter == COUNT_LIMIT) begin
                counter <= 0;
                led     <= ~led;
            end else begin
                counter <= counter + 1'b1;
            end
        end
    end

endmodule
