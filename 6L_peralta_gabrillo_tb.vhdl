-- Authors :
-- Gio Joshua B. Peralta
-- Marvince R. Gabrillo

library IEEE; use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity farm_buzzer_tb is 
end;

architecture buzzer_tb of farm_buzzer_tb is

    component farm_buzzer is
        port (
            i1, i2, i3 : in std_logic;
            o1, o2, o3 : in std_logic;
            res_in     : inout std_logic;
            res_out    : inout std_logic;
            alarm      : out std_logic
        );
    end component;

        signal i1, i2, i3 : std_logic;
        signal o1, o2, o3 : std_logic;
        signal res_in     : std_logic;
        signal res_out    : std_logic;
        signal alarm      : std_logic;

    begin   
        uut : component farm_buzzer port map ( i1, i2, i3, o1, o2, o3, res_in, res_out, alarm);
        process
            variable inputs           : unsigned(5 downto 0);
            variable expected_res_in  : std_logic := '0';
            variable expected_res_out : std_logic := '0';
            variable expected_alarm   : std_logic := '0';
        begin 

            for i in 0 to 63 loop

                inputs := TO_UNSIGNED(i, 6);

                i3 <= inputs(5);
                i2 <= inputs(4);
                i1 <= inputs(3);
                o3 <= inputs(2);
                o2 <= inputs(1);
                o1 <= inputs(0);

                if(i=0) then 
                    expected_res_out := '0';
                    expected_res_in  := '0';
                    expected_alarm   := '0';
                else
                    if((i3 = '1') or (i2 = '1') or (i1 = '1')) then expected_res_in := '1';
                    elsif((o3 = '1') or (o2 = '1') or (o1 = '1')) then expected_res_out := '1';
                    end if;
                    if((expected_res_out = '1') and (expected_res_in = '1')) then expected_alarm :='1';
                    end if;
                end if;
                wait for 10 ns;

                if(expected_res_in = '1') then
                    assert(expected_res_in = res_in) report "Design Error!";
                end if;

                if(expected_res_in = '0') then
                    assert(expected_res_in = res_in) report "Design Error!";
                end if;

                if(expected_res_out = '1') then
                    assert(expected_res_out = res_out) report "Design Error!";
                end if;

                if(expected_res_out = '0') then
                    assert(expected_res_out = res_out) report "Design Error!";
                end if;

                if((expected_res_out = '1') and (expected_res_in = '1')) then
                    assert(expected_alarm = '1' and alarm = '1') report "Design Error!";
                end if;

            end loop; 
            wait;
        end process;
end architecture;
