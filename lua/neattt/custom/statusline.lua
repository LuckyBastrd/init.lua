Statusline = {}

-- stylua: ignore start
local modes  = {
    ['n']      = 'NO',
    ['no']     = 'OP',
    ['nov']    = 'OC',
    ['noV']    = 'OL',
    ['no\22']  = 'OB',
    ['niI']    = 'IN',
    ['niR']    = 'RE',
    ['niV']    = 'RV',
    ['nt']     = 'NT',
    ['ntT']    = 'TM',
    ['v']      = 'VI',
    ['vs']     = 'VI',
    ['V']      = 'VL',
    ['Vs']     = 'VL',
    ['\22']    = 'VB',
    ['\22s']   = 'VB',
    ['s']      = 'SE',
    ['S']      = 'SL',
    ['\19']    = 'SB',
    ['i']      = 'IN',
    ['ic']     = 'IC',
    ['ix']     = 'IX',
    ['R']      = 'RE',
    ['Rc']     = 'RC',
    ['Rx']     = 'RX',
    ['Rv']     = 'RV',
    ['Rvc']    = 'RC',
    ['Rvx']    = 'RX',
    ['c']      = 'CO',
    ['cv']     = 'CV',
    ['ce']     = 'CE',
    ['r']      = 'RR',
    ['rm']     = 'PM',
    ['r?']     = '??',
    ['!']      = 'SH',
    ['t']      = 'TE',
}
-- stylua: ignore end

-- Function to determine the color based on the mode
local function color()
    local mode = vim.api.nvim_get_mode().mode
    local mode_color = '%#Normal#'

    if mode == "n" then
        mode_color = "%#StatusNormal#"
    elseif mode == "i" or mode == "ic" then
        mode_color = "%#StatusInsert#"
    elseif mode == "v" or mode == "V" or mode == "\22" then
        mode_color = "%#StatusVisual#"
    elseif mode == "R" then
        mode_color = "%#StatusReplace#"
    elseif mode == "c" then
        mode_color = "%#StatusCommand#"
    elseif mode == "t" then
        mode_color = "%#StatusTerminal#"
    end

    return mode_color
end

--- Function to get nvim mode
local function get_mode_label()
  local mode = vim.api.nvim_get_mode().mode
  return string.upper(modes[mode] or mode)
end

-- Function to get file info
local function get_fileinfo()
  local filename = vim.fn.expand("%:t")

  if filename == "" then
    filename = " pi-nvim "
  else
    filename = " " .. filename .. " "
  end

  return "%#Normal#" .. filename .. "%*"
end

local function get_git_status()
  local gitsigns = vim.b.gitsigns_status_dict

  if gitsigns and gitsigns.head and gitsigns.head ~= "" then
    return string.format("( • %s) ", gitsigns.head)
  end

  return ""
end

-- Function to get the buffer number
local function get_bufnr()
    return vim.api.nvim_get_current_buf() or ""
end

-- Function to get the filetype
local function get_filetype()
    return vim.bo.filetype or ""
end

-- Function to get the search count
local function get_searchcount()
    if vim.v.hlsearch == 0 then
        return "%#Normal# %l:%c "
    end

    local ok, count = pcall(vim.fn.searchcount, {recompute = true})

    if not ok or count.current == nil or count.total == 0 then
        return ""
    end

    if count.incomplete == 1 then
        return "?/?"
    end

    local too_many = string.format('>%d', count.maxcount)
    local total = count.total > count.maxcount and too_many or count.total

    return string.format(" %#Normal# %s matches ", total)
end

-- Build the statusline string
Statusline.statusline = function()
    return table.concat({
      color(),
      string.format(" %s ", get_mode_label()),
      get_fileinfo(),
      get_git_status(),
      get_bufnr(),
      "%=",
      get_filetype(),
      get_searchcount(),
    })
end

vim.o.statusline = "%!v:lua.Statusline.statusline()"
vim.o.laststatus = 3
