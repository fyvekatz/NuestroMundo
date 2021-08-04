' ********** Copyright 2018 Roku Corp.  All Rights Reserved. ********** 
'
' We will initialize the TextEditBox example by centering the example.
sub init()
    m.textEditBox = m.top.findNode("exampleTextEditBox")

    examplerect = m.top.boundingRect()
    centerx = (1280 - examplerect.width) / 2
    centery = (720 - examplerect.height) / 2
    m.top.translation = [ centerx, centery ]
end sub