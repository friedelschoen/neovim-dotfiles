vim.api.nvim_create_user_command("Fitch", function()
	local symbols = {
		[":and"] = "∧",
		[":con"] = "∧",
		[":or"] = "∨",
		[":dis"] = "∨",
		[":not"] = "¬",
		[":neg"] = "¬",
		[":imp"] = "→",
		[":bic"] = "↔",
		[":bot"] = "⊥",
		[":fa"] = "∀",
		[":ex"] = "∃",
	}

	for lhs, rhs in pairs(symbols) do
		vim.keymap.set("i", lhs, rhs, {
			buffer = true,
			noremap = true,
		})
	end
end, { nargs = 0 })
