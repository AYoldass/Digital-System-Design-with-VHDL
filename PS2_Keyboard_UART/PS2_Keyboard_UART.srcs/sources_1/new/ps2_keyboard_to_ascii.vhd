library ieee;
use ieee.std_logic_1164.all;

entity ps2_keyboard_to_ascii is
  generic(
      clk_freq                  : integer := 50_000_000;
      ps2_debounce_counter_size : integer := 8);
  port(
      clk        : in  std_logic;
      reset      : in  std_logic;
      ps2c       : in  std_logic;
      ps2d       : in  std_logic;
      ascii_new  : out std_logic;
      ascii_code : out std_logic_vector(7 downto 0));
end ps2_keyboard_to_ascii;

architecture arch of ps2_keyboard_to_ascii is
  type machine is (ready, new_code, translate, output);
  signal state             : machine;
  signal rx_done_tick      : std_logic;
  signal dout              : std_logic_vector(7 downto 0);
  signal prev_ps2_code_new : std_logic := '1';
  signal break             : std_logic := '0';
  signal e0_code           : std_logic := '0';
  signal caps_lock         : std_logic := '0';
  signal control_r         : std_logic := '0';
  signal control_l         : std_logic := '0';
  signal shift_r           : std_logic := '0';
  signal shift_l           : std_logic := '0';
  signal ascii             : std_logic_vector(7 downto 0) := x"ff";

  component ps2_rx is
    generic(
      clk_freq              : integer;
      debounce_counter_size : integer);
    port(
      clk          : in  std_logic;
      reset        : in  std_logic;
      ps2c         : in  std_logic;
      ps2d         : in  std_logic;
      rx_done_tick : out std_logic;
      dout         : out std_logic_vector(7 downto 0));
  end component;

