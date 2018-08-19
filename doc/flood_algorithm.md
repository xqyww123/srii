Algorithm SRII - Virtual Graph based Flooding
===

Hyperchain is so-called Consortium Blockchain. As the Consortium, we could accquire much more information about netowrk topology, where the case manual configure about Flooding server and area of the server will help much.

That is, I believe a successful Flooding algorithm should work not only automatically but also with human's configure.

Combining Virtual Graph algorithm used for SRII router, Flooding implementation could be as simple as just two virtual node:

``` crystal
virtual FloodingInChina
virtual FloodingOutChina

SlowNode.link FloodingInChina
# caution! just SlowNode -> Flooding **In** China
#          but no link back from FloodingInChina
FlodingOutChina.link SlowNode, ip: xxx
#          and  SlowNode <- Flooding **Out** China
#          but no link to FloodingOutChina

FastServer.link FloodingOutChina
FloodingInChina.link FastServer, ip: xxx
# just the reverse of SlowNode
```

All slow nodes consist a group, and also the fast, then all connection of the slow will be proxied by group of the fast. That is the Flooding. So as above, no any new algorithm required. It's just all existing Virtual Graph algorithm.

`FloodingInChina` also indicates the area of the Flooding, so locality could be considered manually and performance meets standards.

Some sugar could make code more beautiful:

``` crystal
flooding_group FloodingChina
SlowNode.proxy FloodingChina, ip: xxx
FastNode.flood FloodingChina, ip: xxx
```

And one more thing, if one still want directly connection for unicast (not broadcast), context dependent configure is a good tool, which separetes configure for unicast and broadcast.

``` crystal
# configure inherited by all context
Slow.link Slow2, ip: xxx

unicast do
# configure just for unicast
Slow.link Internet
Internet.link Slow, ip: xxx
end

broadcast do
# configure for broadcast
Slow.link 
end
```

