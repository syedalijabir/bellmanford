-------------------------------------------------------------------------------
-- microblaze_0_bram_block_elaborate.vhd
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

entity microblaze_0_bram_block_elaborate is
  generic (
    C_MEMSIZE : integer;
    C_PORT_DWIDTH : integer;
    C_PORT_AWIDTH : integer;
    C_NUM_WE : integer;
    C_FAMILY : string
    );
  port (
    BRAM_Rst_A : in std_logic;
    BRAM_Clk_A : in std_logic;
    BRAM_EN_A : in std_logic;
    BRAM_WEN_A : in std_logic_vector(0 to C_NUM_WE-1);
    BRAM_Addr_A : in std_logic_vector(0 to C_PORT_AWIDTH-1);
    BRAM_Din_A : out std_logic_vector(0 to C_PORT_DWIDTH-1);
    BRAM_Dout_A : in std_logic_vector(0 to C_PORT_DWIDTH-1);
    BRAM_Rst_B : in std_logic;
    BRAM_Clk_B : in std_logic;
    BRAM_EN_B : in std_logic;
    BRAM_WEN_B : in std_logic_vector(0 to C_NUM_WE-1);
    BRAM_Addr_B : in std_logic_vector(0 to C_PORT_AWIDTH-1);
    BRAM_Din_B : out std_logic_vector(0 to C_PORT_DWIDTH-1);
    BRAM_Dout_B : in std_logic_vector(0 to C_PORT_DWIDTH-1)
  );

  attribute keep_hierarchy : STRING;
  attribute keep_hierarchy of microblaze_0_bram_block_elaborate : entity is "yes";

end microblaze_0_bram_block_elaborate;

architecture STRUCTURE of microblaze_0_bram_block_elaborate is

  component RAMB36E1 is
    generic (
      WRITE_MODE_A : string;
      WRITE_MODE_B : string;
      INIT_FILE : string;
      READ_WIDTH_A : integer;
      READ_WIDTH_B : integer;
      WRITE_WIDTH_A : integer;
      WRITE_WIDTH_B : integer;
      RAM_EXTENSION_A : string;
      RAM_EXTENSION_B : string
    );
    port (
      DBITERR : out std_logic;
      ECCPARITY : out std_logic_vector(7 downto 0);
      INJECTDBITERR : in std_logic;
      INJECTSBITERR : in std_logic;
      RDADDRECC : out std_logic_vector(8 downto 0);
      SBITERR : out std_logic;
      ADDRARDADDR : in std_logic_vector(15 downto 0);
      CASCADEINA : in std_logic;
      CASCADEOUTA : out std_logic;
      CLKARDCLK : in std_logic;
      DIADI : in std_logic_vector(31 downto 0);
      DIPADIP : in std_logic_vector(3 downto 0);
      DOADO : out std_logic_vector(31 downto 0);
      DOPADOP : out std_logic_vector(3 downto 0);
      ENARDEN : in std_logic;
      REGCEAREGCE : in std_logic;
      RSTRAMARSTRAM : in std_logic;
      RSTREGARSTREG : in std_logic;
      WEA : in std_logic_vector(3 downto 0);
      ADDRBWRADDR : in std_logic_vector(15 downto 0);
      CASCADEINB : in std_logic;
      CASCADEOUTB : out std_logic;
      CLKBWRCLK : in std_logic;
      DIBDI : in std_logic_vector(31 downto 0);
      DIPBDIP : in std_logic_vector(3 downto 0);
      DOBDO : out std_logic_vector(31 downto 0);
      DOPBDOP : out std_logic_vector(3 downto 0);
      ENBWREN : in std_logic;
      REGCEB : in std_logic;
      RSTRAMB : in std_logic;
      RSTREGB : in std_logic;
      WEBWE : in std_logic_vector(7 downto 0)
    );
  end component;

  attribute BMM_INFO : STRING;

  attribute BMM_INFO of ramb36e1_0: label is " ";
  attribute BMM_INFO of ramb36e1_1: label is " ";
  -- Internal signals

  signal net_gnd0 : std_logic;
  signal net_gnd4 : std_logic_vector(3 downto 0);
  signal pgassign1 : std_logic_vector(0 to 0);
  signal pgassign2 : std_logic_vector(0 to 3);
  signal pgassign3 : std_logic_vector(0 to 15);
  signal pgassign4 : std_logic_vector(15 downto 0);
  signal pgassign5 : std_logic_vector(31 downto 0);
  signal pgassign6 : std_logic_vector(31 downto 0);
  signal pgassign7 : std_logic_vector(3 downto 0);
  signal pgassign8 : std_logic_vector(15 downto 0);
  signal pgassign9 : std_logic_vector(31 downto 0);
  signal pgassign10 : std_logic_vector(31 downto 0);
  signal pgassign11 : std_logic_vector(7 downto 0);
  signal pgassign12 : std_logic_vector(15 downto 0);
  signal pgassign13 : std_logic_vector(31 downto 0);
  signal pgassign14 : std_logic_vector(31 downto 0);
  signal pgassign15 : std_logic_vector(3 downto 0);
  signal pgassign16 : std_logic_vector(15 downto 0);
  signal pgassign17 : std_logic_vector(31 downto 0);
  signal pgassign18 : std_logic_vector(31 downto 0);
  signal pgassign19 : std_logic_vector(7 downto 0);

