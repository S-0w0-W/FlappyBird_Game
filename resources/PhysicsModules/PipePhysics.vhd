library ieee;
use  ieee.std_logic_1164.all;
use  ieee.std_logic_arith.all;
use  ieee.std_logic_unsigned.all;


entity pipePhysics is
	generic(STARTROW : integer range 0 to 400 := 250;
			  STARTCOL : integer range 0 to 1500 := 639; -- gap starting position
			  STARTDIR : std_logic := '0'); 
			  
	port(v_sync, Reset: in std_logic;
		FSM : in std_logic_vector(2 downto 0);
		speed : in integer range 0 to 10;
		rowOut, colOut : out signed(10 downto 0));
end entity pipePhysics;

architecture behaviour of pipePhysics is

	constant UPPERLIM : signed(10 downto 0) := conv_signed(200, 11); -- upper limit for bottom pipe's top
	constant LOWERLIM : signed(10 downto 0) := conv_signed(360, 11); -- lower limit for bottom pipe's top
	
	--placeholder signals for row and column of bottom pipe's top right corner
	signal col : signed(10 downto 0) := conv_signed(STARTCOL, 11);
	signal row : signed(10 downto 0) := conv_signed(STARTROW, 11);
	signal Pause : std_logic := '0';
	signal lfsr : std_logic_vector(5 downto 0) := conv_std_logic_vector(20, 6);
   signal subtractFRow : std_logic_vector(4 downto 0) := lfsr(5 downto 1);
	
begin

	Pause <= '1' when (FSM = "011") else
			 '0';
	subtractFRow <= lfsr(5 downto 1);
	-- process for motion of the pipes
	process(v_sync)
		variable down : std_logic := STARTDIR; -- dictates direction of gap movement
		variable moveActive : std_logic := '1'; -- dictates when gap position changes
		variable enable : std_logic := '0';
		variable scrollspeed : signed(10 downto 0) := conv_signed(5, 11);-- change vector size if necessary);
		variable first : std_logic := '0';
		
	begin
		scrollspeed := conv_signed(speed, 11);
		
		if(rising_edge(v_sync)) then
		
			--if statement to check FSM State
			if((FSM = "001") or (FSM = "010")) then
				enable := '1';
			else
				enable := '0';
			end if;
			
			--generate random numbers using LSFR
			if((Pause = '0') and (enable = '1')) then
                lfsr(5) <= lfsr(1) xor lfsr(2);
                lfsr(4) <= lfsr(5);
                lfsr(3) <= lfsr(4);
                lfsr(2) <= lfsr(3) xor lfsr(4);
                lfsr(1) <= lfsr(2);
            else
                null;
            end if;
			
			-- logic for moving gap between pillars
			-- when below upper limit
			if((row > UPPERLIM) and (down = '0') and (moveActive = '0') and (Pause = '0') and (enable = '1')) then
				 row <= row - conv_signed(conv_integer(subtractFRow), 11);
				 moveActive := '1';
			-- when above lower limit
			elsif((row < LOWERLIM) and (down = '1') and (moveActive = '0') and (Pause = '0') and (enable = '1')) then
				 row <= row + conv_signed(conv_integer(subtractFRow), 11);
				 moveActive := '1';
			-- when pipe is moving
			elsif(moveActive = '1') then
				 row <= row;
			-- when below lower limit
			elsif((row >= LOWERLIM) and (moveActive = '0') and (Pause = '0') and (enable = '1')) then
				 down := '0';
				 row <= row - conv_signed(conv_integer(subtractFRow), 11);
				 moveActive := '1';
			-- when above upper limit
			elsif((row <= UPPERLIM) and (moveActive = '0') and (Pause = '0') and (enable = '1')) then
				 down := '1';
				 row <= row + conv_signed(conv_integer(subtractFRow), 11);
				 moveActive := '1';
			else
				 null;    
			end if;
		
		
			-- logic for moving pipe across the screen
			-- when pipe has not reached left end of screen
			if((moveActive = '1') and (col > 0) and (Reset = '0') and (Pause = '0') and (enable = '1')) then
				col <= col - scrollspeed;
			-- when pipe has reached left end of screen
			elsif((moveActive = '1') and (col < 1) and (Reset = '0') and (Pause = '0') and (enable = '1')) then
				moveActive := '0';
            col <= conv_signed(639, 11);
			elsif (Reset = '1') then
				col <= conv_signed(STARTCOL, 11);
				row <= conv_signed(STARTROW, 11);
				first := '0';
			else
				null;
			end if;
		else
			null;
		end if;	
	end process;
	
	-- set outputs [put these before the "end process;" if need be]
	rowOut <= row;
	colOut <= col;
	
end architecture behaviour;