----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.04.2018 19:29:42
-- Design Name: 
-- Module Name: mux_4_1 - Behavioral
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

entity mux_4_1 is
	port (
			op1 : in STD_LOGIC_VECTOR(31 DOWNTO 0);
			op2 : in std_logic_vector(31 downto 0);
			op3 : in STD_LOGIC_VECTOR(31 DOWNTO 0);
			op4 : in STD_LOGIC_VECTOR(31 DOWNTO 0);
			sel : in STD_LOGIC_VECTOR(1 DOWNTO 0);
			res : out STD_LOGIC_VECTOR(31 DOWNTO 0)
		);
end mux_4_1;


architecture mux_4_1_arch of mux_4_1 is
signal two : STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000100";
begin
	process(op1,sel,op3,op4)
        begin
           case (sel) is
            when "00" => 
                res <= op1;
            when "01" =>
                res <= two;
            when "10" => 
                res <= op3;
            when "11" =>
                res <= op4;
            when others => null;
            end case;
        end process;
end mux_4_1_arch;
