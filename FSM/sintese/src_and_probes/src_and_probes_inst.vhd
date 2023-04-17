	component src_and_probes is
		port (
			source : out std_logic_vector(3 downto 0);                    -- source
			probe  : in  std_logic_vector(2 downto 0) := (others => 'X')  -- probe
		);
	end component src_and_probes;

	u0 : component src_and_probes
		port map (
			source => CONNECTED_TO_source, -- sources.source
			probe  => CONNECTED_TO_probe   --  probes.probe
		);

