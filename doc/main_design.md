SRII Main Design
===

SRII 分为多层，主体使用 Crystal 语言设计

### Why Crystal ?

Because I love it.

快速开发，稳健与高鲁棒性，高性能。

Ruby 级的开发效率。
超过 go 的鲁棒性。
C 的高性能，甚至可以比 C++ 更快。

Ruby 4年经验，Crystal 活跃在编译器开发者社区，有什么理由不用 Crystal ?

### How to combine with Crystal?

Protobuf on the pipe, message as the request, exception as the message, and response? No, we don't really demand response, but a message with id is a good idea.

#### Interface

Managed by directory, each Unix socket responds one API, and each call is a new connection to the socket. Protobuf serialized request is writed into the connection, and also the respon.

## Architecture

See architecture.md for more detail.

整个 SRII 分为4层：
- interface layer
    与上层 hyperchain 交互
- transmission layer
    将传输层分离，这样可以暂时不管 OKDP / TCP / QUIC 进行主体的开发，
    可以先使用 TCP 构造可用版本，再考虑 QUIC / OKDP 来提升性能。
- router layer
    主管 router graph 与路由更新。
- router configure layer
    主管从用户 DSL 读取路由配置并通知 router layer update.

### Implementation

- interface layer:
    Protobuf + UNIX socket,
    Single thread and event loop.
- transmission layer:
    Package based stable transmission.
    Transmission could be out of order but should provide a mechanize for first package as the head.
- router layer:
    See architecture.md
- router configure layer
    Basically, SRII can only export an interface the same as a UNIX socket to accept compiled router configure but implement DSL and parse user's script directly because Crystal is a compiled language and no runtime code generate is supported yet.
    So the DSL is basically implemented by Ruby, interconnected via UNIX socket and yet another Protubuf.
