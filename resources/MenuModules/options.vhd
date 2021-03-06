LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_SIGNED.all;

ENTITY options IS
	GENERIC (
		INT_ADDRESS 		: integer range 0 to 77 := 2;
		TEXT_POS_X 			: integer range 0 to 20 := 6;
		TEXT_POS_Y 			: integer range 0 to 20 := 8
	);
	
	PORT(
		pixel_column, pixel_row 	: IN STD_logic_VECTOR(9 DOWNTO 0);
		address							: OUT std_logic_vector(5 DOWNTO 0);
		text_row, text_column		: OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
	);
END ENTITY options;

architecture behaviour of options is

	signal outOn_Sig : std_logic;
	
	
	----------- Define arrays to store individual letters for a specific word ---------
	type Gameplay_array is array (0 to 7) of STD_logic_VECTOR(5 downto 0);
	signal GAMEPLAY_word : Gameplay_array := (0 => CONV_STD_LOGIC_VECTOR(7, 6), 
															1 => CONV_STD_LOGIC_VECTOR(1, 6), 
															2 => CONV_STD_LOGIC_VECTOR(13, 6), 
															3 => CONV_STD_LOGIC_VECTOR(5, 6), 
															4 => CONV_STD_LOGIC_VECTOR(16, 6), 
															5 => CONV_STD_LOGIC_VECTOR(12, 6),
															6 => CONV_STD_LOGIC_VECTOR(1, 6),
															7 => CONV_STD_LOGIC_VECTOR(25, 6));
	
	type Training_array is array (0 to 7) of STD_logic_VECTOR(5 downto 0);
	signal TRAINING_word : Training_array := (0 => CONV_STD_LOGIC_VECTOR(20, 6), 
													      1 => CONV_STD_LOGIC_VECTOR(18, 6), 
													      2 => CONV_STD_LOGIC_VECTOR(1, 6), 
													      3 => CONV_STD_LOGIC_VECTOR(9, 6), 
													      4 => CONV_STD_LOGIC_VECTOR(14, 6), 
													      5 => CONV_STD_LOGIC_VECTOR(9, 6),
													      6 => CONV_STD_LOGIC_VECTOR(14, 6),
													      7 => CONV_STD_LOGIC_VECTOR(7, 6));
															
															
	---------------- Define the reigon for where the individual letter will be displayed on the screen --------------
	BEGIN
		outOn_Sig <= '1' when ((pixel_column(9 DOWNTO 5) = CONV_STD_LOGIC_VECTOR(TEXT_POS_X, 10)) and (pixel_row(9 DOWNTO 5) = CONV_STD_LOGIC_VECTOR(TEXT_POS_Y, 10))) else
						 '1' when ((pixel_column(9 DOWNTO 5) = CONV_STD_LOGIC_VECTOR((TEXT_POS_X +1), 10)) and (pixel_row(9 DOWNTO 5) = CONV_STD_LOGIC_VECTOR((TEXT_POS_Y), 10)))   else 
						 '1' when ((pixel_column(9 DOWNTO 5) = CONV_STD_LOGIC_VECTOR((TEXT_POS_X +2), 10)) and (pixel_row(9 DOWNTO 5) = CONV_STD_LOGIC_VECTOR((TEXT_POS_Y), 10)))   else 
						 '1' when ((pixel_column(9 DOWNTO 5) = CONV_STD_LOGIC_VECTOR((TEXT_POS_X +3), 10)) and (pixel_row(9 DOWNTO 5) = CONV_STD_LOGIC_VECTOR((TEXT_POS_Y), 10)))   else 
						 '1' when ((pixel_column(9 DOWNTO 5) = CONV_STD_LOGIC_VECTOR((TEXT_POS_X +4), 10)) and (pixel_row(9 DOWNTO 5) = CONV_STD_LOGIC_VECTOR((TEXT_POS_Y), 10)))   else 
						 '1' when ((pixel_column(9 DOWNTO 5) = CONV_STD_LOGIC_VECTOR((TEXT_POS_X +5), 10)) and (pixel_row(9 DOWNTO 5) = CONV_STD_LOGIC_VECTOR((TEXT_POS_Y), 10)))   else 
						 '1' when ((pixel_column(9 DOWNTO 5) = CONV_STD_LOGIC_VECTOR((TEXT_POS_X +6), 10)) and (pixel_row(9 DOWNTO 5) = CONV_STD_LOGIC_VECTOR((TEXT_POS_Y), 10)))   else 
						 '1' when ((pixel_column(9 DOWNTO 5) = CONV_STD_LOGIC_VECTOR((TEXT_POS_X +7), 10)) and (pixel_row(9 DOWNTO 5) = CONV_STD_LOGIC_VECTOR((TEXT_POS_Y), 10)))   else 
						 
						 '1' when ((pixel_column(9 DOWNTO 5) = CONV_STD_LOGIC_VECTOR(TEXT_POS_X, 10)) and (pixel_row(9 DOWNTO 5) = CONV_STD_LOGIC_VECTOR((TEXT_POS_Y + 3), 10))) else
						 '1' when ((pixel_column(9 DOWNTO 5) = CONV_STD_LOGIC_VECTOR((TEXT_POS_X +1), 10)) and (pixel_row(9 DOWNTO 5) = CONV_STD_LOGIC_VECTOR((TEXT_POS_Y + 3), 10)))   else 
						 '1' when ((pixel_column(9 DOWNTO 5) = CONV_STD_LOGIC_VECTOR((TEXT_POS_X +2), 10)) and (pixel_row(9 DOWNTO 5) = CONV_STD_LOGIC_VECTOR((TEXT_POS_Y + 3), 10)))   else 
						 '1' when ((pixel_column(9 DOWNTO 5) = CONV_STD_LOGIC_VECTOR((TEXT_POS_X +3), 10)) and (pixel_row(9 DOWNTO 5) = CONV_STD_LOGIC_VECTOR((TEXT_POS_Y + 3), 10)))   else 
						 '1' when ((pixel_column(9 DOWNTO 5) = CONV_STD_LOGIC_VECTOR((TEXT_POS_X +4), 10)) and (pixel_row(9 DOWNTO 5) = CONV_STD_LOGIC_VECTOR((TEXT_POS_Y + 3), 10)))   else 
						 '1' when ((pixel_column(9 DOWNTO 5) = CONV_STD_LOGIC_VECTOR((TEXT_POS_X +5), 10)) and (pixel_row(9 DOWNTO 5) = CONV_STD_LOGIC_VECTOR((TEXT_POS_Y + 3), 10)))   else 
						 '1' when ((pixel_column(9 DOWNTO 5) = CONV_STD_LOGIC_VECTOR((TEXT_POS_X +6), 10)) and (pixel_row(9 DOWNTO 5) = CONV_STD_LOGIC_VECTOR((TEXT_POS_Y + 3), 10)))   else 
						 '1' when ((pixel_column(9 DOWNTO 5) = CONV_STD_LOGIC_VECTOR((TEXT_POS_X +7), 10)) and (pixel_row(9 DOWNTO 5) = CONV_STD_LOGIC_VECTOR((TEXT_POS_Y + 3), 10)))   else 
						 
					    '0';
		
		----------------------- Define the font size of the text that will be displayed ----------------			
		text_column	<= pixel_column(4 DOWNTO 2) when outOn_Sig = '1' else
							"000";
							
		text_row		<= pixel_row(4 DOWNTO 2) when outOn_Sig = '1' else
							"000";
							
							
		-------------------- Assign the stored address in the arrays to the corresponding word ---------------------
		ADDRESS <= GAMEPLAY_word(0) when ((pixel_column(9 DOWNTO 5) = CONV_STD_LOGIC_VECTOR(TEXT_POS_X, 10)) and (pixel_row(9 DOWNTO 5) = CONV_STD_LOGIC_VECTOR(TEXT_POS_Y, 10))) else
					  GAMEPLAY_word(1) when ((pixel_column(9 DOWNTO 5) = CONV_STD_LOGIC_VECTOR((TEXT_POS_X +1), 10)) and (pixel_row(9 DOWNTO 5) = CONV_STD_LOGIC_VECTOR((TEXT_POS_Y), 10))) else
					  GAMEPLAY_word(2) when ((pixel_column(9 DOWNTO 5) = CONV_STD_LOGIC_VECTOR((TEXT_POS_X +2), 10)) and (pixel_row(9 DOWNTO 5) = CONV_STD_LOGIC_VECTOR((TEXT_POS_Y), 10))) else
					  GAMEPLAY_word(3) when ((pixel_column(9 DOWNTO 5) = CONV_STD_LOGIC_VECTOR((TEXT_POS_X +3), 10)) and (pixel_row(9 DOWNTO 5) = CONV_STD_LOGIC_VECTOR((TEXT_POS_Y), 10))) else
				     GAMEPLAY_word(4) when ((pixel_column(9 DOWNTO 5) = CONV_STD_LOGIC_VECTOR((TEXT_POS_X +4), 10)) and (pixel_row(9 DOWNTO 5) = CONV_STD_LOGIC_VECTOR((TEXT_POS_Y), 10))) else
					  GAMEPLAY_word(5) when ((pixel_column(9 DOWNTO 5) = CONV_STD_LOGIC_VECTOR((TEXT_POS_X +5), 10)) and (pixel_row(9 DOWNTO 5) = CONV_STD_LOGIC_VECTOR((TEXT_POS_Y), 10))) else
					  GAMEPLAY_word(6) when ((pixel_column(9 DOWNTO 5) = CONV_STD_LOGIC_VECTOR((TEXT_POS_X +6), 10)) and (pixel_row(9 DOWNTO 5) = CONV_STD_LOGIC_VECTOR((TEXT_POS_Y), 10))) else
					  GAMEPLAY_word(7) when ((pixel_column(9 DOWNTO 5) = CONV_STD_LOGIC_VECTOR((TEXT_POS_X +7), 10)) and (pixel_row(9 DOWNTO 5) = CONV_STD_LOGIC_VECTOR((TEXT_POS_Y), 10))) else
					 
					  TRAINING_word(0) when ((pixel_column(9 DOWNTO 5) = CONV_STD_LOGIC_VECTOR(TEXT_POS_X, 10)) and (pixel_row(9 DOWNTO 5) = CONV_STD_LOGIC_VECTOR((TEXT_POS_Y + 3), 10))) else
					  TRAINING_word(1) when ((pixel_column(9 DOWNTO 5) = CONV_STD_LOGIC_VECTOR((TEXT_POS_X +1), 10)) and (pixel_row(9 DOWNTO 5) = CONV_STD_LOGIC_VECTOR((TEXT_POS_Y + 3), 10))) else
					  TRAINING_word(2) when ((pixel_column(9 DOWNTO 5) = CONV_STD_LOGIC_VECTOR((TEXT_POS_X +2), 10)) and (pixel_row(9 DOWNTO 5) = CONV_STD_LOGIC_VECTOR((TEXT_POS_Y + 3), 10))) else
					  TRAINING_word(3) when ((pixel_column(9 DOWNTO 5) = CONV_STD_LOGIC_VECTOR((TEXT_POS_X +3), 10)) and (pixel_row(9 DOWNTO 5) = CONV_STD_LOGIC_VECTOR((TEXT_POS_Y + 3), 10))) else
				     TRAINING_word(4) when ((pixel_column(9 DOWNTO 5) = CONV_STD_LOGIC_VECTOR((TEXT_POS_X +4), 10)) and (pixel_row(9 DOWNTO 5) = CONV_STD_LOGIC_VECTOR((TEXT_POS_Y + 3), 10))) else
					  TRAINING_word(5) when ((pixel_column(9 DOWNTO 5) = CONV_STD_LOGIC_VECTOR((TEXT_POS_X +5), 10)) and (pixel_row(9 DOWNTO 5) = CONV_STD_LOGIC_VECTOR((TEXT_POS_Y + 3), 10))) else
					  TRAINING_word(6) when ((pixel_column(9 DOWNTO 5) = CONV_STD_LOGIC_VECTOR((TEXT_POS_X +6), 10)) and (pixel_row(9 DOWNTO 5) = CONV_STD_LOGIC_VECTOR((TEXT_POS_Y + 3), 10))) else
					  TRAINING_word(7) when ((pixel_column(9 DOWNTO 5) = CONV_STD_LOGIC_VECTOR((TEXT_POS_X +7), 10)) and (pixel_row(9 DOWNTO 5) = CONV_STD_LOGIC_VECTOR((TEXT_POS_Y + 3), 10))) else
					  
					  "000000";
					 
end architecture behaviour;
