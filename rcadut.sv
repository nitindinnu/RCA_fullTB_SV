//plain dut
module rcadut(carry,sum,a,b,cin);
        input logic [3:0]a,b;
        input logic cin;
        output logic [3:0]sum;
        output logic carry;

        always_comb begin
                {carry,sum}=a+b+cin;
                displ("07DUT");
        end

        task displ(string name);
            $display("\t>>[%2t] [%0s]<< INPUTS: a=%3d,b=%3d,cin=%3d| OUTPUTS: sum=%3d,carry=%3d",$time,name.toupper,a,b,cin,sum,carry);
                    $write("\n");
        endtask
endmodule
