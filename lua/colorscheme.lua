-- Function to set colorscheme with fallbacks
local function set_cs(...)
  local cs = nil
	for _, cs in ipairs{...}  do
		local status_ok, _ = pcall(vim.cmd, "colorscheme " .. cs)
		if not status_ok then
		  --vim.notify('Colorscheme "' .. cs .. '" not found！')
      fallback=true
		else
      break
		end
	end
  if cs == nil then
    cs = "default"
  end
  if fallback then
    vim.notify('Preferred colorscheme not found, fallback to ' .. cs)
  end
end

-- Compatability with Linux TTYS
if os.getenv('DISPLAY') == nil and os.getenv('SSH_TTY') == nil then -- If under TTY
	set_cs(
		"solarized",
		"base16-default-dark"
	) -- Set colorscheme to solarized
	vim.o.background = "dark"
else -- If under GUI
	set_cs(
		"iceberg",
		"tokyonight-day",
		"catppuccin-latte",
		"github-theme",
		"seoul256",
		"gruvbox",
		"two-firewatch"
	) -- Set colorscheme to iceberg
  -- if gtk colorscheme is set to *dark or has environment variable UI_DARK_MODE set to true
  if vim.fn.system("gsettings get org.gnome.desktop.interface color-scheme"):find("dark") or
    vim.fn.system("gsettings get org.gnome.desktop.interface gtk-theme"):find("dark") or
    vim.fn.system("gsettings get org.gnome.desktop.interface gtk-color-scheme"):find("dark") or
    os.getenv("UI_DARK_MODE") == "true" then
    vim.o.background = "dark"
  else
    vim.o.background = "light"
  end
end

vim.cmd [[
"" 变量名高亮 (Just for light theme)
"" highlight the definition of a variable
"hi LspReferenceWrite cterm=bold ctermbg=LightYellow guibg=#AFBBD6 
"hi def IlluminatedWordWrite guibg=#AFBBD6
"
"" highlight the usage of a variable
"hi LspReferenceRead cterm=bold ctermbg=LightYellow guibg=#CCD2E1
"hi def IlluminatedWordRead guibg=#CCD2E1
"
"" highlight the text of a variable
"hi LspReferenceText cterm=bold ctermbg=LightYellow guibg=#DFE1E8 
"hi def IlluminatedWordText guibg=#CCD2E1

" 自动补全弃用方法添加删除线
highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#8389a3
]]
