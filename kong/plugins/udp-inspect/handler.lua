-- If you're not sure your plugin is executing, uncomment the line below and restart Kong
-- then it will throw an error which indicates the plugin is being loaded at least.
-- assert(ngx.get_phase() == "timer", "The world is coming to an end!")
---------------------------------------------------------------------------------------------
-- In the code below, just remove the opening brackets; `[[` to enable a specific handler
--
-- The handlers are based on the OpenResty handlers, see the OpenResty docs for details
-- on when exactly they are invoked and what limitations each handler has.
---------------------------------------------------------------------------------------------
local plugin = {
    PRIORITY = 902, -- set the plugin priority, which determines plugin execution order
    VERSION = "0.1"
}

-- do initialization here, any module level code runs in the 'init_by_lua_block',
-- before worker processes are forked. So anything you add here will run once,
-- but be available in all workers.

-- handles more initialization, but AFTER the worker process has been forked/created.
-- It runs in the 'init_worker_by_lua_block'
function plugin:init_worker()
    kong.log.debug("saying hi from the 'init_worker' handler")
end -- ]]

function plugin:preread(a)
    local ip = kong.client.get_ip()
    local port = kong.client.get_port()
    kong.log.inspect('PREREAD ' .. ip .. ':' .. port)

    local sock = ngx.req.socket()
    local tmr = table.concat({
        string.char(0x60), string.char(0x9d), string.char(0xdd),
        string.char(0x61)
    })
    sock:send(tmr)
    return ngx.exit(429)
end -- ]]

-- return our plugin object
return plugin
