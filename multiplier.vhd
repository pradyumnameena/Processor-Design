----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.04.2018 19:29:42
-- Design Name: 
-- Module Name: multiplier - Behavioral
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

entity multiplier is 
port (
		op1 , op2 : in STD_LOGIC_VECTOR (31 DOWNTO 0);
		result : out STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
end;

architecture mul_arch of multiplier is
signal temp : STD_LOGIC_VECTOR(63 DOWNTO 0);
begin
temp <= op1 * op2;
result <= temp (31 DOWNTO 0);
end mul_arch;
