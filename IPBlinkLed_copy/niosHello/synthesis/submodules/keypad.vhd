library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;
use work.all;

entity keypad is
    generic (
        LEN_ROW  : natural := 4;
		  LEN_COL  : natural := 3
    );
    port (
        -- Gloabals
        clk              : in  std_logic                     := '0';             
        reset            : in  std_logic                     := '0';             

        -- I/Os
        Row              : out std_logic_vector(LEN_ROW - 1 downto 0) := (others => '0');
        Col              : in  std_logic_vector(LEN_COL - 1 downto 0) := (others => '0');
			
		  --LED
		  led       		 : out std_logic_vector(5 downto 0);
			
        -- Avalion Memmory Mapped Slave
        avs_address      : in  std_logic_vector(3 downto 0)  := (others => '0'); 
        avs_read         : in  std_logic                     := '0';             
        avs_readdata     : out std_logic_vector(31 downto 0) := (others => '0'); 
        avs_write        : in  std_logic                     := '0';             
        avs_writedata    : in  std_logic_vector(31 downto 0) := (others => '0')
	);
end entity keypad;

architecture rtl of keypad is

----------------------------------------------------------------------------
-- RWG CONFIG : R/W : Configura periferico
--  31							   7		     				    0
-- [EN                      clear                     RST]
  signal   REG_CONFIG 			: std_logic_vector(31 downto 0); -- address 0
  constant REG_CONFIG_EN   	: natural := 31;
  constant REG_CONFIG_CLR   	: natural := 7;
  constant REG_CONFIG_RST  	: natural := 0;
----------------------------------------------------------------------------

----------------------------------------------------------------------------
-- RWG CONFIG : R : Teclas apertadas
  signal REG_KEYS   : std_logic_vector(31 downto 0); -- address 1
  
 -- bit 0: tecla 0
 -- bit 1: tecla 1
----------------------------------------------------------------------------
  signal state     : std_logic_vector(2 downto 0) := "111";

begin

--------------------------
-- Interface com o NIOS --
--------------------------
  process(clk)
  begin
    if (reset = '1') then

	  REG_CONFIG(REG_CONFIG_EN)   <= '1';
	  REG_CONFIG(REG_CONFIG_CLR)  <= '0';
	  REG_CONFIG(REG_CONFIG_RST)  <= '0';

    elsif(rising_edge(clk)) then

       	if(avs_write = '1') then
			if( avs_address = "0000") then
				REG_CONFIG <= avs_writedata;
			end if;
		end if;

  		if(avs_read = '1') then
			case avs_address is
			when "0000" =>
				avs_readdata <= REG_CONFIG;
			when "0001" =>
				avs_readdata <= REG_KEYS;	
			when others =>
				avs_readdata <= (others => '1');
			end case;			
		end if;
    end if;

  end process;

--------------------------
-- Interface com o HW   --
--------------------------
  process(clk)
  variable delay : integer range 0 to 50000000;
  begin
   
	if (reset = '1') then
	
		REG_KEYS 	<= (others => '0');
--		REG_CONFIG  <= (others => '0');
		

	elsif(rising_edge(clk)) then

--		Row <= "100";
		if (REG_CONFIG(REG_CONFIG_EN) = '1') then
			if(REG_CONFIG(REG_CONFIG_CLR) = '1') then
				REG_KEYS <= (others => '0');
			else

				--FSM KEYPAD 12 STATES--
				 case state is

					when "000" => 
					
					 row <= "0111";

					 if col = "011" then

							  REG_KEYS(1) <= '1'; -- 1
							  led <= "000001";

					 elsif col = "101" then

							  REG_KEYS(2) <= '1'; -- 2
							  led <= "000010";

					 elsif col = "110" then

							  REG_KEYS(3) <= '1'; -- 3
							  led <= "000011";

					 end if;
					 
					if(delay > 2500000) then
						delay := 0;
						state <= "001";
					else
						delay := delay + 1;
					end if;
				  
					when "001" =>
					
					 row <= "1011";

					 if col = "011" then

							  REG_KEYS(4) <= '1'; -- 4
							  led <= "000100";
			 
					 elsif col = "101" then

							  REG_KEYS(5) <= '1'; -- 5
							  led <= "000101";
							  
					 elsif col = "110" then

							  REG_KEYS(6) <= '1'; -- 6
							  led <= "000110";

					 end if;
					 
					if(delay > 2500000) then
						delay := 0;
						state <= "010";
					else
						delay := delay + 1;
					end if;


					when "010" =>
					
					row <= "1101";

					if col = "011" then

							  REG_KEYS(7) <= '1'; -- 7
							  led <= "000111";

					 elsif col = "101" then

							  REG_KEYS(8) <= '1'; -- 8
							  led <= "001000";

					 elsif col = "110" then

							  REG_KEYS(9) <= '1'; -- 9
							  led <= "001001";

					 end if;
					 
					if(delay > 2500000) then
						delay := 0;
						state <= "011";
					else
						delay := delay + 1;
					end if;
					 
					when "011" =>
					
					row <= "1110";

					if col = "011" then

							  REG_KEYS(10) <= '1'; -- *
							  led <= "010101";

					 elsif col = "101" then

							  REG_KEYS(11) <= '1'; -- 0
							  led <= "111111";

					 elsif col = "110" then

							  REG_KEYS(12) <= '1'; -- #
							  led <= "101010";

					 end if;
					 
					if(delay > 2500000) then
						delay := 0;
						state <= "111";
					else
						delay := delay + 1;
					end if;

					when others => REG_KEYS <= (others => '0');
										led <= "000000";
										state <= "000";

					end case;
		
		--END KEYPAD FSM --

       end if;
		else
			REG_KEYS <= (others => '0');
		end if;
	end if;

      

	
  end process;
end rtl;
