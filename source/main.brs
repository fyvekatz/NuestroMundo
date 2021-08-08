sub Main()
    screen = CreateObject("roSGScreen")
    m.port = CreateObject("roMessagePort")
    screen.setMessagePort(m.port)

    ' Globals
    m.global = screen.getGlobalNode()

    'NONE = 0
    'INFO = 1
    'WARN = 2
    'VERBOSE = 3
    'DEBUG = 4
    'm.global.addfield("logLevel", "integer", false)
    'm.global.logLevel = 4
    
    scene = screen.CreateScene("HomeScene")

    'm.global.logLevel >= 3 and print "Entering main application"

    screen.show()
    
    while(true)
        msg = wait(0, m.port)
        msgType = type(msg)
        if msgType = "roSGScreenEvent"
            if msg.isScreenClosed() then return
        end if
    end while
end sub