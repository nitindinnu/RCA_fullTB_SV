`include "env.sv"
class test;
        environment env;
        virtual rcainterface interr;

        function new(virtual rcainterface interr);
                   this.interr=interr;
        endfunction

        task run();
                env=new(interr);
                env.run();
        endtask

endclass
