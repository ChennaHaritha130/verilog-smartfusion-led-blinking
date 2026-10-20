<CodeBlock language="verilog" editable>
`timescale 1ns/1ps

module led_blink_tb;

reg clk = 0;
    reg rst = 1;
    wire led;

// Use a small count for fast simulation.
    led_blink #(
        .CLK_FREQ_HZ(10),
        .BLINK_INTERVAL_SEC(1)
    ) dut (
        .clk(clk),
        .rst(rst),
        .led(led)
    );

// 10 ns clock period
    always #5 clk = ~clk;

initial begin
        $dumpfile("led_blink.vcd");
        $dumpvars(0, led_blink_tb);

#12;
        rst = 0;

// Observe several LED transitions.
        #220;

$display("Simulation completed.");
        $finish;
    end

initial begin
        $monitor("Time=%0t rst=%b led=%b",
                 $time, rst, led);
    end

endmodule
