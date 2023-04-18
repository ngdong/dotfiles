_G.dump = function(...)
  print(vim.inspect(...))
end

_G.prequire = function(...)
  local status, lib = pcall(require, ...)
  if status then
    return lib
  end
  return nil
end

local max = math.max
local min = math.min
local M = {}

M.separators = {
  vertical_bar = '┃',
  vertical_bar_thin = '│',
  left = '',
  right = '',
  block = '█',
  left_filled = '',
  right_filled = '',
  slant_left = '',
  slant_left_thin = '',
  slant_right = '',
  slant_right_thin = '',
  slant_left_2 = '',
  slant_left_2_thin = '',
  slant_right_2 = '',
  slant_right_2_thin = '',
  left_rounded = '',
  left_rounded_thin = '',
  right_rounded = '',
  right_rounded_thin = '',
  circle = '●',
  github_icon = " ﯙ ",
  folder_icon = " ",
  ghost = ''
}

-- Converts the given hex color to normalized rgba
function hex2rgb (hex)
  print( 'hex:', hex )
  local hex = hex:gsub("#","")
  if hex:len() == 3 then
    return (tonumber("0x"..hex:sub(1,1))*17)/255, (tonumber("0x"..hex:sub(2,2))*17)/255, (tonumber("0x"..hex:sub(3,3))*17)/255
  else
    return tonumber("0x"..hex:sub(1,2))/255, tonumber("0x"..hex:sub(3,4))/255, tonumber("0x"..hex:sub(5,6))/255
  end
end

function M.t(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

function M.exists(list, val)
  local set = {}
  for _, l in ipairs(list) do
    set[l] = true
  end
  return set[val]
end

function M.log(msg, hl, name)
  name = name or "Neovim"
  hl = hl or "Todo"
  vim.api.nvim_echo({ { name .. ": ", hl }, { msg } }, true, {})
end

function M.warn(msg, name)
  vim.notify(msg, vim.log.levels.WARN, { title = name })
end

function M.error(msg, name)
  vim.notify(msg, vim.log.levels.ERROR, { title = name })
end

function M.info(msg, name)
  vim.notify(msg, vim.log.levels.INFO, { title = name })
end

function M.is_empty(s)
  return s == nil or s == ""
end

function M.get_buf_option(opt)
  local status_ok, buf_option = pcall(vim.api.nvim_buf_get_option, 0, opt)
  if not status_ok then
    return nil
  else
    return buf_option
  end
end

function M.quit()
  local bufnr = vim.api.nvim_get_current_buf()
  local modified = vim.api.nvim_buf_get_option(bufnr, "modified")
  if modified then
    vim.ui.input({
      prompt = "You have unsaved changes. Quit anyway? (y/n) ",
    }, function(input)
      if input == "y" then
        vim.cmd "q!"
      end
    end)
  else
    vim.cmd "q!"
  end
end

-- Lightens a given hex color by the specified amount
function M.lighten(color, amount)
  local r, g, b
  r, g, b = hex2rgb(color)
  r = 255 * r
  g = 255 * g
  b = 255 * b
  r = r + floor(2.55 * amount)
  g = g + floor(2.55 * amount)
  b = b + floor(2.55 * amount)
  r = r > 255 and 255 or r
  g = g > 255 and 255 or g
  b = b > 255 and 255 or b
  return ("#%02x%02x%02x"):format(r, g, b)
end

-- Darkens a given hex color by the specified amount
function M.darken(color, amount)
  local r, g, b
  r, g, b = hex2rgb(color)
  r = 255 * r
  g = 255 * g
  b = 255 * b
  r = max(0, r - floor(r * (amount / 100)))
  g = max(0, g - floor(g * (amount / 100)))
  b = max(0, b - floor(b * (amount / 100)))
  return ("#%02x%02x%02x"):format(r, g, b)
end

function M.is_zen() return vim.env.NVIMZEN == "1" end

-- function M.nvim_version(val)
--   local version = (vim.version().major .. "." .. vim.version().minor) + 0.0
--   val = val or 0.7
--   if version >= val then
--     return true
--   else
--     return false
--   end
-- end
--
-- function M.nvim_nightly()
--   return M.nvim_version(0.7)
-- end

return M
