-- shipwright_build.lua

local lushwright = require("shipwright.transform.lush")

-- we start by calling run and giving it our colorscheme as the first argument.
-- any other arguments form the pipeline.
run(
	require("lua/lush_theme/pax"),

	-- now we will convert that colorscheme to a list of vimscript highlight commands
	lushwright.to_vimscript,

	-- we can pass the vimscript through a vim compatible transform if we want.
	-- note: this strips blending
	-- lushwright.vim_compatible_vimscript,

	-- the vimscript commands alone are generally not enough for a colorscheme, we
	-- will need to append a few housekeeping lines first.
	--
	-- note how we are passing arguments to append by wrapping the transform in a table.
	-- {transform 1 2 3} ends up as transform(last_pipe_value, 1, 2, 3)
	--
	-- append() accepts a table of values, or one value, so this call ends up being:
	-- append(last_pipe_value, {"set...",  "let..."})
	-- MANUALLY ADD `hi clear` at top of file
	{ append, { "set background=dark", 'let g:colors_name="pax"' } },

	-- now we are ready to write our colors file. note: there is no reason this has
	-- to be written to the relative "colors" dir, you could write the file to an
	-- entirely different vim plugin.
	{ overwrite, "vimscript/pax.vim" }
)

-- and that is the whole build file
