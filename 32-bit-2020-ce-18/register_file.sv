module register_file 
(
    input  logic        clk,
    input  logic        rf_en,
    input  logic [ 4:0] rs1,
    input  logic [ 4:0] rs2,
    input  logic [ 4:0] rd,
    input  logic [31:0] wdata,
    output logic [31:0] rdata1,
    output logic [31:0] rdata2
);

    logic [31:0] reg_mem [0:31];

    // asynchronous read
    always_comb 
    begin
        rdata1 = (rs1 == 5'b00000) ? 32'b0 : reg_mem[rs1];
        rdata2 = (rs2 == 5'b00000) ? 32'b0 : reg_mem[rs2];
    end

    // synchronous write
    always_ff @(posedge clk) 
    begin
        if (rf_en && (rd != 5'b00000))
        begin
            reg_mem[rd] <= wdata;
        end
    end

endmodule
