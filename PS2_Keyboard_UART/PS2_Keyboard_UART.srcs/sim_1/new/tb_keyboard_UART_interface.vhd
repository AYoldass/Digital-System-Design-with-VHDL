library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity keyboard_uart_tb is
end keyboard_uart_tb;

architecture Behavioral of keyboard_uart_tb is

    signal clk : std_logic := '0';
    signal reset : std_logic := '1';
    signal ps2d : std_logic := '0';
    signal ps2c : std_logic := '0';
    signal w_data : std_logic_vector(7 downto 0) := (others => '0');
    signal uart_tx : std_logic;

    constant clk_period : time := 20 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: entity work.keyboard_UART_interface
        port map (
            clk => clk,
            reset => reset,
            ps2d => ps2d,
            ps2c => ps2c,
            w_data => w_data,
            uart_tx => uart_tx
        );

    -- Clock generation
    clk_process : process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;

    -- Stimulus process to provide test inputs and observe outputs
    stim_proc: process
    begin
        -- Reset the system
        reset <= '1';
        wait for 40 ns;
        reset <= '0';

        -- Apply test inputs
        -- Input: "Yildirim Beyazit"
        w_data <= x"59"; wait for clk_period;  -- Y
        w_data <= x"69"; wait for clk_period;  -- i
        w_data <= x"6C"; wait for clk_period;  -- l
        w_data <= x"64"; wait for clk_period;  -- d
        w_data <= x"69"; wait for clk_period;  -- i
        w_data <= x"72"; wait for clk_period;  -- r
        w_data <= x"69"; wait for clk_period;  -- i
        w_data <= x"6D"; wait for clk_period;  -- m
        w_data <= x"20"; wait for clk_period;  -- (space)
        w_data <= x"42"; wait for clk_period;  -- B
        w_data <= x"65"; wait for clk_period;  -- e
        w_data <= x"79"; wait for clk_period;  -- y
        w_data <= x"61"; wait for clk_period;  -- a
        w_data <= x"7A"; wait for clk_period;  -- z
        w_data <= x"69"; wait for clk_period;  -- i
        w_data <= x"74"; wait for clk_period;  -- t
        w_data <= x"0D"; wait for clk_period;  -- Enter key

        -- Wait for processing
        wait for 200 ns;

        -- Input: "Ankara"
        w_data <= x"41"; wait for clk_period;  -- A
        w_data <= x"6E"; wait for clk_period;  -- n
        w_data <= x"6B"; wait for clk_period;  -- k
        w_data <= x"61"; wait for clk_period;  -- a
        w_data <= x"72"; wait for clk_period;  -- r
        w_data <= x"61"; wait for clk_period;  -- a
        w_data <= x"0D"; wait for clk_period;  -- Enter key

        -- Wait for processing
        wait for 200 ns;

        -- Input: "245 + 127"
        w_data <= x"32"; wait for clk_period;  -- 2
        w_data <= x"34"; wait for clk_period;  -- 4
        w_data <= x"35"; wait for clk_period;  -- 5
        w_data <= x"20"; wait for clk_period;  -- (space)
        w_data <= x"2B"; wait for clk_period;  -- +
        w_data <= x"20"; wait for clk_period;  -- (space)
        w_data <= x"31"; wait for clk_period;  -- 1
        w_data <= x"32"; wait for clk_period;  -- 2
        w_data <= x"37"; wait for clk_period;  -- 7
        w_data <= x"0D"; wait for clk_period;  -- Enter key

        -- Wait for processing
        wait for 200 ns;

        -- Input: "200 - 100"
        w_data <= x"32"; wait for clk_period;  -- 2
        w_data <= x"30"; wait for clk_period;  -- 0
        w_data <= x"30"; wait for clk_period;  -- 0
        w_data <= x"20"; wait for clk_period;  -- (space)
        w_data <= x"2D"; wait for clk_period;  -- -
        w_data <= x"20"; wait for clk_period;  -- (space)
        w_data <= x"31"; wait for clk_period;  -- 1
        w_data <= x"30"; wait for clk_period;  -- 0
        w_data <= x"30"; wait for clk_period;  -- 0
        w_data <= x"0D"; wait for clk_period;  -- Enter key

        -- Wait for processing
        wait for 200 ns;

        -- Input: "17*12"
        w_data <= x"31"; wait for clk_period;  -- 1
        w_data <= x"37"; wait for clk_period;  -- 7
        w_data <= x"2A"; wait for clk_period;  -- *
        w_data <= x"31"; wait for clk_period;  -- 1
        w_data <= x"32"; wait for clk_period;  -- 2
        w_data <= x"0D"; wait for clk_period;  -- Enter key

        -- Wait for processing
        wait for 200 ns;

        -- Input: "yoldas"
        w_data <= x"79"; wait for clk_period;  -- y
        w_data <= x"6F"; wait for clk_period;  -- o
        w_data <= x"6C"; wait for clk_period;  -- l
        w_data <= x"64"; wait for clk_period;  -- d
        w_data <= x"61"; wait for clk_period;  -- a
        w_data <= x"73"; wait for clk_period;  -- s
        w_data <= x"0D"; wait for clk_period;  -- Enter key

        -- Wait for processing
        wait for 200 ns;

        -- Stop simulation
        wait;
    end process;

end Behavioral;
