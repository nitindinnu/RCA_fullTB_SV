class driver;
		transac tr;
		mailbox #(transac) g2d;

		function new(input mailbox #(transac) g2d);
			this.g2d=g2d;
		endfunction

		task run();
			//forever begin
					g2d.get(tr);
					tr.display("03DRV");
			//end
		endtask
endclass

class driver_ext extends driver;
        virtual rcainterface interf;

        function new(input mailbox #(transac) g2d,virtual rcainterface interf) ;
                super.new(g2d);
                this.interf=interf;
        endfunction



        task run();
            //#1;
            forever begin
                super.run();
                tr.display("04TR2INT");
                fork
                    interf.a=tr.a;
                    interf.b=tr.b;
                    interf.cin=tr.cin;
                join
                chk_interface("05D2I");
            end
        endtask

       

        task chk_interface(string msg="NO MSG");
                $display("\t>>[%2t] [%0s]<< INPUTS: a=%3d,b=%3d,cin=%3d| OUTPUTS: sum=%3d,carry=%3d",$time,msg.toupper,interf.a,interf.b,interf.cin,interf.sum,interf.carry);
                $write("\n");
        endtask
endclass
