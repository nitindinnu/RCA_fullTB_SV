class opmonitor;
        transac tr;
        virtual rcainterface interf;

        function new(virtual rcainterface interf);
                this.interf=interf;
        endfunction

        task run();
                //$display("HI OP MON");
                tr=new();
                //forever begin
                     @(interf.sum,interf.carry)  begin
                            chk_interface("06OPMON");
                            tr.sum=interf.sum;
                            tr.carry=interf.carry;
                            tr.display("OP MON TRANSACTION i.e: output from DUT");
                      end
                //end
        endtask

        task chk_interface(string msg="NO MSG");
                $display("\t>>[%2t] [%0s]<< INPUTS: a=%3d,b=%3d,cin=%3d| OUTPUTS: sum=%3d,carry=%3d",$time,msg.toupper,interf.a,interf.b,interf.cin,interf.sum,interf.carry);
                $write("\n");
        endtask
endclass

class opmon_ext extends opmonitor;
        mailbox #(transac) om2s;

        function new(mailbox #(transac) om2s,virtual rcainterface interf);
                super.new(interf);
                this.om2s=om2s;
        endfunction

        task run();
             forever begin
                 super.run();
                 //om2s=new(); create mmemory for mailbox here or at environment
                 om2s.put(tr);
                 tr.display("OPM2S mailbox data");
             end
        endtask


endclass
