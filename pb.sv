`include "test.sv"
program tb(rcainterface rcaintf);
        test tt;
        initial begin
            tt=new(rcaintf);
            tt.run();
        end

        final begin
            $display("TOTAL PASS=%0d FAILS=%0d out of RANDOMIZATION=%0d",scoreboard::passes,scoreboard::fails,generator::repeat_count);
        end
endprogram


