----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.04.2018 19:29:42
-- Design Name: 
-- Module Name: mux_2_1 - Behavioral
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

entity mux_2_1 is
  port (
        op1,op2:in std_logic_vector(31 downto 0);
        sel: in std_logic;
        res:out std_logic_vector(31 downto 0)
    
     );
end mux_2_1;

architecture Behavioral of mux_2_1 is

begin
    process(op1,op2,sel)
    begin
        case sel is
            when '1' =>
                res <= op2;
            when '0' =>
                res <= op1;
            when others => null;
        end case;
    end process;

end Behavioral;
