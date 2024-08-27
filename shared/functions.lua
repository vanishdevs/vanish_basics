-- @param debugPrint (string, number, table, etc) The message to print.
function Debug(debugPrint)
    local getSettings = lib.load('shared/sh_main')
    if not getSettings.Debug then return end
    
    print('[DEBUG]: ' ..  debugPrint)
end

-- @param msg (string) The necessary message that will be displayed in the notification
-- @param source (number) The necessary source if you are sending a notification from the server
function ShowNotification(msg, source) 
    return source and lib.notify(source, {description = msg, position = 'top-right', type = 'inform'}) or lib.notify({description = msg, position = 'top-right', type = 'inform'})
end