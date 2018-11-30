----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.03.2018 14:55:15
-- Design Name: 
-- Module Name: proc_mem - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity proc_memory_path is
    Port ( 
        addr:in std_logic_vector(31 downto 0);
        clk:in std_logic;
        rd:out std_logic_vector(31 downto 0);
        wd:in std_logic_vector(31 downto 0);
        mr:in std_logic;
        MW:in std_logic;
        reset:in std_logic
);
end proc_memory_path;

architecture Behavioral of proc_memory_path is
--signal temp_proc,temp_mem:std_logic_vector(31 downto 0);
type dog is  array(0 to 50) of std_logic_vector(7 downto 0);
signal tem:dog;
signal ctrl:std_logic_vector(1 downto 0);
signal nxt_ctrl:std_logic;

begin

process(clk)
    variable half_word:std_logic_vector(15 downto 0);
    variable wrd:std_logic_vector(31 downto 0);
    variable bite:std_logic_vector(7 downto 0);
begin
    if reset='1' then 
            tem<=(others=>(others=>'0'));
    else 
        if rising_edge(clk) then
            if(mr='1') then --ldr,ldrb,ldrsh,ldrsb,ldrh
                if(ctrl="00") then  --- byte offset  --- ldrb ldrsb
                    bite:=tem(to_integer(unsigned(addr)));
                    if(nxt_ctrl='1') then ---- ldrsb
                            if(bite(7)='1') then 
                            rd<=(
                                7=> bite(7),
                                6=> bite(6),
                                5=> bite(5),
                                4=> bite(4),
                                3=> bite(3),
                                2=> bite(2),
                                1=> bite(1),
                                0=> bite(0),
                                others=>'1'
                                );
                            else 
                               rd<=(
                               7=> bite(7),
                               6=> bite(6),
                               5=> bite(5),
                               4=> bite(4),
                               3=> bite(3),
                               2=> bite(2),
                               1=> bite(1),
                               0=> bite(0),
                               others=>'0'
                               );
                            end if;
                    else   ---- ldrb
                            rd<=(
                            7=> bite(7),
                            6=> bite(6)
                            ,5=> bite(5),
                            4=> bite(4),
                            3=> bite(3),
                            2=> bite(2),
                            1=> bite(1),
                            0=> bite(0),
                            others=>'0'
                            );     
                    end if;
                elsif (ctrl="01") then  ---- hw offset  ----- ldrh ldrsh
                    half_word:=tem(to_integer(unsigned(addr))+1)&tem(to_integer(unsigned(addr)));
                    if(nxt_ctrl='1') then  --- ldrsh
                            if(half_word(15)='1') then
                                rd<=(15=>half_word(15),
                                    14=> half_word(14),
                                     13=> half_word(13),
                                    12=> half_word(12),
                                    11=> half_word(11),
                                    10=> half_word(10),
                                    9=> half_word(9),
                                    8=> half_word(8), 
                                    7=> half_word(7),
                                    6=> half_word(6),
                                    5=> half_word(5),
                                    4=> half_word(4),
                                    3=> half_word(3),
                                    2=> half_word(2),
                                    1=> half_word(1),
                                    0=> half_word(0),
                                    others=>'1');
                            else
                            rd<=(15=>half_word(15),
                                14=> half_word(14),
                                 13=> half_word(13),
                                12=> half_word(12),
                                11=> half_word(11),
                                10=> half_word(10),
                                9=> half_word(9),
                                8=> half_word(8), 
                                7=> half_word(7),
                                6=> half_word(6),
                                5=> half_word(5),
                                4=> half_word(4),
                                3=> half_word(3),
                                2=> half_word(2),
                                1=> half_word(1),
                                0=> half_word(0),
                                others=>'0');
                                end if;
                        else 
                           rd<=(15=>half_word(15),
                             14=> half_word(14),
                              13=> half_word(13),
                             12=> half_word(12),
                             11=> half_word(11),
                             10=> half_word(10),
                             9=> half_word(9),
                             8=> half_word(8), 
                             7=> half_word(7),
                             6=> half_word(6),
                             5=> half_word(5),
                             4=> half_word(4),
                             3=> half_word(3),
                             2=> half_word(2),
                             1=> half_word(1),
                             0=> half_word(0),
                             others=>'0');
                             end if;                    
                elsif (ctrl="10") then  ---- word   ----- ldr
                    rd<=tem(to_integer(unsigned(addr))+1)&tem(to_integer(unsigned(addr)))&tem(to_integer(unsigned(addr))+1)&tem(to_integer(unsigned(addr)));
                end if;
            elsif (mw='1') then  --- str
                if(ctrl="00") then  --- byte offset --- strb
                        tem(to_integer(unsigned(addr)))<= wd(7 downto 0);
                elsif (ctrl="01") then
                        tem(to_integer(unsigned(addr))+1)<=wd(15 downto 8);
                        tem(to_integer(unsigned(addr)))<=wd(7 downto 0);
                elsif (ctrl="10") then
                        tem(to_integer(unsigned(addr))+3)<=wd(31 downto 24);
                        tem(to_integer(unsigned(addr))+2)<=wd(23 downto 16);
                        tem(to_integer(unsigned(addr))+1)<=wd(15 downto 8);
                        tem(to_integer(unsigned(addr)))<=wd(7 downto 0);
                end if;
            end if;
        end if;
    end if;
end process;


end Behavioral;
