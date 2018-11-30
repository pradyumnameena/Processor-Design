----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.03.2018 14:53:32
-- Design Name: 
-- Module Name: main - Behavioral
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

entity main is
       port (	reset : in STD_LOGIC;
			--clock
			clock : in STD_LOGIC;
			--pw is update pc counter
--			PW : in STD_LOGIC;
			--output flags
			F : out STD_LOGIC_VECTOR(3 DOWNTO 0);
			--output instruction
			ins : in STD_LOGIC_VECTOR(31 DOWNTO 0)
		);
end main;

architecture Behavioral of main is

component controller is
  port (
          instruction : in STD_LOGIC_VECTOR(31 DOWNTO 0);
          in_flag : in STD_LOGIC_VECTOR(3 DOWNTO 0);
          clk : in STD_LOGIC;
          reset : in STD_LOGIC;
          PW,IorD,MR,MW,AW,BW,ReW,RW,DW,IW,Asrc1,Rsrc,M2R,Fset : out STD_LOGIC;
          Asrc2 : out STD_LOGIC_VECTOR(1 DOWNTO 0);
          opcode_cont : out STD_LOGIC_VECTOR(3 DOWNTO 0)

      );
end component;

component shift is 
    port(
            op1 : in STD_LOGIC_VECTOR (31 DOWNTO 0);
            result : out STD_LOGIC_VECTOR (31 DOWNTO 0);
            shifter_carry : out STD_LOGIC;
            opcode : in STD_LOGIC_VECTOR (1 DOWNTO 0);
            shift_amnt : in STD_LOGIC_VECTOR (31 DOWNTO 0)
    );
end component;

component BRAM_wrapper is 
	port (
	    BRAM_PORTA_addr : in STD_LOGIC_VECTOR ( 31 downto 0 );
	    BRAM_PORTA_clk : in STD_LOGIC;
	    BRAM_PORTA_din : in STD_LOGIC_VECTOR ( 31 downto 0 );
	    BRAM_PORTA_dout : out STD_LOGIC_VECTOR ( 31 downto 0 );
	    BRAM_PORTA_en : in STD_LOGIC;
	    BRAM_PORTA_rst : in STD_LOGIC;
	    BRAM_PORTA_we : in STD_LOGIC_VECTOR ( 3 downto 0 )
	  );
end component;

component alu is
	port (
		op1 , op2 : in STD_LOGIC_VECTOR (31 DOWNTO 0);
		result : out STD_LOGIC_VECTOR (31 DOWNTO 0);
		opcode : in STD_LOGIC_VECTOR (3 DOWNTO 0);
		carry : in STD_LOGIC;
		out_flag : out STD_LOGIC_VECTOR (3 DOWNTO 0)
		--out flag order is 
		--0 means N 
		--1 means Z 
		--2 means C 
		--3 means V
	);
end component;

