----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.04.2018 19:29:42
-- Design Name: 
-- Module Name: pc_regi - Behavioral
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
entity pc_regi is
	port (
			clock : in STD_LOGIC;
			sel : in STD_LOGIC;
			oldPC : in STD_LOGIC_VECTOR(31 DOWNTO 0);
			newPC : out STD_LOGIC_VECTOR(31 DOWNTO 0)
		);
end pc_regi;

architecture pc_regi_arch of pc_regi is
begin
process(clock)
begin
	if rising_edge(clock) then
		if sel='1' then
			newPC <= oldPC;
	 	end if;
	end if;
end process;
end pc_regi_arch;
