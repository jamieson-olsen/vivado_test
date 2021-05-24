-- top_level.vhd
-- Jamieson Olsen <jamieson@fnal.gov>
-- bonus question: what does this logic actually do?

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library unisim;
use unisim.vcomponents.all;

entity top_level is
generic(version: std_logic_vector(27 downto 0) := X"1234567"); -- git commit number is passed in from tcl
port(
    reset: in  std_logic; -- active high reset
    sysclk_p, sysclk_n: in  std_logic; -- system clock 200MHz LVDS
	din:   in  std_logic_vector(7 downto 0); -- some input 
    led:   out std_logic_vector(7 downto 0)  -- some output
  );
end top_level;

architecture top_level_arch of top_level is

	-- declare components... none here

	-- declare signals to connect everything up

	signal sysclk_ibuf, sysclk: std_logic;
	signal led0_reg, led1_reg: std_logic_vector(7 downto 0);
	signal count_reg: std_logic_vector(23 downto 0);
	signal edge_reg: std_logic;

begin

	-- 200MHz sysclk is LVDS, receive it with IBUFDS and drive it out on a BUFG net. sysclk comes in on bank 33
	-- which has VCCO=1.5V. IOSTANDARD is LVDS and the termination resistor is external (DIFF_TERM=FALSE)

	sysclk_ibufds_inst : IBUFDS
	port map(O => sysclk_ibuf, I => sysclk_p, IB => sysclk_n);

	sysclk_bufg_inst : BUFG
	port map(O => sysclk, I => sysclk_ibuf);

	-- sequential logic lives inside process statements...

    test_proc: process(sysclk) -- is this sync or async reset? how do you know?
    begin
        if rising_edge(sysclk) then
            if (reset='1') then
                count_reg <= (others=>'0');
                edge_reg  <= '0';
                led0_reg <= X"00";
				led1_reg <= X"00";
            else
                count_reg <= std_logic_vector(unsigned(count_reg) + 1);
                edge_reg  <= count_reg(23);

                if (edge_reg='0' and count_reg(23)='1') then -- MSb of the counter was JUST set
                    led1_reg <= led0_reg;
                    led0_reg <= X"00";
                else
                    led0_reg <= led0_reg or din;
                end if;
            end if;
        end if;
    end process test_proc;

	-- combinatorial assignments...
   
    led <= led1_reg;

	-- instantiate components... none here


end top_level_arch;
