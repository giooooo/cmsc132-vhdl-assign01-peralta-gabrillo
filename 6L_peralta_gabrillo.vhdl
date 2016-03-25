-- Authors:
-- Gio Joshua B. Peralta
-- Marvince R. Gabrillo

library IEEE; use IEEE.std_logic_1164.all;

entity farm_buzzer is
    port (
        i1, i2, i3 : in std_logic;
        o1, o2, o3 : in std_logic;
        res_in     : inout std_logic;
        res_out    : inout std_logic;
        alarm      : out std_logic
    );
end entity; -- farm-buzzer

architecture buzzer of farm_buzzer is
begin
    res_in  <= (i1 or i2 or i3);
    res_out <= (o1 or o2 or o3);
    alarm   <= res_out and res_in;
end architecture buzzer;