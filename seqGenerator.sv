module seq_generator (
  input   logic        clk,
  input   logic        reset,

  output  logic [31:0] seq_o
);

  // Write your logic
  logic [31:0] p0,p1,p2;
  logic [31:0] next;
     
    
  always @ (posedge clk or posedge reset)
    if (reset) begin
      p0 <= 1;
      p1 <= 1;
      p2 <= 1;
      seq_o <= 0;
      
    end else begin
			seq_o <= p0;
      p0 <= p1;
      p1 <= p2;
      p2 <= next;
      
    end
  
  always_comb begin
        // Calculate the next value in the sequence
        next = p0 + p1;
  end

endmodule
