----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.04.2018 19:29:42
-- Design Name: 
-- Module Name: mux_3bits_2_1 - Behavioral
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

entity mux_3bits_2_1 is
	port (
			op1 : in STD_LOGIC_VECTOR(3 DOWNTO 0);
			op2 : in STD_LOGIC_VECTOR(3 DOWNTO 0);
			sel : in STD_LOGIC;
			res : out STD_LOGIC_VECTOR(3 DOWNTO 0)
		);
end mux_3bits_2_1;

architecture mux_3bits_2_1_arch of mux_3bits_2_1 is
begin
	process(sel,op1,op2)
        begin
           case sel is
                when '0' => 
                    res <= op1;
                when '1' =>
                    res <= op2;
                when others => null;
              end case;
        end process;
end mux_3bits_2_1_arch;