begin

  ps2_keyboard_0: ps2_rx
    generic map(clk_freq => clk_freq, debounce_counter_size => ps2_debounce_counter_size)
    port map(clk => clk, reset => reset, ps2c => ps2c, ps2d => ps2d, rx_done_tick => rx_done_tick, dout => ascii_code);

  process(clk)
  begin
    if(clk'event and clk = '1') then
      prev_ps2_code_new <= rx_done_tick;
      case state is
        when ready =>
          if(prev_ps2_code_new = '0' and rx_done_tick = '1') then
            ascii_new <= '0';
            state <= new_code;
          else
            state <= ready;
          end if;
        when new_code =>
          if(dout = x"f0") then
            break <= '1';
            state <= ready;
          elsif(dout = x"e0") then
            e0_code <= '1';
            state <= ready;
          else
            ascii(7) <= '1';
            state <= translate;
          end if;
        when translate =>
            break <= '0';
            e0_code <= '0';
            case dout is
              when x"58" =>
                if(break = '0') then
                  caps_lock <= not caps_lock;
                end if;
              when x"14" =>
                if(e0_code = '1') then
                  control_r <= not break;
                else
                  control_l <= not break;
                end if;
              when x"12" =>
                shift_l <= not break;
              when x"59" =>
                shift_r <= not break;
              when others => null;
            end case;
            if(control_l = '1' or control_r = '1') then
              case dout is
                when x"1e" => ascii <= x"00";
                when x"1c" => ascii <= x"01";
                when x"32" => ascii <= x"02";
                when x"21" => ascii <= x"03";
                when x"23" => ascii <= x"04";
                when x"24" => ascii <= x"05";
                when x"2b" => ascii <= x"06";
                when x"34" => ascii <= x"07";
                when x"33" => ascii <= x"08";
                when x"43" => ascii <= x"09";
                when x"3b" => ascii <= x"0a";
                when x"42" => ascii <= x"0b";
                when x"4b" => ascii <= x"0c";
                when x"3a" => ascii <= x"0d";
                when x"31" => ascii <= x"0e";
                when x"44" => ascii <= x"0f";
                when x"4d" => ascii <= x"10";
                when x"15" => ascii <= x"11";
                when x"2d" => ascii <= x"12";
                when x"1b" => ascii <= x"13";
                when x"2c" => ascii <= x"14";
                when x"3c" => ascii <= x"15";
                when x"2a" => ascii <= x"16";
                when x"1d" => ascii <= x"17";
                when x"22" => ascii <= x"18";
                when x"35" => ascii <= x"19";
                when x"1a" => ascii <= x"1a";
                when x"54" => ascii <= x"1b";
                when x"5d" => ascii <= x"1c";
                when x"5b" => ascii <= x"1d";
                when x"36" => ascii <= x"1e";
                when x"4e" => ascii <= x"1f";
                when x"4a" => ascii <= x"7f";
                when others => null;
              end case;
            else
              case dout is
                when x"29" => ascii <= x"20";
                when x"66" => ascii <= x"08";
                when x"0d" => ascii <= x"09";
                when x"5a" => ascii <= x"0d";
                when x"76" => ascii <= x"1b";
                when x"71" => 
                  if(e0_code = '1') then
                    ascii <= x"7f";
                  end if;
                when others => null;
              end case;
              if((shift_r = '0' and shift_l = '0' and caps_lock = '0') or ((shift_r = '1' or shift_l = '1') and caps_lock = '1')) then
                case dout is              
                  when x"1c" => ascii <= x"61";
                  when x"32" => ascii <= x"62";
                  when x"21" => ascii <= x"63";
                  when x"23" => ascii <= x"64";
                  when x"24" => ascii <= x"65";
                  when x"2b" => ascii <= x"66";
                  when x"34" => ascii <= x"67";
                  when x"33" => ascii <= x"68";
                  when x"43" => ascii <= x"69";
                  when x"3b" => ascii <= x"6a";
                  when x"42" => ascii <= x"6b";
                  when x"4b" => ascii <= x"6c";
                  when x"3a" => ascii <= x"6d";
                  when x"31" => ascii <= x"6e";
                  when x"44" => ascii <= x"6f";
                  when x"4d" => ascii <= x"70";
                  when x"15" => ascii <= x"71";
                  when x"2d" => ascii <= x"72";
                  when x"1b" => ascii <= x"73";
                  when x"2c" => ascii <= x"74";
                  when x"3c" => ascii <= x"75";
                  when x"2a" => ascii <= x"76";
                  when x"1d" => ascii <= x"77";
                  when x"22" => ascii <= x"78";
                  when x"35" => ascii <= x"79";
                  when x"1a" => ascii <= x"7a";
                  when others => null;
                end case;
              else
                case dout is            
                  when x"1c" => ascii <= x"41";
                  when x"32" => ascii <= x"42";
                  when x"21" => ascii <= x"43";
                  when x"23" => ascii <= x"44";
                  when x"24" => ascii <= x"45";
                  when x"2b" => ascii <= x"46";
                  when x"34" => ascii <= x"47";
                  when x"33" => ascii <= x"48";
                  when x"43" => ascii <= x"49";
                  when x"3b" => ascii <= x"4a";
                  when x"42" => ascii <= x"4b";
                  when x"4b" => ascii <= x"4c";
                  when x"3a" => ascii <= x"4d";
                  when x"31" => ascii <= x"4e";
                  when x"44" => ascii <= x"4f";
                  when x"4d" => ascii <= x"50";
                  when x"15" => ascii <= x"51";
                  when x"2d" => ascii <= x"52";
                  when x"1b" => ascii <= x"53";
                  when x"2c" => ascii <= x"54";
                  when x"3c" => ascii <= x"55";
                  when x"2a" => ascii <= x"56";
                  when x"1d" => ascii <= x"57";
                  when x"22" => ascii <= x"58";
                  when x"35" => ascii <= x"59";
                  when x"1a" => ascii <= x"5a";
                  when others => null;
                end case;
              end if;
              if(shift_l = '1' or shift_r = '1') then
                case dout is              
                  when x"16" => ascii <= x"21";
                  when x"52" => ascii <= x"22";
                  when x"26" => ascii <= x"23";
                  when x"25" => ascii <= x"24";
                  when x"2e" => ascii <= x"25";
                  when x"3d" => ascii <= x"26";
                  when x"46" => ascii <= x"28";
                  when x"45" => ascii <= x"29";
                  when x"3e" => ascii <= x"2a";
                  when x"55" => ascii <= x"2b";
                  when x"4c" => ascii <= x"3a";
                  when x"41" => ascii <= x"3c";
                  when x"49" => ascii <= x"3e";
                  when x"4a" => ascii <= x"3f";
                  when x"1e" => ascii <= x"40";
                  when x"36" => ascii <= x"5e";
                  when x"4e" => ascii <= x"5f";
                  when x"54" => ascii <= x"7b";
                  when x"5d" => ascii <= x"7c";
                  when x"5b" => ascii <= x"7d";
                  when x"0e" => ascii <= x"7e";
                  when others => null;
                end case;
              else
                case dout is  
                  when x"45" => ascii <= x"30";
                  when x"16" => ascii <= x"31";
                  when x"1e" => ascii <= x"32";
                  when x"26" => ascii <= x"33";
                  when x"25" => ascii <= x"34";
                  when x"2e" => ascii <= x"35";
                  when x"36" => ascii <= x"36";
                  when x"3d" => ascii <= x"37";
                  when x"3e" => ascii <= x"38";
                  when x"46" => ascii <= x"39";
                  when x"52" => ascii <= x"27";
                  when x"41" => ascii <= x"2c";
                  when x"4e" => ascii <= x"2d";
                  when x"49" => ascii <= x"2e";
                  when x"4a" => ascii <= x"2f";
                  when x"4c" => ascii <= x"3b";
                  when x"55" => ascii <= x"3d";
                  when x"54" => ascii <= x"5b";
                  when x"5d" => ascii <= x"5c";
                  when x"5b" => ascii <= x"5d";
                  when x"0e" => ascii <= x"60";
                  when others => null;
                end case;
              end if;
            end if;
          if(break = '0') then
            state <= output;
          else
            state <= ready;
          end if;
        when output =>
          if(ascii(7) = '0') then
            ascii_new <= '1';
            ascii_code <= ascii(7 downto 0);
          end if;
          state <= ready;
      end case;
    end if;
  end process;

end arch;
