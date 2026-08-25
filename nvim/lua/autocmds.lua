vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('k-hightlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- [[ resize splits if window got resized ]]
local resize_group = vim.api.nvim_create_augroup('ResizeSplit', { clear = true })
vim.api.nvim_create_autocmd({ 'VimResized' }, {
  group = resize_group,
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd 'tabdo wincmd ='
    vim.cmd('tabnext ' .. current_tab)
  end,
})

vim.api.nvim_create_user_command('Glow', function()
  vim.cmd('terminal glow ' .. vim.fn.expand '%')
end, {})

vim.api.nvim_create_user_command('NewClass', function(opts)
  -- 1. Inputs
  local class_name = opts.args or vim.fn.input 'Class Name: '
  if class_name == '' then
    return
  end

  local header_path = vim.fn.input('Header Path (e.g., include/ksys/net): ', 'include/ksys')
  if header_path == '' then
    header_path = 'include'
  end

  local source_path = vim.fn.input('Source Path (e.g., src/ksys/net): ', 'src/')
  if source_path == '' then
    source_path = 'src'
  end

  local namespace = vim.fn.input('Namespace (default: ksys::net): ', 'ksys::net')
  if namespace == '' then
    namespace = 'ksys::net'
  end

  -- 2. Paths
  local filename = class_name:lower()
  local header_file = filename .. '.hpp'
  local source_file = filename .. '.cpp'

  local full_header_path = header_path .. '/' .. header_file
  local full_source_path = source_path .. '/' .. source_file

  -- 3. Create Directories
  local function ensure_dir(path)
    local dir = vim.fn.fnamemodify(path, ':p:h')
    if dir ~= '' and not vim.fn.isdirectory(dir) then
      vim.fn.system('mkdir -p ' .. vim.fn.shellescape(dir))
    end
  end
  ensure_dir(full_header_path)
  ensure_dir(full_source_path)

  -- 4. Calculate Include Path
  local include_path = header_path
  if include_path:match '^include/' then
    include_path = include_path:sub(9)
  end
  if include_path == 'include' then
    include_path = ''
  end

  local final_include = include_path ~= '' and (include_path .. '/' .. header_file) or header_file

  -- 5. Content Generation
  local file_header = {
    '#pragma once',
    '',
    '/**',
    string.format(' * \\file %s', header_file),
    string.format(' * \\brief %s abstraction.', class_name),
    string.format(' * \\namespace %s', namespace),
    string.format(' * \\class %s', class_name),
    ' */',
    '',
  }

  local header_lines = {}
  for _, line in ipairs(file_header) do
    table.insert(header_lines, line)
  end
  table.insert(header_lines, string.format('namespace %s {', namespace))
  table.insert(header_lines, '')
  table.insert(header_lines, '/**')
  table.insert(header_lines, string.format(' * \\brief %s description.', class_name))
  table.insert(header_lines, ' *')
  table.insert(header_lines, ' * \\details TODO: Add detailed description here.')
  table.insert(header_lines, ' */')
  table.insert(header_lines, string.format('class %s {', class_name))
  table.insert(header_lines, ' public:')
  table.insert(header_lines, '  /**')
  table.insert(header_lines, string.format('   * \\brief Constructs a default %s.', class_name))
  table.insert(header_lines, '   */')
  table.insert(header_lines, string.format('  %s();', class_name))
  table.insert(header_lines, '')
  table.insert(header_lines, '  /**')
  table.insert(header_lines, string.format('   * \\brief Destroys the %s.', class_name))
  table.insert(header_lines, '   */')
  table.insert(header_lines, string.format('  ~%s();', class_name))
  table.insert(header_lines, '')
  table.insert(header_lines, '};')
  table.insert(header_lines, '')
  table.insert(header_lines, string.format('}  // namespace %s', namespace))

  local source_lines = {
    string.format('#include <%s>', final_include),
    '',
    string.format('namespace %s {', namespace),
    '',
    string.format('%s::%s() {', class_name, class_name),
    '   // TODO: Initialize',
    '}',
    '',
    string.format('%s::~%s() {', class_name, class_name),
    '  // TODO: Cleanup',
    '}',
    '',
    string.format('}  // namespace %s', namespace),
  }

  -- 6. Create and Write Header
  local header_buf = vim.api.nvim_create_buf(true, true)
  vim.api.nvim_buf_set_lines(header_buf, 0, -1, false, header_lines)
  vim.bo[header_buf].buftype = ''
  vim.bo[header_buf].swapfile = false
  vim.api.nvim_buf_set_name(header_buf, full_header_path)

  -- FORCE FILETYPE HERE
  vim.bo[header_buf].filetype = 'cpp'
  vim.bo[header_buf].modified = true

  vim.api.nvim_buf_call(header_buf, function()
    vim.cmd 'silent! write!'
  end)

  -- 7. Create and Write Source
  local source_buf = vim.api.nvim_create_buf(true, true)
  vim.api.nvim_buf_set_lines(source_buf, 0, -1, false, source_lines)
  vim.bo[source_buf].buftype = ''
  vim.bo[source_buf].swapfile = false
  vim.api.nvim_buf_set_name(source_buf, full_source_path)

  -- FORCE FILETYPE HERE
  vim.bo[source_buf].filetype = 'cpp'
  vim.bo[source_buf].modified = true

  vim.api.nvim_buf_call(source_buf, function()
    vim.cmd 'silent! write!'
  end)

  -- 8. Open Files
  vim.cmd('edit ' .. full_header_path)
  vim.cmd('vsplit ' .. full_source_path)
  vim.cmd 'wincmd k'

  vim.notify(string.format('Created %s and %s', header_file, source_file), vim.log.levels.INFO)
end, {
  nargs = '?',
  complete = 'file',
  desc = 'Create C++ class',
})

-- c#
--
vim.api.nvim_create_user_command('NewClass', function(opts)
  local type_name = opts.args or vim.fn.input 'Class Name: '
  if type_name == '' then
    return
  end
end, {
  nargs = '?',
  complete = 'file',
  desc = 'Create C++ class',
})
