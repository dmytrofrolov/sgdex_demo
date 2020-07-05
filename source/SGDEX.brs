' SGDEX.brs

sub RunUserInterface(args)
    if args.RunTests = "true" and type(TestRunner) = "Function" then
        Runner = TestRunner()

        Runner.SetFunctions([
            TestSuite__API_Main
        ])

        Runner.Logger.SetVerbosity(3)
        Runner.Logger.SetEcho(false)
        Runner.Logger.SetJUnit(false)
        Runner.SetFailFast(true)
        
        Runner.Run()
        return
    end if

    m.args = args
    if Type(GetSceneName) <> "<uninitialized>" AND GetSceneName <> invalid AND GetInterface(GetSceneName, "ifFunction") <> invalid then
        StartSGDEXChannel(GetSceneName(), args)
    else
        ? "Error: SGDEX, please implement 'GetSceneName() as String' function and return name of your scene that is extended from BaseScene"
    end if
end sub

sub StartSGDEXChannel(componentName, args)
    screen = CreateObject("roSGScreen")
    m.port = CreateObject("roMessagePort")
    screen.SetMessagePort(m.port)
    scene = screen.CreateScene(componentName)
    screen.Show()
    scene.ObserveField("exitChannel", m.port)
    scene.launch_args = args
    
    ' create roInput context for handling roInputEvent messages
    input = CreateObject("roInput")
    input.setMessagePort(m.port)
    
    while (true)
        msg = Wait(0, m.port)
        msgType = Type(msg)
        if msgType = "roSGScreenEvent"
            if msg.IsScreenClosed() then return
        else if msgType = "roSGNodeEvent"
            field = msg.getField()
            data = msg.getData()
            if field = "exitChannel" and data = true
                END
            end if
        else if msgType = "roInputEvent"
            ' roInputEvent deep linking, pass arguments to the scene
            scene.input_args = msg.getInfo()
        end if
    end while
end sub
