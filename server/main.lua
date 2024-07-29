lib.versionCheck('vanishdevs/vanish_basics')

lib.callback.register('vanishdev:server:getNumIndices', function()
    return GetNumPlayerIndices()
end)