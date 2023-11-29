class ipmonitor;
        transac tr;
        virtual rcainterface interf;

        function new(virtual rcainterface interf);
                this.interf=interf;
        endfunction

        task run();
            tr=new();
            //forever begin
                        chk_interface("08IPMON");
                        tr.a=interf.a;
                        tr.b=interf.b;
                        tr.cin=interf.cin;
                        bfm();
            //end
        endtask

        task chk_interface(string msg="NO MSG");
                $display("\t>>[%2t] [%0s]<< INPUTS: a=%3d,b=%3d,cin=%3d| OUTPUTS: sum=%3d,carry=%3d",$time,msg.toupper,interf.a,interf.b,interf.cin,interf.sum,interf.carry);
                $write("\n");
        endtask

        task bfm();
                {tr.carry,tr.sum}=tr.a+tr.b+tr.cin;
                tr.display("IP MON TRANSACTION");
        endtask

endclass

class ipmon_ext extends ipmonitor;
        mailbox #(transac) im2s;

        function new(mailbox #(transac) im2s,virtual rcainterface interf);
                super.new(interf);
                this.im2s=im2s;
        endfunction

        task run();
             forever begin
				@(interf.a|interf.b|interf.cin)
                 super.run();
                 //im2s=new(); create mmemory for mailbox here or at environment
                 im2s.put(tr);
                 tr.display("I2S mailbox data");
             end
        endtask


endclass
