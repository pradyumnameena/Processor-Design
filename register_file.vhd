----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.04.2018 19:29:42
-- Design Name: 
-- Module Name: register_file - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity register_file is 

	port (
		input_data : in STD_LOGIC_VECTOR (31 DOWNTO 0);
		read1 : in STD_LOGIC_VECTOR (3 DOWNTO 0);
		read2 : in STD_LOGIC_VECTOR (3 DOWNTO 0);
		write1 : in STD_LOGIC_VECTOR (3 DOWNTO 0);
		clock : in STD_LOGIC;
		reset : in STD_LOGIC;
		write_enable : in STD_LOGIC;
		out1 : out STD_LOGIC_VECTOR(31 DOWNTO 0);
		out2 : out STD_LOGIC_VECTOR(31 DOWNTO 0)
		);
end register_file;

architecture regi_architecture of register_file is
type regi_array is array(15 DOWNTO 0) of STD_LOGIC_VECTOR(31 DOWNTO 0);
signal regi_file : regi_array :=(0=>"00000000000000000000000000000000",
                                 1=>"00000000000000000000000000000001",
                                 2=>"00000000000000000000000000000010",
                                 3=>"00000000000000000000000000000011",
                                 4=>"00000000000000000000000000000100",
                                 5=>"00000000000000000000000000000101",
                                 6=>"00000000000000000000000000000110",
                                 7=>"00000000000000000000000000000111",
                                 8=>"00000000000000000000000000001000",
                                 9=>"00000000000000000000000000001001",
                                 10=>"00000000000000000000000000001010",
                                 11=>"00000000000000000000000000001011",
                                 12=>"00000000000000000000000000001100",
                                 13=>"00000000000000000000000000001101",
                                 14=>"00000000000000000000000000001110",
                                 15=>"00000000000000000000000000001111"
                                 );
signal seg : std_logic_vector(31 downto 0) := (others=>'0');
begin
regi_file(0) <= "00000000000000000000000000000000";
regi_file(1) <= "00000000000000000000000000000001";
regi_file(2) <= "00000000000000000000000000000010";
regi_file(3) <= "00000000000000000000000000000011";
regi_file(4) <= "00000000000000000000000000000100";
regi_file(5) <= "00000000000000000000000000000101";
regi_file(6) <= "00000000000000000000000000000110";
regi_file(7) <= "00000000000000000000000000000111";
regi_file(8) <= "00000000000000000000000000001000";
regi_file(9) <= "00000000000000000000000000001001";
regi_file(10) <= "00000000000000000000000000001010";
regi_file(11) <= "00000000000000000000000000001011";
regi_file(12) <= "00000000000000000000000000001100";
regi_file(13) <= "00000000000000000000000000001101";
regi_file(14) <= "00000000000000000000000000001110";
regi_file(15) <= "00000000000000000000000000001111";



reading_port1:process(read1,regi_file)
begin
	case(read1) is
		when "0000" => 
			out1<= regi_file(0);
		when "0001" => 
			out1<= regi_file(1);
		when "0010" => 
			out1<= regi_file(2);
		when "0011" => 
			out1<= regi_file(3);
		when "0100" => 
			out1<= regi_file(4);
		when "0101" => 
			out1<= regi_file(5);
		when "0110" => 
			out1<= regi_file(6);
		when "0111" => 
			out1<= regi_file(7);
		when "1000" => 
			out1<= regi_file(8);
		when "1001" => 
			out1<= regi_file(9);
		when "1010" => 
			out1<= regi_file(10);
		when "1011" => 
			out1<= regi_file(11);
		when "1100" => 
			out1<= regi_file(12);
		when "1101" => 
			out1<= regi_file(13);
		when "1110" => 
			out1<= regi_file(14);
		when "1111" => 
			out1<= regi_file(15);
		when others=>null;
	end case;
end process;

reading_port2:process(read2,regi_file)
begin
	case(read2) is
		when "0000" => 
			out2<= regi_file(0);
		when "0001" => 
			out2<= regi_file(1);
		when "0010" => 
			out2<= regi_file(2);
		when "0011" => 
			out2<= regi_file(3);
		when "0100" => 
			out2<= regi_file(4);
		when "0101" => 
			out2<= regi_file(5);
		when "0110" => 
			out2<= regi_file(6);
		when "0111" => 
			out2<= regi_file(7);
		when "1000" => 
			out2<= regi_file(8);
		when "1001" => 
			out2<= regi_file(9);
		when "1010" => 
			out2<= regi_file(10);
		when "1011" => 
			out2<= regi_file(11);
		when "1100" => 
			out2<= regi_file(12);
		when "1101" => 
			out2<= regi_file(13);
		when "1110" => 
			out2<= regi_file(14);
		when "1111" => 
			out2<= regi_file(15);
		when others=>null;
	end case;
end process;

writing_port:process(clock,reset,write1)
begin
	if reset='1' then
		regi_file(15) <= (others=>'0');	
	else
		if rising_edge(clock) then
			if write_enable='1' then
				case write1 is
					when "0000" => 
						regi_file(0) <= input_data;
					when "0001" => 
						regi_file(1) <= input_data;
					when "0010" => 
						regi_file(2) <= input_data;
					when "0011" => 
						regi_file(3) <= input_data;
					when "0100" => 
						regi_file(4) <= input_data;
					when "0101" => 
						regi_file(5) <= input_data;
					when "0110" => 
						regi_file(6) <= input_data;
					when "0111" => 
						regi_file(7) <= input_data;
					when "1000" => 
						regi_file(8) <= input_data;
					when "1001" => 
						regi_file(9) <= input_data;
					when "1010" => 
						regi_file(10) <= input_data;
					when "1011" => 
						regi_file(11) <= input_data;
					when "1100" => 
						regi_file(12) <= input_data;
					when "1101" => 
						regi_file(13) <= input_data;
					when "1110" => 
						regi_file(14) <= input_data;
					when "1111" => 
						regi_file(15) <= input_data;					
					when others =>null;
				end case;
			end if;	
		end if;
	end if;
end process;

end regi_architecture;

