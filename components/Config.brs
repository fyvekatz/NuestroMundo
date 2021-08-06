
' ********** Copyright 2016 Roku Corp.  All Rights Reserved. **********

Function loadConfig() as Object
    arr = [
'##### Format for inputting stream info #####
'## For each channel, enclose in brackets ## 
'{
'   Title: Channel Title
'   streamFormat: Channel stream type (ex. "hls", "ism", "mp4", etc..)
'   Logo: Channel Logo (ex. "http://Roku.com/Roku.jpg)
'   Stream: URL to stream (ex. http://hls.Roku.com/talks/xxx.m3u8)
'}
    
' Says not available "en tu pais"
'{
'    Title: "Repretel Canal 2
'    streamFormat: "hls"
'    Logo: ""
'    Stream: ""
'}
' Says not available "en tu pais"
'{
'    Title: "Repretel Canal 4
'    streamFormat: "hls"
'    Logo: ""
'    Stream: ""
'}
'Says not available "en tu pais"
'{
'    Title: "Repretel Canal 6
'    streamFormat: "hls"
'    Logo: ""
'    Stream: ""
'}

{
    Title: "Teletica Canal 7"
    streamFormat: "hls"
    Logo: "https://pbs.twimg.com/profile_images/1346206385013403649/gJhI7QoL.jpg"
    Stream: "https://www.dailymotion.com/cdn/live/video/x29e3wg.m3u8?sec=RRaQWohHhS0MzAc4pW5WUBzv-k-ummikSSlqOm8v4UNS2BPZa2uwFSdHbaut7vNg0eBbxpk7jNivBIHbEC2Myw"
}
{
    Title: "Teledario Canal 8"
    streamFormat: "hls"
    Logo: "https://vignette.wikia.nocookie.net/logopedia/images/5/5a/Multimedios_Televisi%C3%B3n_2015.png/revision/latest?cb=20150818212223"
    Stream: "https://mdstrm.com/live-stream-playlist/5a7b1e63a8da282c34d65445.m3u8"
}
' Says not available "en tu pais"
'{
'    Title: "Repretel Canal 11
'    streamFormat: "hls"
'    Logo: "https://upload.wikimedia.org/wikipedia/commons/8/8d/Repretel.png"
'    Stream: ""
'}
{
    Title: "Sinart Canal 13"
    streamFormat: "hls"
    Logo: "https://www.elmundo.cr/wp-content/uploads/2017/06/sinart-1024x676.jpg"
    Stream: "https://www.dailymotion.com/cdn/live/video/x7vh8g3.m3u8?sec=CuMr-u1XeSxJYScbAhGkYsmT3XVSAWwfkaNA3SIZytjlWi2XjSxnUKFyyEX-SKiKOlEb1EuJFqtUDrsAYgO-kA"
}
{
    Title: "tvsur Canal 14"
    streamFormat: "hls"
    Logo: "https://pbs.twimg.com/profile_images/1314328513349144577/7dTHR_gg_400x400.jpg"
    Stream: "https://5bf8041cb3fed.streamlock.net:443/TVSURCANAL14/TVSURCANAL14/playlist.m3u8"
}
{
    Title: "Quince UCR Canal 15"
    streamFormat: "hls"
    Logo: "https://www.ucr.ac.cr/medios/imagenes/2021/607466deea50560713b52a749blogocanal15.jpg"
    Stream: "http://163.178.170.127:1935/quinceucr/live.stream_720p/chunklist_w1053428288.m3u8"
}
{
    Title: "TV Enlace"
    streamFormat: "hls"
    Logo: "https://live-tv-channels.org/pt-data/uploads/logo/cr-enlace-tv-9721.jpg"
    Stream: "https://1-349-11554-1.b.cdn13.com/LiveHTTPOrigin/live/playlist.m3u8"
}
{
    Title: "TV Uno Canal 27"
    streamFormat: "hls"
    Logo: "https://serenotv.com/wp-content/uploads/2020/10/Canal-27-teleuno-en-vivo.jpg"
    Stream: "https://5d16127744872.streamlock.net/TVUNO/TVUNO/playlist.m3u8"
}
{
    Title: "VM latino Canal 29"
    streamFormat: "hls"
    Logo: "https://fastly.4sqi.net/img/general/558x200/28539980_1raUHzoeX2jhhajpn0lWQz8Dh59LbRRXnzQQmckj_f4.jpg"
    Stream: "https://59ef525c24caa.streamlock.net/vmtv/vmlatino/chunklist_w349784564.m3u8"
}
' Not streaming link
'{
'    Title: "Extra TV 42
'    streamFormat: "hls"
'    Logo: "https://live-tv-channels.org/pt-data/uploads/logo/cr-extra-tv-42.jpg"
'    Stream: ""
'}
{
    Title: "Cristovision"
    streamFormat: "hls"
    Logo: "https://live-tv-channels.org/pt-data/uploads/logo/co-cristovision-6748.jpg"
    Stream: "https://liveingesta118.cdnmedia.tv/cristovisionlive/smil:dvrlive.smil/chunklist_b1500000_DVR.m3u8"
}
{
    Title: "Esperanza TV"
    streamFormat: "hls"
    Logo: "https://i.pinimg.com/280x280_RS/31/22/2e/31222efd9118d951fcde8dd511e83f7f.jpg"
    Stream: "https://5eac7b031d945.streamlock.net/WEB/WEB_source/playlist.m3u8"
}
{
    Title: "Telefides"
    streamFormat: "hls"
    Logo: "https://www.nacion.com/resizer/XJla6D6d49cgJJwV0j8YdImmaTs=/600x400/center/middle/filters:quality(100)/cloudfront-us-east-1.images.arcpublishing.com/gruponacion/HAVJDUUUWNENJKFULYLAYQACYM.jpg"
    Stream: "http://190.0.226.17:1935/Telefides/livestream/playlist.m3u8"
}
    
    
    
'##### Make sure all Channel content is above this line #####    
    ] 
    return arr
End Function
