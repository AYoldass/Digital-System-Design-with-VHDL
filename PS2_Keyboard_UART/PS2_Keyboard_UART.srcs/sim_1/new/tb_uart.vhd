library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity uart_tb is
end uart_tb;

architecture behavior of uart_tb is

    signal clk : std_logic := '0';
    signal reset : std_logic := '0';
    signal rd_uart : std_logic := '0';
    signal wr_uart : std_logic := '0';
    signal rx : std_logic := '1';
    signal w_data : std_logic_vector(7 downto 0) := (others => '0');
    signal rx_empty : std_logic;
    signal r_data : std_logic_vector(7 downto 0);
    signal tx : std_logic;
    signal tx_full : std_logic;

    constant clk_period : time := 20 ns;

begin

    uut: entity work.uart
        generic map (
            DBIT => 8,
            SB_TICK => 16,
            DVSR => 163,
            DVSR_BIT => 8,
            FIFO_W => 2
        )
        port map (
            clk => clk,
            reset => reset,
            rd_uart => rd_uart,
            wr_uart => wr_uart,
            rx => rx,
            w_data => w_data,
            rx_empty => rx_empty,
            r_data => r_data,
            tx => tx,
            tx_full => tx_full
        );

    -- Clock generation
    clk_process :process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Initialize signals
        reset <= '1';
        wait for 40 ns;
        reset <= '0';

        -- Write data to FIFO
        wr_uart <= '1';
        w_data <= x"62";  -- ASCII for 'b'
        wait for clk_period;
        wr_uart <= '0';

        -- Read data from FIFO
        wait for 100 ns;
        rd_uart <= '1';
        wait for clk_period;
        rd_uart <= '0';

        -- Check another data
        wait for 100 ns;
        wr_uart <= '1';
        w_data <= x"63";  -- ASCII for 'c'
        wait for clk_period;
        wr_uart <= '0';

        wait for 100 ns;
        rd_uart <= '1';
        wait for clk_period;
        rd_uart <= '0';

        -- Check the data in r_data
        wait for 200 ns;

        -- End simulation
        wait;
    end process;

end behavior;
