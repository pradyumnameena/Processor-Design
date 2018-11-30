----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.04.2018 19:58:50
-- Design Name: 
-- Module Name: B_Ctrl - Behavioral
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

entity Bcontroller is
	port (
			instruction : in STD_LOGIC_VECTOR(3 DOWNTO 0);
			in_flag : in STD_LOGIC_VECTOR(3 DOWNTO 0);
			--out flag order is 
			--0 means N 
			--1 means Z 
			--2 means C 
			--3 means V
			p : out STD_LOGIC
		);
end Bcontroller;

architecture Bcontroller_arch of Bcontroller is
begin
	process(instruction)
	begin
		case (in_flag) is
			when "0000" => 
				p <= in_flag(1);
			when "0001" => 
				p <= not in_flag(1);
			when "0010" => 
				p <= in_flag(2);
			when "0011" => 
				p <= not in_flag(2);
			when "0100" => 
				p <= in_flag(0);
			when "0101" => 
				p <= not in_flag(0);
			when "0110" => 
				p <= in_flag(3);
			when "0111" => 
				p <= not in_flag(3);
			when "1000" => 
				p <= in_flag(2) and (not in_flag(1));
			when "1001" => 
				p <= in_flag(1) or (not in_flag(2));
			when "1010" => 
				p <= not (in_flag(0) xor in_flag(3));
			when "1011" => 
				p <= in_flag(0) xor in_flag(3);
			when "1100" => 
				p <= (not in_flag(1)) and (not (in_flag(0) xor in_flag(3)));
			when "1101" => 
				p <= in_flag(1) or (in_flag(0) xor in_flag(3));
			when "1110" => -- this has to be ignored
				p <= in_flag(1);
			when "1111" => -- figure out what to do with this
				p <= in_flag(1);
				
			when others => null;
		end case;
	end process;
end Bcontroller_arch;
