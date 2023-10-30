module events_to_apb (
  input   logic         clk,
  input   logic         reset,

  input   logic         event_a_i,
  input   logic         event_b_i,
  input   logic         event_c_i,

  output  logic         apb_psel_o,
  output  logic         apb_penable_o,
  output  logic [31:0]  apb_paddr_o,
  output  logic         apb_pwrite_o,
  output  logic [31:0]  apb_pwdata_o,
  input   logic         apb_pready_i

);

  logic [31:0]a;
  logic [31:0]b;
  logic [31:0]c; 
 // logic [1:0]st;
  assign apb_pwrite_o = 1;
  
  always @(posedge clk or posedge reset)
    begin
      if (reset) begin
    	apb_psel_o <= 0;
			apb_penable_o <= 0;
    	b <= 0;
      c <= 0;
    	a <= 0;
    	//st <= 0;
      end else if (event_a_i && !apb_pready_i) begin
        apb_psel_o <= 1;
        a <= a + 1;
      end  else if (event_b_i && !apb_pready_i) begin
        apb_psel_o <= 1;
        b <= b + 1;
      end  else if (event_c_i && !apb_pready_i) begin
        apb_psel_o <= 1;
        c <= c + 1;
      end else if (apb_psel_o == 1) 
        apb_penable_o <= 1;
    end
	
  if (apb_penable_o) begin
  assign apb_paddr_o = (event_a_i) ? 'hABBA0000 : 0;
  assign apb_paddr_o = (event_b_i) ? 'hBAFF0000 : 0;
  assign apb_paddr_o = (event_c_i) ? 'hCAFE0000 : 0;

  assign apb_pwdata_o = (event_a_i) ? a : 0;
  assign apb_pwdata_o = (event_a_i) ? b : 0;
  assign apb_pwdata_o = (event_a_i) ? c : 0;
  end
  
endmodule
