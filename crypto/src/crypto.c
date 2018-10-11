#include <relic_cp.h>
#include <relic_ep.h>
#include <relic_bn.h>
#include <relic_err.h>
#include <stdlib.h>

size_t size_ep = sizeof(ep_st);
size_t size_g2 = sizeof(g2_st);
size_t size_bn = sizeof(bn_st);

ep_st* make_ep() {
    ep_t ret;
    ep_new(ret);
    return ret;
}
g2_st* make_g2() {
    g2_t ret;
    g2_new(ret);
    return ret;
}
bn_st* make_bn() {
    bn_t ret;
    bn_new(ret);
    return ret;
}

