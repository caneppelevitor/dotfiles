return {
	{
		enabled = false,
		"folke/flash.nvim",
		---@type Flash.Config
		opts = {
			search = {
				forward = true,
				multi_window = false,
				wrap = false,
				incremental = true,
			},
		},
	},
	{
		"vyfor/cord.nvim",
		build = ":Cord update",
		-- opts = {}
	},
	{
		"nvim-mini/mini.hipatterns",
		event = "BufReadPre",
		opts = {
			highlighters = {
				hsl_color = {
					pattern = "hsl%(%d+,? %d+%%?,? %d+%%?%)",
					group = function(_, match)
						local utils = require("solarized-osaka.hsl")
						--- @type string, string, string
						local nh, ns, nl = match:match("hsl%((%d+),? (%d+)%%?,? (%d+)%%?%)")
						--- @type number?, number?, number?
						local h, s, l = tonumber(nh), tonumber(ns), tonumber(nl)
						--- @type string
						local hex_color = utils.hslToHex(h, s, l)
						return MiniHipatterns.compute_hex_color_group(hex_color, "bg")
					end,
				},
			},
		},
	},

	{
		"dinhhuy258/git.nvim",
		event = "BufReadPre",
		opts = {
			keymaps = {
				-- Open blame window
				blame = "<Leader>gb",
				-- Open file/folder in git repository
				browse = "<Leader>go",
			},
		},
	},

	{
		"kdheepak/lazygit.nvim",
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		keys = {
			{ "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit (Source Control)" },
			{ "<leader>gf", "<cmd>LazyGitCurrentFile<cr>", desc = "LazyGit Current File" },
		},
	},

	{
		"sindrets/diffview.nvim",
		cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewFileHistory" },
		keys = {
			{ "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Open Diffview (all changes)" },
			{ "<leader>gt", "<cmd>DiffviewToggleFiles<cr>", desc = "Toggle Diffview File Panel" },
			{ "<leader>gl", "<cmd>DiffviewFileHistory %<cr>", desc = "File History (current file)" },
			{ "<leader>gL", "<cmd>DiffviewFileHistory<cr>", desc = "File History (all files)" },
			{ "<leader>gq", "<cmd>DiffviewClose<cr>", desc = "Close Diffview" },
		},
		opts = function()
			local actions = require("diffview.actions")
			return {
			enhanced_diff_hl = true,
			use_icons = true,
			signs = {
				fold_closed = "",
				fold_open = "",
			},
			view = {
				default = {
					layout = "diff2_horizontal",
					winbar_info = true,
				},
				merge_tool = {
					layout = "diff3_horizontal",
				},
				file_history = {
					layout = "diff2_horizontal",
					winbar_info = true,
				},
			},
			file_panel = {
				listing_style = "list",
				win_config = {
					position = "right",
					-- herdr-diff panel is half a screen: give the columns to code.
					width = vim.env.NVIM_DIFF_PANEL == "1" and 26 or 40,
				},
			},
			keymaps = {
				view = {
					-- ]c / [c stay native: jump hunk-to-hunk INSIDE the current file.
					-- File-to-file navigation lives on ]f / [f and <tab>.
					{ "n", "]c", "]czz", { desc = "Next hunk (this file)" } },
					{ "n", "[c", "[czz", { desc = "Prev hunk (this file)" } },
					{ "n", "]f", actions.select_next_entry, { desc = "Next file" } },
					{ "n", "[f", actions.select_prev_entry, { desc = "Prev file" } },
					{ "n", "<tab>", actions.select_next_entry, { desc = "Next file" } },
					{ "n", "<s-tab>", actions.select_prev_entry, { desc = "Prev file" } },
					{ "n", "]x", actions.next_conflict, { desc = "Next conflict" } },
					{ "n", "[x", actions.prev_conflict, { desc = "Prev conflict" } },
					{ "n", "gf", actions.goto_file_edit, { desc = "Leave diff, edit real file" } },
					{ "n", "gp", actions.focus_files, { desc = "Focus file panel" } },
					{ "n", "<leader>gt", actions.toggle_files, { desc = "Toggle file panel" } },
					{ "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close Diffview" } },
					-- Conflict resolution
					{ "n", "<leader>co", actions.conflict_choose("ours"), { desc = "Conflict: take OURS" } },
					{ "n", "<leader>ct", actions.conflict_choose("theirs"), { desc = "Conflict: take THEIRS" } },
					{ "n", "<leader>cb", actions.conflict_choose("base"), { desc = "Conflict: take BASE" } },
					{ "n", "<leader>ca", actions.conflict_choose("all"), { desc = "Conflict: take ALL" } },
					{ "n", "<leader>cx", actions.conflict_choose("none"), { desc = "Conflict: take NONE" } },
				},
				file_panel = {
					{ "n", "j", actions.next_entry, { desc = "Next file" } },
					{ "n", "k", actions.prev_entry, { desc = "Prev file" } },
					{ "n", "<down>", actions.select_next_entry, { desc = "Next file + open" } },
					{ "n", "<up>", actions.select_prev_entry, { desc = "Prev file + open" } },
					-- <cr> jumps INTO the diff so j/k scroll the file; o previews
					-- it without leaving the list.
					{ "n", "<cr>", actions.focus_entry, { desc = "Open file + focus diff" } },
					{ "n", "o", actions.select_entry, { desc = "Open file, stay in list" } },
					{ "n", "s", actions.toggle_stage_entry, { desc = "Stage/unstage" } },
					{ "n", "S", actions.stage_all, { desc = "Stage all" } },
					{ "n", "U", actions.unstage_all, { desc = "Unstage all" } },
					{ "n", "X", actions.restore_entry, { desc = "Discard file changes" } },
					{ "n", "R", actions.refresh_files, { desc = "Refresh" } },
					{ "n", "L", actions.open_commit_log, { desc = "Commit log" } },
					{ "n", "zR", actions.open_all_folds, { desc = "Expand all" } },
					{ "n", "zM", actions.close_all_folds, { desc = "Collapse all" } },
					{ "n", "gf", actions.goto_file_edit, { desc = "Leave diff, edit real file" } },
					{ "n", "<leader>gt", actions.toggle_files, { desc = "Toggle file panel" } },
					{ "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close Diffview" } },
				},
				file_history_panel = {
					{ "n", "<cr>", actions.select_entry, { desc = "Open diff for commit" } },
					{ "n", "y", actions.copy_hash, { desc = "Copy commit hash" } },
					{ "n", "L", actions.open_commit_log, { desc = "Commit log" } },
					{ "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close Diffview" } },
				},
			},
			}
		end,
	},

	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
			"nvim-telescope/telescope-file-browser.nvim",
		},
		keys = {
			{
				"<leader>fP",
				function()
					require("telescope.builtin").find_files({
						cwd = require("lazy.core.config").options.root,
					})
				end,
				desc = "Find Plugin File",
			},
			{
				"<leader>ff",
				function()
					local builtin = require("telescope.builtin")
					builtin.find_files({
						no_ignore = true,
						hidden = true,
					})
				end,
				desc = "Find files",
			},
			{
				"<leader><leader>",
				function()
					local builtin = require("telescope.builtin")
					builtin.find_files({
						no_ignore = true,
						hidden = true,
					})
				end,
				desc = "Find files",
			},
			{
				";r",
				function()
					local builtin = require("telescope.builtin")
					builtin.live_grep({
						additional_args = { "--hidden" },
					})
				end,
				desc = "Search for a string in your current working directory and get results live as you type, respects .gitignore",
			},
			{
				"\\\\",
				function()
					local builtin = require("telescope.builtin")
					builtin.buffers()
				end,
				desc = "Lists open buffers",
			},
			{
				";t",
				function()
					local builtin = require("telescope.builtin")
					builtin.help_tags()
				end,
				desc = "Lists available help tags and opens a new window with the relevant help info on <cr>",
			},
			{
				";;",
				function()
					local builtin = require("telescope.builtin")
					builtin.resume()
				end,
				desc = "Resume the previous telescope picker",
			},
			{
				";e",
				function()
					local builtin = require("telescope.builtin")
					builtin.diagnostics()
				end,
				desc = "Lists Diagnostics for all open buffers or a specific buffer",
			},
			{
				";s",
				function()
					local builtin = require("telescope.builtin")
					builtin.treesitter()
				end,
				desc = "Lists Function names, variables, from Treesitter",
			},
			{
				";c",
				function()
					local builtin = require("telescope.builtin")
					builtin.lsp_incoming_calls()
				end,
				desc = "Lists LSP incoming calls for word under the cursor",
			},
			{
				"sf",
				function()
					local telescope = require("telescope")

					local function telescope_buffer_dir()
						return vim.fn.expand("%:p:h")
					end

					telescope.extensions.file_browser.file_browser({
						path = "%:p:h",
						cwd = telescope_buffer_dir(),
						respect_gitignore = false,
						hidden = true,
						grouped = true,
						previewer = false,
						initial_mode = "normal",
						layout_config = { height = 40 },
					})
				end,
				desc = "Open File Browser with the path of the current buffer",
			},
		},
		config = function(_, opts)
			local telescope = require("telescope")
			local actions = require("telescope.actions")
			local fb_actions = require("telescope").extensions.file_browser.actions

			opts.defaults = vim.tbl_deep_extend("force", opts.defaults, {
				wrap_results = true,
				layout_strategy = "horizontal",
				layout_config = { prompt_position = "top" },
				sorting_strategy = "ascending",
				winblend = 0,
				file_ignore_patterns = {
					"node_modules/",
					"%.git/",
					"dist/",
					"build/",
					"%.next/",
				},
				mappings = {
					n = {},
				},
			})
			opts.pickers = {
				diagnostics = {
					theme = "ivy",
					initial_mode = "normal",
					layout_config = {
						preview_cutoff = 9999,
					},
				},
			}
			opts.extensions = {
				file_browser = {
					theme = "dropdown",
					-- disables netrw and use telescope-file-browser in its place
					hijack_netrw = true,
					mappings = {
						-- your custom insert mode mappings
						["n"] = {
							-- your custom normal mode mappings
							["N"] = fb_actions.create,
							["h"] = fb_actions.goto_parent_dir,
							["/"] = function()
								vim.cmd("startinsert")
							end,
							["<C-u>"] = function(prompt_bufnr)
								for i = 1, 10 do
									actions.move_selection_previous(prompt_bufnr)
								end
							end,
							["<C-d>"] = function(prompt_bufnr)
								for i = 1, 10 do
									actions.move_selection_next(prompt_bufnr)
								end
							end,
							["<PageUp>"] = actions.preview_scrolling_up,
							["<PageDown>"] = actions.preview_scrolling_down,
						},
					},
				},
			}
			telescope.setup(opts)
			require("telescope").load_extension("fzf")
			require("telescope").load_extension("file_browser")
		end,
	},

	{
		"kazhala/close-buffers.nvim",
		event = "VeryLazy",
		keys = {
			{
				"<leader>th",
				function()
					require("close_buffers").delete({ type = "hidden" })
				end,
				"Close Hidden Buffers",
			},
			{
				"<leader>tu",
				function()
					require("close_buffers").delete({ type = "nameless" })
				end,
				"Close Nameless Buffers",
			},
		},
	},

	{
		"saghen/blink.cmp",
		opts = {
			completion = {
				menu = {
					winblend = vim.o.pumblend,
				},
			},
			signature = {
				window = {
					winblend = vim.o.pumblend,
				},
			},
		},
	},
}
