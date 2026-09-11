vim.filetype.add({
  pattern = {
    -- Matches any file ending in Build.props
    ['.*%.Build%.props'] = 'xml',
    ['.*%.Build%.targets'] = 'xml',
    ['.*%.nuget%.config'] = 'xml',
    ['.xaml'] = 'xml',
  },
})
