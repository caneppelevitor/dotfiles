return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		cmd = "Neotree",
		keys = {
			{ "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle File Explorer" },
			{ "<leader>ge", "<cmd>Neotree toggle git_status right<cr>", desc = "Git Changes Panel (right)" },
			{
				"<leader>gz",
				"<cmd>Neotree show filesystem left<cr><cmd>Neotree show git_status right<cr>",
				desc = "Zed Layout (tree left + changes right)",
			},
		},
		opts = {
			close_if_last_window = false,
			popup_border_style = "rounded",
			enable_git_status = true,
			enable_diagnostics = true,
			default_component_configs = {
				git_status = {
					symbols = {
						-- Change type
						added = "✚",
						modified = "",
						deleted = "✖",
						renamed = "󰁕",
						-- Status type
						untracked = "",
						ignored = "",
						unstaged = "󰄱",
						staged = "",
						conflict = "",
					},
				},
			},
			window = {
				position = "left",
				width = 35,
				mappings = {
					["<space>"] = "none",
					["<cr>"] = "open",
					["o"] = "open",
					["<esc>"] = "cancel",
					["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
					["l"] = "open",
					["h"] = "close_node",
					["z"] = "close_all_nodes",
					["Z"] = "expand_all_nodes",
					["a"] = { "add", config = { show_path = "relative" } },
					["A"] = "add_directory",
					["d"] = "delete",
					["r"] = "rename",
					["y"] = "copy_to_clipboard",
					["x"] = "cut_to_clipboard",
					["p"] = "paste_from_clipboard",
					["c"] = "copy",
					["m"] = "move",
					["q"] = "close_window",
					["R"] = "refresh",
					["?"] = "show_help",
					["<"] = "prev_source",
					[">"] = "next_source",
					["i"] = "show_file_details",
				},
			},
			filesystem = {
				filtered_items = {
					visible = false,
					hide_dotfiles = false,
					hide_gitignored = false,
					hide_hidden = true,
				},
				follow_current_file = {
					enabled = true,
					leave_dirs_open = false,
				},
				group_empty_dirs = false,
				hijack_netrw_behavior = "open_default",
				use_libuv_file_watcher = true,
				window = {
					mappings = {
						["<bs>"] = "navigate_up",
						["."] = "set_root",
						["H"] = "toggle_hidden",
						["/"] = "fuzzy_finder",
						["D"] = "fuzzy_finder_directory",
						["#"] = "fuzzy_sorter",
						["f"] = "filter_on_submit",
						["<c-x>"] = "clear_filter",
						["[g"] = "prev_git_modified",
						["]g"] = "next_git_modified",
						["gs"] = "git_add_file",
						["gu"] = "git_unstage_file",
						["gr"] = "git_revert_file",
					},
				},
			},
			git_status = {
				commands = {
					-- Zed-style: selecting a changed file opens its diff, not the raw file
					open_diff = function(state)
						local node = state.tree:get_node()
						if not node or node.type == "directory" then
							return
						end
						vim.cmd("DiffviewOpen -- " .. vim.fn.fnameescape(node.path))
					end,
				},
				window = {
					position = "right",
					width = 40,
					mappings = {
						["A"] = "git_add_all",
						["gu"] = "git_unstage_file",
						["ga"] = "git_add_file",
						["gr"] = "git_revert_file",
						["gc"] = "git_commit",
						["gp"] = "git_push",
						["gg"] = "git_commit_and_push",
						["<cr>"] = "open_diff",
						["o"] = "open_diff",
						["O"] = "open",
					},
				},
			},
		},
	},
}
