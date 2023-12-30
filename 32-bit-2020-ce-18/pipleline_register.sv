module pipeline_registers (
    input  logic clk,
    input  logic rst,
    input  logic [31:0] instruction_if,  // Data from IF stage
    output logic [31:0] instruction_id,  // Data to ID stage
    output logic [31:0] instruction_ex,  // Data to EX stage
    output logic [31:0] instruction_wb  // Data to WB stage
);

    // Pipeline Register for Stage 1
    module pipeline_reg_1 (
        input  logic clk,
        input  logic rst,
        input  logic [31:0] instruction_if,
        output logic [31:0] instruction_id
    );
        // Your pipeline register logic here
        // ...
    endmodule

    // Pipeline Register for Stage 2
    module pipeline_reg_2 (
        input  logic clk,
        input  logic rst,
        input  logic [31:0] instruction_id,
        output logic [31:0] instruction_ex
    );
        // Your pipeline register logic here
        // ...
    endmodule

    // Pipeline Register for Stage 3
    module pipeline_reg_3 (
        input  logic clk,
        input  logic rst,
        input  logic [31:0] instruction_ex,
        output logic [31:0] instruction_wb
    );
        // Your pipeline register logic here
        // ...
    endmodule

    // Instantiate pipeline register modules
    pipeline_reg_1 pr1 (
        .clk(clk),
        .rst(rst),
        .instruction_if(instruction_if),
        .instruction_id(instruction_id)
    );

    pipeline_reg_2 pr2 (
        .clk(clk),
        .rst(rst),
        .instruction_id(instruction_id),
        .instruction_ex(instruction_ex)
    );

    pipeline_reg_3 pr3 (
        .clk(clk),
        .rst(rst),
        .instruction_ex(instruction_ex),
        .instruction_wb(instruction_wb)
    );

endmodule
