library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_keyboard_UART is
end tb_keyboard_UART;

architecture Behavioral of tb_keyboard_UART is

    signal CLK       : std_logic := '0';
    signal RST       : std_logic := '1';
    signal keyboard_data : std_logic_vector(7 downto 0) := (others => '0');
    signal UART_TXD  : std_logic;

    constant clk_period : time := 20 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: entity work.keyboard_UART
        port map (
            clk => CLK,
            reset => RST,
            keyboard_data => keyboard_data,
            uart_tx => UART_TXD
        );

    -- Clock generation
    clk_process : process
    begin
        CLK <= '0';
        wait for clk_period/2;
        CLK <= '1';
        wait for clk_period/2;
    end process;

    -- Stimulus process to provide test inputs and observe outputs
    stim_proc: process
    begin
        -- Reset the system
        RST <= '1';
        wait for 40 ns;
        RST <= '0';

        -- Apply test inputs
        -- Input: "Yildirim Beyazit"
        keyboard_data <= x"59"; wait for clk_period;  -- Y
        keyboard_data <= x"69"; wait for clk_period;  -- i
        keyboard_data <= x"6C"; wait for clk_period;  -- l
        keyboard_data <= x"64"; wait for clk_period;  -- d
        keyboard_data <= x"69"; wait for clk_period;  -- i
        keyboard_data <= x"72"; wait for clk_period;  -- r
        keyboard_data <= x"69"; wait for clk_period;  -- i
        keyboard_data <= x"6D"; wait for clk_period;  -- m
        keyboard_data <= x"20"; wait for clk_period;  -- (space)
        keyboard_data <= x"42"; wait for clk_period;  -- B
        keyboard_data <= x"65"; wait for clk_period;  -- e
        keyboard_data <= x"79"; wait for clk_period;  -- y
        keyboard_data <= x"61"; wait for clk_period;  -- a
        keyboard_data <= x"7A"; wait for clk_period;  -- z
        keyboard_data <= x"69"; wait for clk_period;  -- i
        keyboard_data <= x"74"; wait for clk_period;  -- t
        keyboard_data <= x"0D"; wait for clk_period;  -- Enter key

        -- Wait for processing
        wait for 200 ns;

        -- Input: "Ankara"
        keyboard_data <= x"41"; wait for clk_period;  -- A
        keyboard_data <= x"6E"; wait for clk_period;  -- n
        keyboard_data <= x"6B"; wait for clk_period;  -- k
        keyboard_data <= x"61"; wait for clk_period;  -- a
        keyboard_data <= x"72"; wait for clk_period;  -- r
        keyboard_data <= x"61"; wait for clk_period;  -- a
        keyboard_data <= x"0D"; wait for clk_period;  -- Enter key

        -- Wait for processing
        wait for 200 ns;

        -- Input: "245 + 127"
        keyboard_data <= x"32"; wait for clk_period;  -- 2
        keyboard_data <= x"34"; wait for clk_period;  -- 4
        keyboard_data <= x"35"; wait for clk_period;  -- 5
        keyboard_data <= x"20"; wait for clk_period;  -- (space)
        keyboard_data <= x"2B"; wait for clk_period;  -- +
        keyboard_data <= x"20"; wait for clk_period;  -- (space)
        keyboard_data <= x"31"; wait for clk_period;  -- 1
        keyboard_data <= x"32"; wait for clk_period;  -- 2
        keyboard_data <= x"37"; wait for clk_period;  -- 7
        keyboard_data <= x"0D"; wait for clk_period;  -- Enter key

        -- Wait for processing
        wait for 200 ns;

        -- Input: "200 - 100"
        keyboard_data <= x"32"; wait for clk_period;  -- 2
        keyboard_data <= x"30"; wait for clk_period;  -- 0
        keyboard_data <= x"30"; wait for clk_period;  -- 0
        keyboard_data <= x"20"; wait for clk_period;  -- (space)
        keyboard_data <= x"2D"; wait for clk_period;  -- -
        keyboard_data <= x"20"; wait for clk_period;  -- (space)
        keyboard_data <= x"31"; wait for clk_period;  -- 1
        keyboard_data <= x"30"; wait for clk_period;  -- 0
        keyboard_data <= x"30"; wait for clk_period;  -- 0
        keyboard_data <= x"0D"; wait for clk_period;  -- Enter key

        -- Wait for processing
        wait for 200 ns;

        -- Input: "17*12"
        keyboard_data <= x"31"; wait for clk_period;  -- 1
        keyboard_data <= x"37"; wait for clk_period;  -- 7
        keyboard_data <= x"2A"; wait for clk_period;  -- *
        keyboard_data <= x"31"; wait for clk_period;  -- 1
        keyboard_data <= x"32"; wait for clk_period;  -- 2
        keyboard_data <= x"0D"; wait for clk_period;  -- Enter key

        -- Wait for processing
        wait for 200 ns;

        -- Input: "yoldas"
        keyboard_data <= x"79"; wait for clk_period;  -- y
        keyboard_data <= x"6F"; wait for clk_period;  -- o
        keyboard_data <= x"6C"; wait for clk_period;  -- l
        keyboard_data <= x"64"; wait for clk_period;  -- d
        keyboard_data <= x"61"; wait for clk_period;  -- a
        keyboard_data <= x"73"; wait for clk_period;  -- s
        keyboard_data <= x"0D"; wait for clk_period;  -- Enter key

        -- Wait for processing
        wait for 200 ns;

        -- Stop simulation
        wait;
    end process;

end Behavioral;

