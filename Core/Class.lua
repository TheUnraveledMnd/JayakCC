local function newIndexFunction(tbl, name, value)
    if name == "new" and type(value) == "function" then
        local constructor = value
        rawset(tbl, name, function(self, ...)
            local object = self
            if object.__class == nil then
                object = {}
                object.__class = self
                object.__id = string.sub(tostring(object), 8)

                self.__index = self
                setmetatable(object, self)
            end

            constructor(object, unpack(arg))-- Lua 5.0
            -- constructor(object, ...)-- Lua 5.1+
            return object
        end)
    else
        rawset(tbl, name, value)
    end
end

local function toStringFunction(tbl)
    return tbl:toString()
end

Class = {__name = "Class", __state = {}}
setmetatable(Class, {__newindex = newIndexFunction, __tostring = toStringFunction})

function Class:extend(class)
    class = class or {}

    self.__index = self
    self.__newindex = newIndexFunction
    self.__tostring = toStringFunction

    local constructor = nil
    if class.new ~= nil then
        constructor = class.new
        class.new = nil
    end

    setmetatable(class, self)

    if constructor ~= nil then
        class.new = constructor
    end

    class.__super = self

    return class
end

function Class:new()
end

function Class:getSuperClass()
    return self.__super
end

function Class:getClass()
    return self.__class
end

function Class:toString()
    return string.format("[%s] %s", self.__class.__name, self.__id)
end

function Class:isInstance(value)
    return value ~= nil and type(value) == "table" and getmetatable(value) == self
end
