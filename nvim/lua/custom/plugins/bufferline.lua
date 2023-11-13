local status, bufferline = pcall(require, "bufferline")
if (not status) then return end

bufferline.setup{
  options = {
    separator_style = 'slant',
    show_buffer_close_icons = false,
    show_close_icon = false,
    color_icons = true
  },
  highlights = {
  },
}
