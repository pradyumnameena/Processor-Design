----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.04.2018 19:29:42
-- Design Name: 
-- Module Name: alu - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity alu is 
port (
		op1 , op2 : in STD_LOGIC_VECTOR (31 DOWNTO 0);
		result : out STD_LOGIC_VECTOR (31 DOWNTO 0);
		opcode : in STD_LOGIC_VECTOR (3 DOWNTO 0);
--		clock : in std_logic;
		carry : in STD_LOGIC;
		out_flag : out STD_LOGIC_VECTOR (3 DOWNTO 0)
		--out flag order is 
		--0 means N 
		--1 means Z 
		--2 means C 
		--3 means V
	);
end;

architecture ALU_arch of alu is
--signal carry_sig : STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
--signal one_sig : STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000001";
--signal operand1,operand2 : STD_LOGIC_VECTOR(32 DOWNTO 0);
--signal temp : STD_LOGIC_VECTOR(32 DOWNTO 0) := "000000000000000000000000000000000";
--begin
----operand1(31 DOWNTO 0) <= op1; 
----operand2(31 DOWNTO 0) <= op2; 
----operand2(32) <= '0';
----operand1(32) <= '0';
--operand1 <= '0'&op1;
--operand2 <= '0'&op2;
--carry_sig(0) <= carry;


--dp_op : process(op1,op2,opcode,carry)
--begin		
--    case opcode is
--        when "0000" => --and 
--            temp <= operand1 and operand2;
--        when "0001" => --xor
--            temp <= operand1 xor operand2;
--        when "0010" => --sub
--            temp <= operand1 - operand2;
--        when "0011" => --rsb
--            temp <= operand2 - operand1;
--        when "0100" => --add
--            temp <= operand1 + operand2;
--        when "0101" => --adc
--            temp <= operand1 + operand2 + carry_sig;
--        when "0110" => --sbc
--            temp <= operand1 - operand2 + carry_sig - one_sig;
--        when "0111" => --rsc
--            temp <= operand2 - operand1 + carry_sig - one_sig;
--        when "1000" => --tst
--            temp <= operand1 and operand2;
--        when "1001" => --teq
--            temp <= operand1 xor operand2;
--        when "1010" => --cmp
--            temp <= operand1 - operand2;
--        when "1011" => --cmn
--            temp <= operand1 + operand2;
--        when "1100" => --orr
--            temp <= operand1 or operand2;
--        when "1101" => --mov
--            temp <= operand2;
--        when "1110" => --bic
--            temp <= operand1 and (not operand2);
--        when "1111" => --mvn
--            temp <= not operand2;
--        when others => null;
--    end case;
--end process;

--comp:process(temp)
--begin			
--        out_flag(0) <= temp(31);
--        if temp(31 DOWNTO 0)="00000000000000000000000000000000" then
--            out_flag(1) <= '1';
--        else
--             out_flag(1) <= '0';   
--        end if;
--            out_flag(2) <= temp(32);
--            out_flag(3) <= temp(32) xor (op1(31) xor op2(31) xor temp(31));
----        end if;
----	end process;

--end process;
--result <= temp(31 DOWNTO 0);	
signal temp:std_logic_vector(32 downto 0);
signal carry_load:std_logic_vector(31 downto 0);
signal in1_wrap,in2_wrap:std_logic_vector(32 downto 0);
begin
-- In order to add the carry at last of the 
in1_wrap<='0' & op1;
in2_wrap<= '0' & op2;
carry_load <=(0=> carry,others=>'0');
process(opcode,in1_wrap,in2_wrap,carry_load)
begin
case opcode is
when "0100" => temp <= in1_wrap + in2_wrap; -- add
when "0101" => temp <= in1_wrap + in2_wrap + carry_load; -- adc
when "0010" => temp <= in1_wrap + (not in2_wrap) + 1 ; -- sub
when "0110" => temp <= in1_wrap - in2_wrap + carry_load; -- sbc
when "0111" => temp <= in2_wrap - in1_wrap + carry_load;--rsc
when "0011" => temp <= in2_wrap - in1_wrap;--rsb
when "0000" => temp <= in1_wrap and in2_wrap;--and
when "1100" => temp <= in1_wrap or in2_wrap;--orr
when "0001" => temp <= in1_wrap xor in2_wrap;--eor
when "1011" => temp <= in1_wrap and (not in2_wrap);-- bic
when "1000" => temp <= in1_wrap and in2_wrap ; -- tst
when "1001" => temp <= in1_wrap xor in2_wrap;  -- teq
when "1010" => temp <= in1_wrap + (not in2_wrap) + 1; -- cmp
--when "1011" => temp <= in1_wrap + in2_wrap; -- cmn
when "1101" => temp <= in2_wrap; -- mov
when "1110" => temp <= in1_wrap and (not in2_wrap); -- bic
when "1111" => temp <= (not in2_wrap);

when others => null;
end case;
end process;

process(temp,op1,op2)
begin
out_flag(1) <= not( temp(31) or temp(30) or temp(29) or temp(28) or temp(27) or temp(26) or temp(25) or temp(24) or temp(23) or temp(22) or temp(21) or temp(20) or temp(19) or temp(18) or temp(17) or temp(16) or temp(15) or temp(14) or temp(13) or temp(12) or temp(11) or temp(10) or temp(9) or temp(8) or temp(7) or temp(6) or temp(5) or temp(4) or temp(3) or temp(2) or temp(1) or temp(0) ); 
out_flag(0) <= temp(31);
out_flag(3) <= temp(32) xor ( op1(31) xor op2(31) xor temp(31) );
out_flag(2) <= temp(32);
end process;


result<=temp(31 downto 0);

end ALU_arch;
