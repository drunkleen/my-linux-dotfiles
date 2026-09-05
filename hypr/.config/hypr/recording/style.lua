-- Camera frame styling. Loaded after the desktop theme and personal overrides.
local active_border = hl.get_config("general.col.active_border")
-- Supply both focus states: a single gradient only overrides the active border.
-- get_config returns ARGB hex; rules require explicit RGBA color strings.
local colors = {}
for _, color in ipairs(active_border.colors) do
  local argb = color:match("^0[xX](%x%x%x%x%x%x%x%x)$")
  colors[#colors + 1] = argb and ("rgba(" .. argb:sub(3) .. argb:sub(1, 2) .. ")") or color
end
local gradient = table.concat(colors, " ") .. " " .. string.format("%.0f", active_border.angle or 0) .. "deg"
local camera_border = (#colors == 1) and (colors[1] .. " " .. colors[1]) or (gradient .. " " .. gradient)

o.window({ class = "^WebcamOverlay-(small|medium|large)$", title = "^WebcamOverlay$" }, {
  border_size = 2,
  rounding = 20,
  decorate = true,
  border_color = camera_border,
  no_shadow = true,
  opacity = "1 1",
})
