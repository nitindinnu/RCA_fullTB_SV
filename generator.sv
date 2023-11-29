class generator;
        static byte unsigned repeat_count=20;
		transac tr=new();

		task run();
				//tr=new();
				//repeat(1) begin
					tr.randomize();
					tr.display("01GEN");
				//end
		endtask
endclass

class m_gen extends generator;
		mailbox #(transac) g2d;

		function new(input mailbox #(transac) g2d);
			this.g2d=g2d;
		endfunction

		task run();
				repeat(repeat_count) begin
					super.run();
					g2d.put(tr);
					tr.display("02G2M");
                    #1;
                end
		endtask


endclass

