local M = {}

M.move = function()
    M.quickfix()
    vim.cmd.copen()
    vim.cmd('silent! cnext')
end

M.quickfix = function()
    local buffers = vim.api.nvim_list_bufs()
    local qf_list = {}
    for _, buf in ipairs(buffers) do
        if vim.api.nvim_buf_get_option(buf, 'buflisted') then
            local name = vim.api.nvim_buf_get_name(buf)
            if name ~= '' then -- Ignore unnamed buffers
                local pos = vim.api.nvim_buf_get_mark(buf, '"')
                name = vim.fn.fnamemodify(name, ':.')
                table.insert(qf_list, { filename = name, lnum = pos[1], col = pos[2], text = name })
            end
        end
    end
    vim.fn.setqflist({}, ' ', {
        title = 'Buffers',
        items = qf_list,
    })
end

return M
