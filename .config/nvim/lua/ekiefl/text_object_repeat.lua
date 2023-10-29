local M = {}
local ai = require("mini.ai")

M.last_text_object_action = nil

M.unpack_pattern = function(pattern)
  local inner_or_outer = string.sub(pattern, 1, 1)
  local method_specifier = string.sub(pattern, 2, 2)
  local match_char = string.sub(pattern, 3, 3)
  return inner_or_outer, method_specifier, match_char
end

M.method_to_specifier = function(method)
  return method == "next" and "n" or (method == "prev" and "l" or nil)
end

M.specifier_to_method = function(specifier)
  return specifier == "n" and "next" or (specifier == "l" and "prev" or nil)
end

M.invert_method = function(method)
  return method == "prev" and "next" or (method == "next" and "prev" or nil)
end

M.invert_pattern = function(pattern)
  local inner_or_outer, method_specifier, match_char = M.unpack_pattern(pattern)
  local inverted_specifier = M.method_to_specifier(M.invert_method(M.specifier_to_method(method_specifier)))
  return inner_or_outer .. inverted_specifier .. match_char
end

M.execute_and_remember = function(pattern)
  M.last_text_object_action = pattern
  local inner_or_outer, method_specifier, match_char = M.unpack_pattern(pattern)
  ai.select_textobject(
    inner_or_outer,
    match_char,
    { vis_mode = "v", search_method = M.specifier_to_method(method_specifier) }
  )
end

M.repeat_last_text_object = function()
  if M.last_text_object_action ~= "" then
    M.execute_and_remember(M.last_text_object_action)
  end
end

M.inverse_repeat_last_text_object = function()
  if M.last_text_object_action ~= "" then
    M.execute_and_remember(M.invert_pattern(M.last_text_object_action))
  end
  M.last_text_object_action = M.invert_pattern(M.last_text_object_action)
end

return M
