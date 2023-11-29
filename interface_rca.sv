interface rcainterface();
        logic [3:0]a,b;
        logic cin;
        logic [3:0]sum;
        logic carry;

        modport dut(input a,b,cin,output sum,carry);
        modport tb(output a,b,cin,input sum,carry);
endinterface
