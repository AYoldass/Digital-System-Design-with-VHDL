library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mod_m_counter is
    generic (
        M : integer := 163;  -- Modulus value
        N : integer := 8  -- Number of bits for the counter
    );
    port (
        clk : in std_logic;
        reset : in std_logic;
        q : out std_logic_vector(N-1 downto 0);
        max_tick : out std_logic
    );
end mod_m_counter;

architecture arch of mod_m_counter is
    signal r_reg : unsigned(N-1 downto 0);
    signal r_next : unsigned(N-1 downto 0);
begin
    process(clk, reset)
    begin
        if reset = '1' then
            r_reg <= (others => '0');
        elsif rising_edge(clk) then
            r_reg <= r_next;
        end if;
    end process;

    r_next <= r_reg + 1 when r_reg /= M-1 else (others => '0');
    q <= std_logic_vector(r_reg);
    max_tick <= '1' when r_reg = M-1 else '0';
end arch;
