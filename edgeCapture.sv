module edge_capture (
  input   logic        clk,
  input   logic        reset,

  input   logic [31:0] data_i,

  output  logic [31:0] edge_o

);

  logic [31:0] datain;
  logic [31:0] edgee ;
  logic [31:0] stick;
 
	
    
  always_ff @(posedge clk or posedge reset) begin
    if (reset)begin
      stick <= 32'h0;
      datain <= 32'h0;
    end else begin
      stick <= stick | edgee;
      datain <= data_i; 
    end
  end

  always_comb begin
    edgee = datain & (~data_i) ;
   	edge_o = stick | edgee ;
  end
  
endmodule