begin

  -- Internal assignments

  pgassign1(0 to 0) <= B"1";
  pgassign2(0 to 3) <= B"0000";
  pgassign3(0 to 15) <= B"0000000000000000";
  pgassign4(15 downto 15) <= B"1";
  pgassign4(14 downto 4) <= BRAM_Addr_A(19 to 29);
  pgassign4(3 downto 0) <= B"0000";
  pgassign5(31 downto 16) <= B"0000000000000000";
  pgassign5(15 downto 0) <= BRAM_Dout_A(0 to 15);
  BRAM_Din_A(0 to 15) <= pgassign6(15 downto 0);
  pgassign7(3 downto 3) <= BRAM_WEN_A(0 to 0);
  pgassign7(2 downto 2) <= BRAM_WEN_A(1 to 1);
  pgassign7(1 downto 1) <= BRAM_WEN_A(0 to 0);
  pgassign7(0 downto 0) <= BRAM_WEN_A(1 to 1);
  pgassign8(15 downto 15) <= B"1";
  pgassign8(14 downto 4) <= BRAM_Addr_B(19 to 29);
  pgassign8(3 downto 0) <= B"0000";
  pgassign9(31 downto 16) <= B"0000000000000000";
  pgassign9(15 downto 0) <= BRAM_Dout_B(0 to 15);
  BRAM_Din_B(0 to 15) <= pgassign10(15 downto 0);
  pgassign11(7 downto 4) <= B"0000";
  pgassign11(3 downto 3) <= BRAM_WEN_B(0 to 0);
  pgassign11(2 downto 2) <= BRAM_WEN_B(1 to 1);
  pgassign11(1 downto 1) <= BRAM_WEN_B(0 to 0);
  pgassign11(0 downto 0) <= BRAM_WEN_B(1 to 1);
  pgassign12(15 downto 15) <= B"1";
  pgassign12(14 downto 4) <= BRAM_Addr_A(19 to 29);
  pgassign12(3 downto 0) <= B"0000";
  pgassign13(31 downto 16) <= B"0000000000000000";
  pgassign13(15 downto 0) <= BRAM_Dout_A(16 to 31);
  BRAM_Din_A(16 to 31) <= pgassign14(15 downto 0);
  pgassign15(3 downto 3) <= BRAM_WEN_A(2 to 2);
  pgassign15(2 downto 2) <= BRAM_WEN_A(3 to 3);
  pgassign15(1 downto 1) <= BRAM_WEN_A(2 to 2);
  pgassign15(0 downto 0) <= BRAM_WEN_A(3 to 3);
  pgassign16(15 downto 15) <= B"1";
  pgassign16(14 downto 4) <= BRAM_Addr_B(19 to 29);
  pgassign16(3 downto 0) <= B"0000";
  pgassign17(31 downto 16) <= B"0000000000000000";
  pgassign17(15 downto 0) <= BRAM_Dout_B(16 to 31);
  BRAM_Din_B(16 to 31) <= pgassign18(15 downto 0);
  pgassign19(7 downto 4) <= B"0000";
  pgassign19(3 downto 3) <= BRAM_WEN_B(2 to 2);
  pgassign19(2 downto 2) <= BRAM_WEN_B(3 to 3);
  pgassign19(1 downto 1) <= BRAM_WEN_B(2 to 2);
  pgassign19(0 downto 0) <= BRAM_WEN_B(3 to 3);
  net_gnd0 <= '0';
  net_gnd4(3 downto 0) <= B"0000";

  ramb36e1_0 : RAMB36E1
    generic map (
      WRITE_MODE_A => "WRITE_FIRST",
      WRITE_MODE_B => "WRITE_FIRST",
      INIT_FILE => "microblaze_0_bram_block_combined_0.mem",
      READ_WIDTH_A => 18,
      READ_WIDTH_B => 18,
      WRITE_WIDTH_A => 18,
      WRITE_WIDTH_B => 18,
      RAM_EXTENSION_A => "NONE",
      RAM_EXTENSION_B => "NONE"
    )
    port map (
      DBITERR => open,
      ECCPARITY => open,
      INJECTDBITERR => net_gnd0,
      INJECTSBITERR => net_gnd0,
      RDADDRECC => open,
      SBITERR => open,
      ADDRARDADDR => pgassign4,
      CASCADEINA => net_gnd0,
      CASCADEOUTA => open,
      CLKARDCLK => BRAM_Clk_A,
      DIADI => pgassign5,
      DIPADIP => net_gnd4,
      DOADO => pgassign6,
      DOPADOP => open,
      ENARDEN => BRAM_EN_A,
      REGCEAREGCE => net_gnd0,
      RSTRAMARSTRAM => BRAM_Rst_A,
      RSTREGARSTREG => net_gnd0,
      WEA => pgassign7,
      ADDRBWRADDR => pgassign8,
      CASCADEINB => net_gnd0,
      CASCADEOUTB => open,
      CLKBWRCLK => BRAM_Clk_B,
      DIBDI => pgassign9,
      DIPBDIP => net_gnd4,
      DOBDO => pgassign10,
      DOPBDOP => open,
      ENBWREN => BRAM_EN_B,
      REGCEB => net_gnd0,
      RSTRAMB => BRAM_Rst_B,
      RSTREGB => net_gnd0,
      WEBWE => pgassign11
    );

  ramb36e1_1 : RAMB36E1
    generic map (
      WRITE_MODE_A => "WRITE_FIRST",
      WRITE_MODE_B => "WRITE_FIRST",
      INIT_FILE => "microblaze_0_bram_block_combined_1.mem",
      READ_WIDTH_A => 18,
      READ_WIDTH_B => 18,
      WRITE_WIDTH_A => 18,
      WRITE_WIDTH_B => 18,
      RAM_EXTENSION_A => "NONE",
      RAM_EXTENSION_B => "NONE"
    )
    port map (
      DBITERR => open,
      ECCPARITY => open,
      INJECTDBITERR => net_gnd0,
      INJECTSBITERR => net_gnd0,
      RDADDRECC => open,
      SBITERR => open,
      ADDRARDADDR => pgassign12,
      CASCADEINA => net_gnd0,
      CASCADEOUTA => open,
      CLKARDCLK => BRAM_Clk_A,
      DIADI => pgassign13,
      DIPADIP => net_gnd4,
      DOADO => pgassign14,
      DOPADOP => open,
      ENARDEN => BRAM_EN_A,
      REGCEAREGCE => net_gnd0,
      RSTRAMARSTRAM => BRAM_Rst_A,
      RSTREGARSTREG => net_gnd0,
      WEA => pgassign15,
      ADDRBWRADDR => pgassign16,
      CASCADEINB => net_gnd0,
      CASCADEOUTB => open,
      CLKBWRCLK => BRAM_Clk_B,
      DIBDI => pgassign17,
      DIPBDIP => net_gnd4,
      DOBDO => pgassign18,
      DOPBDOP => open,
      ENBWREN => BRAM_EN_B,
      REGCEB => net_gnd0,
      RSTRAMB => BRAM_Rst_B,
      RSTREGB => net_gnd0,
      WEBWE => pgassign19
    );

end architecture STRUCTURE;

