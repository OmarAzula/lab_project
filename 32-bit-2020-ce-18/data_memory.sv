module data_memory
(
    input  logic        clk,
    input  logic        rd_en,
    input  logic        wr_en,
    input  logic [31:0] addr,
    input  logic [ 2:0] mem_acc_mode,
    input  logic [31:0] rdata2,
    output logic [31:0] rdata
);
    logic [31:0] data_mem [0:99]; // Each element is 32 bits [0:99] to have 100 elements

    // Here I'm using big-endian byte ordering in which MSB is stored at lower address and LSB at higher address

    // asynchronous read
    always_comb
    begin
        if (rd_en)
        begin
            case (mem_acc_mode)
                BYTE:
                    rdata = $signed(data_mem[addr]);
                HALFWORD:
                    rdata = $signed({data_mem[addr], data_mem[addr+1]});
                WORD:
                    rdata = $signed({data_mem[addr], data_mem[addr+1], data_mem[addr+2], data_mem[addr+3]});
                BYTE_UNSIGNED:
                    rdata = {24'b0, data_mem[addr]};
                HALFWORD_UNSIGNED:
                    rdata = {16'b0, data_mem[addr], data_mem[addr+1]};
                default: // Add a default case for safety
                    rdata = 32'b0;
            endcase
        end
    end

    // synchronous write
    always_ff @(posedge clk)
    begin
        if (wr_en)
        begin
            case (mem_acc_mode)
                BYTE:
                    data_mem[addr] <= rdata2[7:0];
                HALFWORD:
                    data_mem[addr]   <= rdata2[15:8];
                    data_mem[addr+1] <= rdata2[7:0];
                WORD:
                    data_mem[addr]   <= rdata2[31:24];
                    data_mem[addr+1] <= rdata2[23:16];
                    data_mem[addr+2] <= rdata2[15:8];
                    data_mem[addr+3] <= rdata2[7:0];
                default: // Add a default case for safety
                    // No write for other modes
            endcase
        end
    end

endmodule
