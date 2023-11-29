`include "interface_rca.sv"
`include "rcadut.sv"
`include "pb.sv"

module top;
        
        //INTERFACE
        rcainterface rcaintf();
        
        //DUT
        rcadut a1( .carry(rcaintf.carry),
                   .sum(rcaintf.sum),
                   .a(rcaintf.a),
                   .b(rcaintf.b),
                   .cin(rcaintf.cin)
                   ); //mapping interface to dut by name
        
        //PROGRAM
        tb a2(rcaintf);
endmodule
