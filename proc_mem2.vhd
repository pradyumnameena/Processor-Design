----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.03.2018 20:29:33
-- Design Name: 
-- Module Name: proc_mem2 - Behavioral
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

entity proc_mem2 is
   Port ( 
        proc_in,mem_in : in std_logic_vector(31 downto 0);
        proc_out,mem_out : out std_logic_vector(31 downto 0);
        DT_type : in std_logic_vector(2 downto 0);
        WE_in : in std_logic_vector(3 downto 0);
        byte_off : in std_logic_vector(2 downto 0);
        WE_out : out std_logic_vector(3 downto 0)
   );
end proc_mem2;
-----  1,2,3
----
--ldr   -- 000
--ldrb  -- 001
--ldrsb -- 010
--ldrsh -- 011
--ldrh  -- 100
--str   -- 101
--strb  -- 110
--strh  -- 111

architecture Behavioral of proc_mem2 is

begin
process(proc_in,mem_in,DT_type)
begin
 case(DT_type) is
 when "000" => proc_out<=mem_in;
 when "001" => case(byte_off) is
                    when "00"=> proc_out(7 downto 0)<= mem_in(7 downto 0);
                                proc_out(31 downto 8)<=(others=>'0');
                    when "01"=> proc_out(7 downto 0)<= mem_in(15 downto 8);
                                  proc_out(31 downto 8)<=(others=>'0');

                    when "10"=> proc_out(7 downto 0)<= mem_in(23 downto 16);
                                proc_out(31 downto 8)<=(others=>'0');

                     when "11"=>proc_out(7 downto 0)<= mem_in(31 downto 24);
                                 proc_out(31 downto 8)<=(others=>'0');
                     when others =>null;
                end case;
 when "010" => 
                      case(byte_off) is
                     when "00"=> 
                                proc_out(7 downto 0)<= mem_in(7 downto 0);
                                if (mem_in(7) = '1') then
                                 proc_out(31 downto 8)<=(others=>'1');
                                 else proc_out(31 downto 8)<=(others=>'0');
                                 end if;
                     when "01"=> proc_out(7 downto 0)<= mem_in(15 downto 8);
                                   if (mem_in(15) = '1') then
                                                      proc_out(31 downto 8)<=(others=>'1');
                                                      else proc_out(31 downto 8)<=(others=>'0');
                                                      end if;
 
                     when "10"=> proc_out(7 downto 0)<= mem_in(23 downto 16);
                                 if (mem_in(23) = '1') then
                                                      proc_out(31 downto 8)<=(others=>'1');
                                                      else proc_out(31 downto 8)<=(others=>'0');
                                                      end if;
 
                      when "11"=>proc_out(7 downto 0)<= mem_in(31 downto 24);
                                 if (mem_in(31) = '1') then
                                   proc_out(31 downto 8)<=(others=>'1');
                                   else proc_out(31 downto 8)<=(others=>'0');
                                   end if;
                      when others =>null;
                 end case; 
 when "011"=>  case(byte_off) is
                                    when "00"=> proc_out(15 downto 0)<= mem_in(15 downto 0);
                                    if (mem_in(15) = '1') then
                                                proc_out(31 downto 16)<=(others=>'1');
                                                else proc_out(31 downto 16)<=(others=>'0');
                                          end if;
                                    when "01"=> proc_out(15 downto 0)<= mem_in(31 downto 15);
                                                 if (mem_in(31) = '1') then
                                                 proc_out(31 downto 16)<=(others=>'1');
                                                 else proc_out(31 downto 16)<=(others=>'0');
                                              end if;
                                     when others =>null;
                                end case;
 when "100"=> case(byte_off) is
                    when "00"=> proc_out(15 downto 0)<= mem_in(15 downto 0);
                                proc_out(31 downto 16)<=(others=>'0');
                    when "01"=> proc_out(15 downto 0)<= mem_in(31 downto 15);
                                 proc_out(31 downto 16)<=(others=>'0');
                     when others =>null;
                end case;
 when "101"=> mem_out<=proc_in;
 when "110"=> mem_out<= proc_in;            
 when "111"=> mem_out <= proc_in;
 when others=> null;
 end case;
end process;
WE_out <= WE_in;

end Behavioral;
