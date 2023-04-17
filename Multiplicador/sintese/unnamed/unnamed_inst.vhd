	component unnamed is
		port (
			probe  : in  std_logic_vector(15 downto 0) := (others => 'X'); -- probe
			source : out std_logic_vector(16 downto 0)                     -- source
		);
	end component unnamed;

	u0 : component unnamed
		port map (
			probe  => CONNECTED_TO_probe,  --  probes.probe
			source => CONNECTED_TO_source  -- sources.source
		);

