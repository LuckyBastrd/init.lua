-- Function to reload a module
function R(name)
    require("plenary.reload").reload_module(name)
end
