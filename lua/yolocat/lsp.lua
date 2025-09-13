local function populateDefaults(target, defaults)
    for key, value in pairs(defaults) do
        -- Check if the key is missing or the value is nil in the target table
        if target[key] == nil then
            -- Copy the value from the default table
            if type(value) == "table" then
                target[key] = {}
                populateDefaults(target[key], value) -- Recursively populate for nested tables
            else
                target[key] = value
            end
        elseif type(value) == "table" and type(target[key]) == "table" then
            -- If both the target and default values are tables, recurse
            populateDefaults(target[key], value)
        end
    end
    return target
end

local defaults = {
	rust_analyzer = {
		settings = {
			["rust-analyzer"] = {
				check = {
					command = "clippy",
				},
				checkOnSave = true,
			}
		}
	}
}

function Configure(lsp, config)
	local defaultConfig = defaults[lsp] or {}
	local finalConfig = populateDefaults(config, defaultConfig)
	require'lspconfig'[lsp].setup(finalConfig)
end

function ConfigureDefaults()
	for lsp, config in pairs(defaults) do
		Configure(lsp, config)
	end
end

return {
	Configure = Configure,
	ConfigureDefaults = ConfigureDefaults,
}
