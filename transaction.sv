class transac;
		rand bit [3:0] a,b;
		bit cin=0;
		bit [3:0] sum;
		bit carry;
		
		function void display(string name="default message");
           			$display("\t>>[%2t] [%0s]<< INPUTS: a=%3d,b=%3d,cin=%3d| OUTPUTS: sum=%3d,carry=%3d",$time,name.toupper,a,b,cin,sum,carry);
                    $write("\n");
        endfunction

		bit ra,rb,rcin;

		constraint norep{a!=ra;b!=rb;}


		function void post_randomize();
				ra=a;
				rb=b;
		endfunction
endclass
