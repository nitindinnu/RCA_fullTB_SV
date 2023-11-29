class scoreboard;
        static byte unsigned passes=0,fails=0;
        transac ref_out,dut_out;
        mailbox #(transac) im2s,om2s;

        function new(mailbox #(transac) im2s,om2s);
            this.im2s=im2s;
            this.om2s=om2s;
        endfunction

        task run();
               ref_out=new();
               dut_out=new();

               forever begin
                        im2s.get(ref_out);
                        om2s.get(dut_out);
                        scoreboard_outs();
                        if(ref_out.sum==dut_out.sum && ref_out.carry==dut_out.carry) begin
                            passes=passes+1;
                            test_result("AT SCOREBOARD PASSED",passes);
                        end
                        else begin
                            fails=fails+1;
                            test_result("AT SCOREBOARD FAILED",fails);
                        end
               end

         endtask

          task scoreboard_outs();
                    $display("SCOREBOARD ref_out[sum=%0d,carry=%0d] | dut_out[sum=%0d,carry=%0d]",ref_out.sum,ref_out.carry,dut_out.sum,dut_out.carry);
          endtask

          task test_result(string msg,byte count);
              $display("\t %0s WITH COUNT %0d",msg,count);
              $write("\n");
          endtask

endclass
