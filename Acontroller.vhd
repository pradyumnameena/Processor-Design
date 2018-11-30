----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.04.2018 20:59:00
-- Design Name: 
-- Module Name: Acontroller - Behavioral
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

entity Acontroller is
  Port ( 
        instr,decoder : in STD_LOGIC_VECTOR(3 DOWNTO 0);
        opcode : out STD_LOGIC_VECTOR(3 DOWNTO 0)
        );
end Acontroller;

architecture Behavioral of Acontroller is

begin
    process(instr,decoder)
        begin
            case(decoder(7 DOWNTO 6)) is
            when "00" =>
                 if(decoder(1 DOWNTO 0)="00") then
                    if(decoder(5 DOWNTO 2)="0110") then
                        opcode <= "1101";
                    end if;
                 end if;
            when "01" =>
                 if(decoder(1 DOWNTO 0)="00") then
                     if (instr(2)='1') then
                        opcode <= "0100";
                     else
                        opcode <= "0010";
                     end if;
                 end if;
            when "10" =>
                if(decoder(1 DOWNTO 0)="00") then
                opcode <= "0100";
                end if;
            when others => null;
            end case;
        end process;

end Behavioral;
