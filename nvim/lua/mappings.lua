--
-- ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
-- ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
-- ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
-- ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
-- ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
-- ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
--
-- File: mappings.lua
-- Description: Key mapping configs
-- Author: Kien Nguyen-Tuan <kiennt2609@gmail.com>

-- <leader> is a space now
local map = vim.keymap.set
local cmd = vim.cmd

-- <leader> and x exits nvim alltogether
-- <leader> and q exits the current file
map("n", "<leader>x", ":qa!<CR>", {})
map("n", "<leader>q", ":q!<CR>", {})
-- Fast saving with <leader> and s
map("n", "<leader>s", ":w<CR>", {})
-- Move around splits
map("n", "<k4>", "<C-w>k", { desc = "switch window up (top row)" })
map("n", "<k5>", "<C-w>h", { desc = "switch window left (top row)" })
map("n", "<k8>", "<C-w>j", { desc = "switch window down (top row)" })
map("n", "<k6>", "<C-w>l", { desc = "switch window right (top row)" })

-- Reload configuration without restart nvim
-- Or you don't want to use plenary.nvim, you can use this code
-- function _G.reload_config()
-- 	for name, _ in pairs(package.loaded) do
-- 		if name:match("^me") then
-- 			package.loaded[name] = nil
-- 		end
-- 	end

-- 	dofile(vim.env.MYVIMRC)
-- 	vim.notify("Nvim configuration reloaded!", vim.log.levels.INFO)
-- end
function _G.reload_config()
    local reload = require("plenary.reload").reload_module
    reload("me", false)

    dofile(vim.env.MYVIMRC)
    vim.notify("Nvim configuration reloaded!", vim.log.levels.INFO)
end

map("n", "rr", _G.reload_config, { desc = "Reload configuration without restart nvim" })

-- Telescope
local builtin = require "telescope.builtin"
map("n", "<leader>ff", builtin.find_files, { desc = "Open Telescope to find files" })
map("n", "<leader>fg", builtin.live_grep, { desc = "Open Telescope to do live grep" })
map("n", "<leader>fb", builtin.buffers, { desc = "Open Telescope to list buffers" })
map("n", "<leader>fh", builtin.help_tags, { desc = "Open Telescope to show help" })
map("n", "<leader>fo", builtin.oldfiles, { desc = "Open Telescope to list recent files" })
map("n", "<leader>cm", builtin.git_commits, { desc = "Open Telescope to list git commits" })
-- NvimTree
map("n", "<leader>n", ":NvimTreeToggle<CR>", { desc = "Toggle NvimTree sidebar" }) -- open/close
map("n", "<leader>nr", ":NvimTreeRefresh<CR>", { desc = "Refresh NvimTree" }) -- refresh
map("n", "<leader>nf", ":NvimTreeFindFile<CR>", { desc = "Search file in NvimTree" }) -- search file

-- LSP
map(
    "n",
    "<leader>gm",
    function() require("conform").format { lsp_fallback = true } end,
    { desc = "General Format file" }
)

-- global lsp mappings
map("n", "<leader>ds", vim.diagnostic.setloclist, { desc = "LSP Diagnostic loclist" })

-- Comment
map("n", "mm", "gcc", { desc = "Toggle comment", remap = true })
map("v", "mm", "gc", { desc = "Toggle comment", remap = true })

-- Terminal
map("n", "tt", function()
    local height = math.floor(vim.o.lines / 2)
    cmd("belowright split | resize " .. height .. " | terminal")
end, { noremap = true, silent = true })
