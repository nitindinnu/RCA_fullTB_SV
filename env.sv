`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "opmonitor.sv"
`include "ipmonitor.sv"
`include "scoreboard.sv"

class environment;
        //generator gr;
		/////////////
		m_gen gr;
		mailbox #(transac) g2d;
		mailbox #(transac) im2s;
		mailbox #(transac) om2s;
		//driver drv;
		driver_ext drv;
        //opmonitor opmn;
        opmon_ext opmn;
        //ipmonitor ipmn;
        ipmon_ext ipmn;
        scoreboard scbd;

        virtual rcainterface rcaintf;

        

        function new(virtual rcainterface rcaintf);
                this.rcaintf=rcaintf;
        endfunction

        function void build();
                    g2d=new();
                    im2s=new();
                    om2s=new();
                    gr=new(g2d);
                    drv=new(g2d,rcaintf);
                    opmn=new(om2s,rcaintf);
                    ipmn=new(im2s,rcaintf);
                    scbd =new(im2s,om2s);
        endfunction

		task run();
                build();
                fork
  				    gr.run();
				    drv.run();
                    opmn.run();
                    ipmn.run();
                    scbd.run();
                join
		endtask
endclass
