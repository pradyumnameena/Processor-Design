library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity controller is
--structure of flag is 
--                       0 => N 
--                       1 => Z
--                       2 => C
--                       3 => V 
        port (
			instruction : in STD_LOGIC_VECTOR(31 DOWNTO 0);
			in_flag : in STD_LOGIC_VECTOR(3 DOWNTO 0);
			clk : in STD_LOGIC;
			reset : in STD_LOGIC;
			PW,IorD,MR,MW,AW,BW,ReW,RW,DW,IW,Asrc1,Rsrc,M2R,Fset : out STD_LOGIC;
			Asrc2 : out STD_LOGIC_VECTOR(1 DOWNTO 0);
			opcode_cont : out STD_LOGIC_VECTOR(3 DOWNTO 0)

		);
end controller;

architecture Behavioral of controller is

type state_type is (fetch,rdAB,arith,addr,brn,wrRF,wrM,rdM,M2RF);
signal state, next_state : state_type;
--signal opcode_cont: STD_LOGIC_VECTOR(3 downto 0);
signal p :STD_LOGIC;
begin

P_CALC: process(instruction)
	begin
		case (instruction(31 downto 28)) is
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

SYNC_PROC : process (clk) 
	begin
		if rising_edge(clk) then 
			if (reset = '1') then
		        state <= fetch;
		    else
                state <= next_state;
		    end if;
		end if;
	end process;

NEXT_STATE_DECODE : process (state)
    begin
      	case (state) is
    
            when fetch =>
            	PW <= '1';
            	IW <= '1';
            	MR <= '1';
            	IorD <= '0';
            	Asrc1 <= '0';
            	Asrc2 <= "01";
            	opcode_cont <= "0100";
                next_state <= rdAB;

            when rdAB =>
            	AW <= '1';
            	BW <= '1';
            	Rsrc <= '0';
                if (instruction(27 DOWNTO 26)="00") then
                    next_state <= arith;
                end if;
                if(instruction(27 DOWNTO 26)="01") then
                    next_state <= addr;
                end if;
                if(instruction(27 DOWNTO 26)="10") then
                    next_state <= brn;
                end if;
                	
            when arith =>
            	ReW <= '1';
            	Asrc1 <= '1';
            	Asrc2 <= "00";
            	Fset <= p;
            	opcode_cont <= instruction(24 DOWNTO 21);
                next_state <= wrRF;

            when addr =>
            	ReW <= '1';
            	Asrc1 <= '1';
            	Rsrc <= '1';
                Asrc2 <= "10";
                if(instruction(23)='0') then
                	opcode_cont <= "0010";
                else
                	opcode_cont <= "0100";
                end if;

                if(instruction(20)='0') then
                	next_state <= wrM;
                else
                	next_state <= rdM;
                end if;

            when brn =>
            	PW <= p; 
            	Asrc1 <= '0';
            	Asrc2 <= "11";
            	opcode_cont <= "0100";
                next_state <= fetch;

            when wrRF =>
            	RW <= p; 
            	M2R <= '0';
                next_state <= fetch;

            when wrM =>
            	MW <= p;
            	IorD <= '1';
                next_state <= fetch;

            when rdM =>
            	DW <= '1';
            	MR <= '1';
            	IorD <= '1';
                next_state <= M2RF;

            when M2RF =>
            	M2R <= '1';
            	RW <= p;
                next_state <= fetch;

            when others => null;
        end case;
	end process;
end Behavioral;