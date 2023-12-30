module csr_module (
    input  logic         clk,
    input  logic         rst,
    input  logic [31:0]  addr,
    input  logic [31:0]  wdata,
    input  logic         csr_rd,
    input  logic         csr_wr,
    output logic [31:0]  rdata,
    output logic [31:0]  epc,
    output logic         excep
);
    logic [31:0] mstatus_reg, mepc_reg;
    
    // Combinational block for asynchronous read
    always_comb begin
        if (csr_rd) begin
            case (addr)
                12'h300: rdata = mstatus_reg;
                12'h341: rdata = mepc_reg;
                default: rdata = 32'b0;
            endcase
        end else begin
            rdata = 32'b0;
        end

        // Exception handling (simplified example)
        if (mstatus_reg[3]) begin
            excep = 1'b1;
        end else begin
            excep = 1'b0;
        end
    end

    // Sequential block for synchronous write
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            mstatus_reg <= 32'h0;
            mepc_reg <= 32'h0;
        end else if (csr_wr) begin
            case (addr)
                12'h300: mstatus_reg <= wdata;
                12'h341: mepc_reg <= wdata;
            endcase
        end
    end

    // Additional logic for epc output based on your design
    assign epc = mepc_reg;

endmodule