component multiplier is 
	port (
		op1 , op2 : in STD_LOGIC_VECTOR (31 DOWNTO 0);
		result : out STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
end component;

component regi is
	port (
			input_data : in STD_LOGIC_VECTOR(31 DOWNTO 0);
			output_data : out STD_LOGIC_VECTOR(31 DOWNTO 0);
			sel : in STD_LOGIC;
			clock : in STD_LOGIC
		);
end component;

component pc_regi is
	port (
			clock : in STD_LOGIC;
			sel : in STD_LOGIC;
			oldPC : in STD_LOGIC_VECTOR(31 DOWNTO 0);
			newPC : out STD_LOGIC_VECTOR(31 DOWNTO 0)
		);
end component;

component register_file is
	port (
		input_data : in STD_LOGIC_VECTOR (31 DOWNTO 0);
		read1 : in STD_LOGIC_VECTOR (3 DOWNTO 0);
		read2 : in STD_LOGIC_VECTOR (3 DOWNTO 0);
		write1 : in STD_LOGIC_VECTOR (3 DOWNTO 0);
		clock : in STD_LOGIC;
		reset : in STD_LOGIC;
		write_enable : in STD_LOGIC;
		out1 : out STD_LOGIC_VECTOR(31 DOWNTO 0);
		out2 : out STD_LOGIC_VECTOR(31 DOWNTO 0)
		);
end component;

component shifter is
	port (
		op1 : in STD_LOGIC_VECTOR (31 DOWNTO 0);
		result : out STD_LOGIC_VECTOR (31 DOWNTO 0);
		shifter_carry : out STD_LOGIC;
--		opcode specifies type of shift and shift_amnt contains the 5lsbs of register or 5 bits of constant.
		opcode : in STD_LOGIC_VECTOR (1 DOWNTO 0);
		shift_amnt : in STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
end component;

--component shifter_mux is
--	port (
--		reg_input : in STD_LOGIC_VECTOR (31 DOWNTO 0);
--		const : in STD_LOGIC_VECTOR (4 DOWNTO 0);
--		sel : in STD_LOGIC;
--		result : out STD_LOGIC_VECTOR(4 DOWNTO 0)
--	);
--end component;

component flag_comp is
	port (
			oldF : in STD_LOGIC_VECTOR(3 DOWNTO 0);
			aluF : in STD_LOGIC_VECTOR(3 DOWNTO 0);
			s_bit : in STD_LOGIC;
			newF : out STD_LOGIC_VECTOR(3 DOWNTO 0)
		);
end component;

component mux_2_1 is
	port (
			op1 : in STD_LOGIC_VECTOR(31 DOWNTO 0);
			op2 : in STD_LOGIC_VECTOR(31 DOWNTO 0);
			sel : in STD_LOGIC;
			res : out STD_LOGIC_VECTOR(31 DOWNTO 0)
		);
end component;

component mux_4_1 is
	port (
			op1 : in STD_LOGIC_VECTOR(31 DOWNTO 0);
			op2 : in STD_LOGIC_VECTOR(31 DOWNTO 0);
			op3 : in STD_LOGIC_VECTOR(31 DOWNTO 0);
			op4 : in STD_LOGIC_VECTOR(31 DOWNTO 0);
			sel : in STD_LOGIC_VECTOR(1 DOWNTO 0);
			res : out STD_LOGIC_VECTOR(31 DOWNTO 0)
		);
end component;

component mux_3bits_2_1 is
	port (
			op1 : in STD_LOGIC_VECTOR(3 DOWNTO 0);
			op2 : in STD_LOGIC_VECTOR(3 DOWNTO 0);
			sel : in STD_LOGIC;
			res : out STD_LOGIC_VECTOR(3 DOWNTO 0)
		);
end component;

component extend1 is
	port (
			instruction : in STD_LOGIC_VECTOR(11 DOWNTO 0);
			result : out STD_LOGIC_VECTOR(31 DOWNTO 0)
		);
end component;

component extend2 is
	port (
			instruction : in STD_LOGIC_VECTOR(23 DOWNTO 0);
			result : out STD_LOGIC_VECTOR(31 DOWNTO 0)
		);
end component;


signal IR_in,IR_out,A_in,A_out,B_in,B_out,R_out,D_out : STD_LOGIC_VECTOR(31 DOWNTO 0);
signal ext_1,ext_2,mux_4_1_out,mux_2_1_out,alu_out,shift_out,iod_data,PC_out,dr_mux_out : STD_LOGIC_VECTOR(31 DOWNTO 0);
signal alu_flag,old_flag : STD_LOGIC_VECTOR(3 DOWNTO 0);
signal read_mux_out : STD_LOGIC_VECTOR(3 DOWNTO 0);
signal amount : STD_LOGIC_VECTOR(4 DOWNTO 0);
signal tempt : STD_LOGIC_VECTOR(3 downto 0) := (others=>'0');
signal read_memory : STD_LOGIC ;
signal op_alu : STD_LOGIC_VECTOR(3 downto 0);
signal PW,IorD,MR,MW,AW,BW,ReW,RW,DW,IW,Asrc1,Rsrc,M2R,Fset : std_logic;
signal Asrc2 : std_logic_vector(1 downto 0);
signal shift_carry : std_logic;

begin
--tempt <= MW&MW&MW&MW;
Control: controller
port map(
        instruction => ins,
        PW => PW,
        IorD => IorD,
        MR => MR,
        MW => MW,
        AW => AW,
        BW => BW,
        ReW => ReW,
        RW => RW,
        DW => DW,
        IW => IW,
        Asrc1 => Asrc1,
        Rsrc => Rsrc,
        M2R => M2R,
        Fset => Fset,
        Asrc2 => Asrc2,
        clk => clock,
        reset => reset,
        in_flag => old_flag,
        opcode_cont => op_alu
        
);


Flag: flag_comp
port map(
        oldF => old_flag,
        aluF => alu_flag,
        s_bit => Fset,
        newF => alu_flag
);

ALU_AREA: alu
port map(
        op1 => mux_2_1_out,
        op2 => mux_4_1_out,
        result => alu_out,
        opcode => op_alu,
        out_flag => alu_flag,
        carry => old_flag(2)      
);

Ins_mux: mux_3bits_2_1
port map(
    op1 => IR_out(3 downto 0),
    op2 => IR_out(15 downto 12),
    sel => Rsrc,
    res => read_mux_out
);

Regi_File: register_file
port map(
    input_data => dr_mux_out,
    read1 => IR_out(19 downto 16),
    read2 => read_mux_out,
    write1 => IR_out(15 downto 12),
    clock => clock,
    reset => reset,
    write_enable => RW,
    out1 => A_in,
    out2 => B_in
);

--PC: pc_regi
--port map(
--    clock => clock,
--    sel => PW,
--    oldPC => ins,
--    newPC => PC_out
--);

Unsigned_ext: extend1
port map(
        instruction => IR_out(11 downto 0),
        result => ext_1
);
  
Signed_ext: extend2
port map(
        instruction => IR_out(23 downto 0),
        result => ext_2
);
   
Op1_Mux: mux_2_1
port map(
        op1 => ins,
        op2 => A_out,
        sel => Asrc1,
        res => mux_2_1_out
);

--IorD_Mux: mux_2_1
--port map(
--        op1 => PC_out,
--        op2 => R_out,
--        sel => IorD,
--        res => iod_data
--);

DR_Mux: mux_2_1
port map(
        op1 => D_out,
        op2 => R_out,
        sel => M2R,
        res => dr_mux_out
);

Op2_Mux: mux_4_1
port map(
        op1 => B_out,
        op2 => B_out,
        op3 => ext_1,
        op4 => ext_2,
        sel => Asrc2,
        res => mux_4_1_out
);

A_Regi: regi
port map(
        input_data => A_in,
        output_data => A_out,
        sel => AW,
        clock => clock
);

B_Regi: regi
port map(
        input_data => shift_out,
        output_data => B_out,
        sel => BW,
        clock => clock
);

Res_Regi: regi
port map(
        input_data => alu_out,
        output_data => R_out,
        sel => ReW,
        clock => clock
);

IR_Regi: regi
port map(
--          input_data => PC_out,
        input_data => ins,
--        input_data => IR_in,
        output_data => IR_out,
        sel => IW,
        clock => clock
);

D_Regi: regi
port map(
--        input_data => ins,
        input_data => IR_in,
        output_data => D_out,
        sel => DW,
        clock => clock
);

--Mem: BRAM_wrapper
--port map(
--        BRAM_PORTA_addr => iod_data,
--	    BRAM_PORTA_clk => clock,
--	    BRAM_PORTA_din => B_out,
--	    BRAM_PORTA_dout => IR_in,
--	    BRAM_PORTA_en => MR,
--	    BRAM_PORTA_rst => reset,
--	    BRAM_PORTA_we => tempt
--);

ImBack : shifter
port map(
        op1 => B_in,
        opcode => IR_out(6 downto 5),
        result => shift_out,
        shifter_carry => shift_carry,
        shift_amnt => IR_out
);

--Mult: entity work.multiplier
--port map (
--in1 =>ALU_mux1_out,
--in2 =>mux_ex_out,
--out1 => Mult_out
--);

--MUL: multiplier
--	Port map(op1 => ; op2 => ; result => );

end Behavioral;
