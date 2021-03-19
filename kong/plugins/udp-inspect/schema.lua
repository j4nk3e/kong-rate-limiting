local typedefs = require "kong.db.schema.typedefs"

-- Grab pluginname from module name
local plugin_name = ({...})[1]:match("^kong%.plugins%.([^%.]+)")

local schema = {
    name = plugin_name,
    fields = {
        {consumer = typedefs.no_consumer}, -- this plugin cannot be configured on a consumer (typical for auth plugins)
        {protocols = typedefs.protocols {default = {"udp"}}}, {
            config = {
                type = "record",
                fields = {
                    {
                        ttl = {
                            type = "integer",
                            default = 600,
                            required = true,
                            gt = 0
                        }
                    }
                },
                entity_checks = {}
            }
        }
    }
}

return schema
