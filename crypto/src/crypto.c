#include <relic_cp.h>
#include <relic_ep.h>
#include <relic_bn.h>
#include <relic_err.h>
#include <stdlib.h>

size_t size_sig = sizeof(ep_st);
size_t size_pub = sizeof(g2_st);
size_t size_pri = sizeof(bn_st);

ep_st* make_ep() {
    ep_t ret;
    ep_new(ret);
    return ret;
}
ep2_st* make_ep2() {
    ep2_t ret;
    ep2_new(ret);
    return ret;
}
bn_st* make_bn() {
    bn_t ret;
    bn_new(ret);
    return ret;
}
bn_st* make_bn1(int num) {
    bn_t ret = make_bn();
    bn_set_dig(ret, num);
    return ret;
}

