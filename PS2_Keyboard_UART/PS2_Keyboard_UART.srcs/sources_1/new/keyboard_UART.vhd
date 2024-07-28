library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity keyboard_UART is

    Port (
        clk : in STD_LOGIC;
        reset : in STD_LOGIC;
        keyboard_data : in STD_LOGIC_VECTOR (7 downto 0);
        uart_tx : out STD_LOGIC
    );
end keyboard_UART;

architecture Behavioral of keyboard_UART is

    type state_type is (IDLE, READ_INPUT, PROCESS_INPUT, OUTPUT_RESULT);
    signal state : state_type := IDLE;
    signal input_buffer : STD_LOGIC_VECTOR (255 downto 0) := (others => '0');
    signal input_index : integer range 0 to 31 := 0;  -- Sınır belirleme
    signal result : STD_LOGIC_VECTOR (255 downto 0) := (others => '0');
    signal uart_data : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
    signal uart_send : STD_LOGIC := '0';
    signal enter_key : STD_LOGIC := '0';
    signal error_flag : STD_LOGIC := '0';
    signal operation : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
    signal operand1, operand2 : integer := 0;
    signal result_value : integer := 0;
    
begin

    process(clk, reset)
    begin
        if reset = '1' then
            state <= IDLE;
            input_buffer <= (others => '0');
            input_index <= 0;
            result <= (others => '0');
            uart_send <= '0';
            enter_key <= '0';
            error_flag <= '0';
            operand1 <= 0;
            operand2 <= 0;
            result_value <= 0;
        elsif rising_edge(clk) then
            case state is
                when IDLE =>
                    if keyboard_data /= x"00" then
                        state <= READ_INPUT;
                        input_buffer(input_index*8 + 7 downto input_index*8) <= keyboard_data;
                        if keyboard_data = x"0D" then  -- Enter key
                            enter_key <= '1';
                        else
                            input_index <= input_index + 1;
                        end if;
                    end if;
                when READ_INPUT =>
                    if enter_key = '1' then
                        state <= PROCESS_INPUT;
                        input_buffer(input_index*8 + 7 downto input_index*8) <= x"00";
                    else
                        state <= IDLE;
                    end if;
                when PROCESS_INPUT =>
                    if input_buffer(7 downto 0) >= x"30" and input_buffer(7 downto 0) <= x"39" then
                        -- Handle as mathematical operation
                        for i in 0 to 30 loop  -- Loop limit is adjusted to avoid out of bounds
                            if i < input_index then
                                if input_buffer(i*8 + 7 downto i*8) = x"2B" or input_buffer(i*8 + 7 downto i*8) = x"2D" or 
                                   input_buffer(i*8 + 7 downto i*8) = x"2A" or input_buffer(i*8 + 7 downto i*8) = x"2F" then
                                    operation <= input_buffer(i*8 + 7 downto i*8);
                                    if i > 0 then
                                        operand1 <= to_integer(unsigned(input_buffer((i-1)*8 + 7 downto (i-1)*8)));
                                    end if;
                                    if i < input_index - 1 then
                                        operand2 <= to_integer(unsigned(input_buffer((i+1)*8 + 7 downto (i+1)*8)));
                                    end if;
                                end if;
                            end if;
                        end loop;
                        
                        case operation is
                            when x"2B" => result_value <= operand1 + operand2;  -- Addition
                            when x"2D" => result_value <= operand1 - operand2;  -- Subtraction
                            when x"2A" => result_value <= operand1 * operand2;  -- Multiplication
                            when x"2F" => result_value <= operand1 / operand2;  -- Division
                            when others => error_flag <= '1';
                        end case;
                        
                        if error_flag = '1' then
                            result(7 downto 0) <= x"45"; -- ASCII code for 'E'
                        else
                            result(255 downto 8) <= (others => '0'); -- Clear upper bits
                            result(7 downto 0) <= std_logic_vector(to_unsigned(result_value, 8));
                        end if;
                        
                    else
                        -- Handle as string input
                        for i in 0 to 31 loop  -- Ensure we do not exceed the buffer size
                            if i < input_index then
                                if input_buffer(i*8 + 7 downto i*8) >= x"61" and input_buffer(i*8 + 7 downto i*8) <= x"7A" then
                                    input_buffer(i*8 + 7 downto i*8) <= std_logic_vector(unsigned(input_buffer(i*8 + 7 downto i*8)) - 32); -- Convert to uppercase
                                end if;
                            end if;
                        end loop;
                        result <= input_buffer;
                    end if;
                    state <= OUTPUT_RESULT;
                when OUTPUT_RESULT =>
                    if uart_send = '0' then
                        uart_data <= result(7 downto 0);
                        result(255 downto 8) <= (others => '0'); -- Clear upper bits
                        uart_send <= '1';
                    else
                        uart_send <= '0';
                        state <= IDLE;
                        input_index <= 0;
                        enter_key <= '0';
                    end if;
            end case;
        end if;
    end process;

    -- UART transmitter process
    process(clk, reset)
    begin
        if reset = '1' then
            uart_tx <= '1';
        elsif rising_edge(clk) then
            if uart_send = '1' then
                uart_tx <= uart_data(0);
                uart_data <= uart_data(7 downto 1) & '0';
            else
                uart_tx <= '1';
            end if;
        end if;
    end process;

end Behavioral;