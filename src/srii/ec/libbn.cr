@[Link(ldflags: "`command -v pkg-config > /dev/null && pkg-config --libs --silence-errors libcrypto || printf %s '-lcrypto'`")]
lib LibCryptoBN
  BITS                           =   128
  BYTES                          =     8
  BITS2                          =    64
  BITS4                          =    32
  DEC_NUM                        =    19
  DEFAULT_BITS                   =  1280
  FLG_MALLOCED                   =     1
  FLG_STATIC_DATA                =     2
  FLG_CONSTTIME                  =     4
  FLG_FREE                       = 32768
  PRIME_CHECKS                   =     0
  BLINDING_NO_UPDATE             =     1
  BLINDING_NO_RECREATE           =     2
  F_BNRAND                       =   127
  F_BN_BLINDING_CONVERT_EX       =   100
  F_BN_BLINDING_CREATE_PARAM     =   128
  F_BN_BLINDING_INVERT_EX        =   101
  F_BN_BLINDING_NEW              =   102
  F_BN_BLINDING_UPDATE           =   103
  F_BN_BN2DEC                    =   104
  F_BN_BN2HEX                    =   105
  F_BN_CTX_GET                   =   116
  F_BN_CTX_NEW                   =   106
  F_BN_CTX_START                 =   129
  F_BN_DIV                       =   107
  F_BN_DIV_NO_BRANCH             =   138
  F_BN_DIV_RECP                  =   130
  F_BN_EXP                       =   123
  F_BN_EXPAND2                   =   108
  F_BN_EXPAND_INTERNAL           =   120
  F_BN_GF2M_MOD                  =   131
  F_BN_GF2M_MOD_EXP              =   132
  F_BN_GF2M_MOD_MUL              =   133
  F_BN_GF2M_MOD_SOLVE_QUAD       =   134
  F_BN_GF2M_MOD_SOLVE_QUAD_ARR   =   135
  F_BN_GF2M_MOD_SQR              =   136
  F_BN_GF2M_MOD_SQRT             =   137
  F_BN_LSHIFT                    =   145
  F_BN_MOD_EXP2_MONT             =   118
  F_BN_MOD_EXP_MONT              =   109
  F_BN_MOD_EXP_MONT_CONSTTIME    =   124
  F_BN_MOD_EXP_MONT_WORD         =   117
  F_BN_MOD_EXP_RECP              =   125
  F_BN_MOD_EXP_SIMPLE            =   126
  F_BN_MOD_INVERSE               =   110
  F_BN_MOD_INVERSE_NO_BRANCH     =   139
  F_BN_MOD_LSHIFT_QUICK          =   119
  F_BN_MOD_MUL_RECIPROCAL        =   111
  F_BN_MOD_SQRT                  =   121
  F_BN_MPI2BN                    =   112
  F_BN_NEW                       =   113
  F_BN_RAND                      =   114
  F_BN_RAND_RANGE                =   122
  F_BN_RSHIFT                    =   146
  F_BN_USUB                      =   115
  R_ARG2_LT_ARG3                 =   100
  R_BAD_RECIPROCAL               =   101
  R_BIGNUM_TOO_LONG              =   114
  R_BITS_TOO_SMALL               =   118
  R_CALLED_WITH_EVEN_MODULUS     =   102
  R_DIV_BY_ZERO                  =   103
  R_ENCODING_ERROR               =   104
  R_EXPAND_ON_STATIC_BIGNUM_DATA =   105
  R_INPUT_NOT_REDUCED            =   110
  R_INVALID_LENGTH               =   106
  R_INVALID_RANGE                =   115
  R_INVALID_SHIFT                =   119
  R_NOT_A_SQUARE                 =   111
  R_NOT_INITIALIZED              =   107
  R_NO_INVERSE                   =   108
  R_NO_SOLUTION                  =   116
  R_P_IS_NOT_PRIME               =   112
  R_TOO_MANY_ITERATIONS          =   113
  R_TOO_MANY_TEMPORARY_VARIABLES =   109
  fun gencb_call = BN_GENCB_call(cb : Gencb*, a : LibC::Int, b : LibC::Int) : LibC::Int

  struct BnGencbSt
    ver : LibC::UInt
    arg : Void*
    cb : BnGencbStCb
  end

  type Gencb = BnGencbSt

  union BnGencbStCb
    cb_1 : (LibC::Int, LibC::Int, Void* -> Void)
    cb_2 : (LibC::Int, LibC::Int, Gencb* -> LibC::Int)
  end

  fun value_one = BN_value_one : Bignum*

  struct BignumSt
    d : LibC::ULong*
    top : LibC::Int
    dmax : LibC::Int
    neg : LibC::Int
    flags : LibC::Int
  end

  type Bignum = BignumSt
  fun options = BN_options : LibC::Char*
  fun ctx_new = BN_CTX_new : Ctx
  type Ctx = Void*
  fun ctx_init = BN_CTX_init(c : Ctx)
  fun ctx_free = BN_CTX_free(c : Ctx)
  fun ctx_start = BN_CTX_start(ctx : Ctx)
  fun ctx_get = BN_CTX_get(ctx : Ctx) : Bignum*
  fun ctx_end = BN_CTX_end(ctx : Ctx)
  fun rand = BN_rand(rnd : Bignum*, bits : LibC::Int, top : LibC::Int, bottom : LibC::Int) : LibC::Int
  fun pseudo_rand = BN_pseudo_rand(rnd : Bignum*, bits : LibC::Int, top : LibC::Int, bottom : LibC::Int) : LibC::Int
  fun rand_range = BN_rand_range(rnd : Bignum*, range : Bignum*) : LibC::Int
  fun pseudo_rand_range = BN_pseudo_rand_range(rnd : Bignum*, range : Bignum*) : LibC::Int
  fun num_bits = BN_num_bits(a : Bignum*) : LibC::Int
  fun num_bits_word = BN_num_bits_word(x0 : LibC::ULong) : LibC::Int
  fun new = BN_new : Bignum*
  fun init = BN_init(x0 : Bignum*)
  fun clear_free = BN_clear_free(a : Bignum*)
  fun copy = BN_copy(a : Bignum*, b : Bignum*) : Bignum*
  fun swap = BN_swap(a : Bignum*, b : Bignum*)
  fun bin2bn = BN_bin2bn(s : UInt8*, len : LibC::Int, ret : Bignum*) : Bignum*
  fun bn2bin = BN_bn2bin(a : Bignum*, to : UInt8*) : LibC::Int
  fun mpi2bn = BN_mpi2bn(s : UInt8*, len : LibC::Int, ret : Bignum*) : Bignum*
  fun bn2mpi = BN_bn2mpi(a : Bignum*, to : UInt8*) : LibC::Int
  fun sub = BN_sub(r : Bignum*, a : Bignum*, b : Bignum*) : LibC::Int
  fun usub = BN_usub(r : Bignum*, a : Bignum*, b : Bignum*) : LibC::Int
  fun uadd = BN_uadd(r : Bignum*, a : Bignum*, b : Bignum*) : LibC::Int
  fun add = BN_add(r : Bignum*, a : Bignum*, b : Bignum*) : LibC::Int
  fun mul = BN_mul(r : Bignum*, a : Bignum*, b : Bignum*, ctx : Ctx) : LibC::Int
  fun sqr = BN_sqr(r : Bignum*, a : Bignum*, ctx : Ctx) : LibC::Int
  fun set_negative = BN_set_negative(b : Bignum*, n : LibC::Int)
  fun div = BN_div(dv : Bignum*, rem : Bignum*, m : Bignum*, d : Bignum*, ctx : Ctx) : LibC::Int
  fun nnmod = BN_nnmod(r : Bignum*, m : Bignum*, d : Bignum*, ctx : Ctx) : LibC::Int
  fun mod_add = BN_mod_add(r : Bignum*, a : Bignum*, b : Bignum*, m : Bignum*, ctx : Ctx) : LibC::Int
  fun mod_add_quick = BN_mod_add_quick(r : Bignum*, a : Bignum*, b : Bignum*, m : Bignum*) : LibC::Int
  fun mod_sub = BN_mod_sub(r : Bignum*, a : Bignum*, b : Bignum*, m : Bignum*, ctx : Ctx) : LibC::Int
  fun mod_sub_quick = BN_mod_sub_quick(r : Bignum*, a : Bignum*, b : Bignum*, m : Bignum*) : LibC::Int
  fun mod_mul = BN_mod_mul(r : Bignum*, a : Bignum*, b : Bignum*, m : Bignum*, ctx : Ctx) : LibC::Int
  fun mod_sqr = BN_mod_sqr(r : Bignum*, a : Bignum*, m : Bignum*, ctx : Ctx) : LibC::Int
  fun mod_lshift1 = BN_mod_lshift1(r : Bignum*, a : Bignum*, m : Bignum*, ctx : Ctx) : LibC::Int
  fun mod_lshift1_quick = BN_mod_lshift1_quick(r : Bignum*, a : Bignum*, m : Bignum*) : LibC::Int
  fun mod_lshift = BN_mod_lshift(r : Bignum*, a : Bignum*, n : LibC::Int, m : Bignum*, ctx : Ctx) : LibC::Int
  fun mod_lshift_quick = BN_mod_lshift_quick(r : Bignum*, a : Bignum*, n : LibC::Int, m : Bignum*) : LibC::Int
  fun mod_word = BN_mod_word(a : Bignum*, w : LibC::ULong) : LibC::ULong
  fun div_word = BN_div_word(a : Bignum*, w : LibC::ULong) : LibC::ULong
  fun mul_word = BN_mul_word(a : Bignum*, w : LibC::ULong) : LibC::Int
  fun add_word = BN_add_word(a : Bignum*, w : LibC::ULong) : LibC::Int
  fun sub_word = BN_sub_word(a : Bignum*, w : LibC::ULong) : LibC::Int
  fun set_word = BN_set_word(a : Bignum*, w : LibC::ULong) : LibC::Int
  fun get_word = BN_get_word(a : Bignum*) : LibC::ULong
  fun cmp = BN_cmp(a : Bignum*, b : Bignum*) : LibC::Int
  fun free = BN_free(a : Bignum*)
  fun is_bit_set = BN_is_bit_set(a : Bignum*, n : LibC::Int) : LibC::Int
  fun lshift = BN_lshift(r : Bignum*, a : Bignum*, n : LibC::Int) : LibC::Int
  fun lshift1 = BN_lshift1(r : Bignum*, a : Bignum*) : LibC::Int
  fun exp = BN_exp(r : Bignum*, a : Bignum*, p : Bignum*, ctx : Ctx) : LibC::Int
  fun mod_exp = BN_mod_exp(r : Bignum*, a : Bignum*, p : Bignum*, m : Bignum*, ctx : Ctx) : LibC::Int
  fun mod_exp_mont = BN_mod_exp_mont(r : Bignum*, a : Bignum*, p : Bignum*, m : Bignum*, ctx : Ctx, m_ctx : MontCtx*) : LibC::Int

  struct BnMontCtxSt
    ri : LibC::Int
    rr : Bignum
    n : Bignum
    ni : Bignum
    n0 : LibC::ULong[2]
    flags : LibC::Int
  end

  type MontCtx = BnMontCtxSt
  fun mod_exp_mont_consttime = BN_mod_exp_mont_consttime(rr : Bignum*, a : Bignum*, p : Bignum*, m : Bignum*, ctx : Ctx, in_mont : MontCtx*) : LibC::Int
  fun mod_exp_mont_word = BN_mod_exp_mont_word(r : Bignum*, a : LibC::ULong, p : Bignum*, m : Bignum*, ctx : Ctx, m_ctx : MontCtx*) : LibC::Int
  fun mod_exp2_mont = BN_mod_exp2_mont(r : Bignum*, a1 : Bignum*, p1 : Bignum*, a2 : Bignum*, p2 : Bignum*, m : Bignum*, ctx : Ctx, m_ctx : MontCtx*) : LibC::Int
  fun mod_exp_simple = BN_mod_exp_simple(r : Bignum*, a : Bignum*, p : Bignum*, m : Bignum*, ctx : Ctx) : LibC::Int
  fun mask_bits = BN_mask_bits(a : Bignum*, n : LibC::Int) : LibC::Int
  fun print_fp = BN_print_fp(fp : File*, a : Bignum*) : LibC::Int

  struct X_IoFile
    _flags : LibC::Int
    _io_read_ptr : LibC::Char*
    _io_read_end : LibC::Char*
    _io_read_base : LibC::Char*
    _io_write_base : LibC::Char*
    _io_write_ptr : LibC::Char*
    _io_write_end : LibC::Char*
    _io_buf_base : LibC::Char*
    _io_buf_end : LibC::Char*
    _io_save_base : LibC::Char*
    _io_backup_base : LibC::Char*
    _io_save_end : LibC::Char*
    _markers : X_IoMarker*
    _chain : X_IoFile*
    _fileno : LibC::Int
    _flags2 : LibC::Int
    _old_offset : X__OffT
    _cur_column : LibC::UShort
    _vtable_offset : LibC::Char
    _shortbuf : LibC::Char[1]
    _lock : X_IoLockT*
    _offset : X__Off64T
    __pad1 : Void*
    __pad2 : Void*
    __pad3 : Void*
    __pad4 : Void*
    __pad5 : LibC::SizeT
    _mode : LibC::Int
    _unused2 : LibC::Char[20]
  end

  type File = X_IoFile

  struct X_IoMarker
    _next : X_IoMarker*
    _sbuf : X_IoFile*
    _pos : LibC::Int
  end

  alias X__OffT = LibC::Long
  alias X_IoLockT = Void
  alias X__Off64T = LibC::Long
  fun print = BN_print(fp : Void*, a : Bignum*) : LibC::Int
  fun reciprocal = BN_reciprocal(r : Bignum*, m : Bignum*, len : LibC::Int, ctx : Ctx) : LibC::Int
  fun rshift = BN_rshift(r : Bignum*, a : Bignum*, n : LibC::Int) : LibC::Int
  fun rshift1 = BN_rshift1(r : Bignum*, a : Bignum*) : LibC::Int
  fun clear = BN_clear(a : Bignum*)
  fun dup = BN_dup(a : Bignum*) : Bignum*
  fun ucmp = BN_ucmp(a : Bignum*, b : Bignum*) : LibC::Int
  fun set_bit = BN_set_bit(a : Bignum*, n : LibC::Int) : LibC::Int
  fun clear_bit = BN_clear_bit(a : Bignum*, n : LibC::Int) : LibC::Int
  fun bn2hex = BN_bn2hex(a : Bignum*) : LibC::Char*
  fun bn2dec = BN_bn2dec(a : Bignum*) : LibC::Char*
  fun hex2bn = BN_hex2bn(a : Bignum**, str : LibC::Char*) : LibC::Int
  fun dec2bn = BN_dec2bn(a : Bignum**, str : LibC::Char*) : LibC::Int
  fun asc2bn = BN_asc2bn(a : Bignum**, str : LibC::Char*) : LibC::Int
  fun gcd = BN_gcd(r : Bignum*, a : Bignum*, b : Bignum*, ctx : Ctx) : LibC::Int
  fun kronecker = BN_kronecker(a : Bignum*, b : Bignum*, ctx : Ctx) : LibC::Int
  fun mod_inverse = BN_mod_inverse(ret : Bignum*, a : Bignum*, n : Bignum*, ctx : Ctx) : Bignum*
  fun mod_sqrt = BN_mod_sqrt(ret : Bignum*, a : Bignum*, n : Bignum*, ctx : Ctx) : Bignum*
  fun consttime_swap = BN_consttime_swap(swap : LibC::ULong, a : Bignum*, b : Bignum*, nwords : LibC::Int)
  fun generate_prime = BN_generate_prime(ret : Bignum*, bits : LibC::Int, safe : LibC::Int, add : Bignum*, rem : Bignum*, callback : (LibC::Int, LibC::Int, Void* -> Void), cb_arg : Void*) : Bignum*
  fun is_prime = BN_is_prime(p : Bignum*, nchecks : LibC::Int, callback : (LibC::Int, LibC::Int, Void* -> Void), ctx : Ctx, cb_arg : Void*) : LibC::Int
  fun is_prime_fasttest = BN_is_prime_fasttest(p : Bignum*, nchecks : LibC::Int, callback : (LibC::Int, LibC::Int, Void* -> Void), ctx : Ctx, cb_arg : Void*, do_trial_division : LibC::Int) : LibC::Int
  fun generate_prime_ex = BN_generate_prime_ex(ret : Bignum*, bits : LibC::Int, safe : LibC::Int, add : Bignum*, rem : Bignum*, cb : Gencb*) : LibC::Int
  fun is_prime_ex = BN_is_prime_ex(p : Bignum*, nchecks : LibC::Int, ctx : Ctx, cb : Gencb*) : LibC::Int
  fun is_prime_fasttest_ex = BN_is_prime_fasttest_ex(p : Bignum*, nchecks : LibC::Int, ctx : Ctx, do_trial_division : LibC::Int, cb : Gencb*) : LibC::Int
  fun x931_generate_xpq = BN_X931_generate_Xpq(xp : Bignum*, xq : Bignum*, nbits : LibC::Int, ctx : Ctx) : LibC::Int
  fun x931_derive_prime_ex = BN_X931_derive_prime_ex(p : Bignum*, p1 : Bignum*, p2 : Bignum*, xp : Bignum*, xp1 : Bignum*, xp2 : Bignum*, e : Bignum*, ctx : Ctx, cb : Gencb*) : LibC::Int
  fun x931_generate_prime_ex = BN_X931_generate_prime_ex(p : Bignum*, p1 : Bignum*, p2 : Bignum*, xp1 : Bignum*, xp2 : Bignum*, xp : Bignum*, e : Bignum*, ctx : Ctx, cb : Gencb*) : LibC::Int
  fun mont_ctx_new = BN_MONT_CTX_new : MontCtx*
  fun mont_ctx_init = BN_MONT_CTX_init(ctx : MontCtx*)
  fun mod_mul_montgomery = BN_mod_mul_montgomery(r : Bignum*, a : Bignum*, b : Bignum*, mont : MontCtx*, ctx : Ctx) : LibC::Int
  fun from_montgomery = BN_from_montgomery(r : Bignum*, a : Bignum*, mont : MontCtx*, ctx : Ctx) : LibC::Int
  fun mont_ctx_free = BN_MONT_CTX_free(mont : MontCtx*)
  fun mont_ctx_set = BN_MONT_CTX_set(mont : MontCtx*, mod : Bignum*, ctx : Ctx) : LibC::Int
  fun mont_ctx_copy = BN_MONT_CTX_copy(to : MontCtx*, from : MontCtx*) : MontCtx*
  fun mont_ctx_set_locked = BN_MONT_CTX_set_locked(pmont : MontCtx**, lock : LibC::Int, mod : Bignum*, ctx : Ctx) : MontCtx*
  fun blinding_new = BN_BLINDING_new(a : Bignum*, ai : Bignum*, mod : Bignum*) : Blinding
  type Blinding = Void*
  fun blinding_free = BN_BLINDING_free(b : Blinding)
  fun blinding_update = BN_BLINDING_update(b : Blinding, ctx : Ctx) : LibC::Int
  fun blinding_convert = BN_BLINDING_convert(n : Bignum*, b : Blinding, ctx : Ctx) : LibC::Int
  fun blinding_invert = BN_BLINDING_invert(n : Bignum*, b : Blinding, ctx : Ctx) : LibC::Int
  fun blinding_convert_ex = BN_BLINDING_convert_ex(n : Bignum*, r : Bignum*, b : Blinding, x3 : Ctx) : LibC::Int
  fun blinding_invert_ex = BN_BLINDING_invert_ex(n : Bignum*, r : Bignum*, b : Blinding, x3 : Ctx) : LibC::Int
  fun blinding_get_thread_id = BN_BLINDING_get_thread_id(x0 : Blinding) : LibC::ULong
  fun blinding_set_thread_id = BN_BLINDING_set_thread_id(x0 : Blinding, x1 : LibC::ULong)
  fun blinding_thread_id = BN_BLINDING_thread_id(x0 : Blinding) : CryptoThreadid*

  struct CryptoThreadidSt
    ptr : Void*
    val : LibC::ULong
  end

  type CryptoThreadid = CryptoThreadidSt
  fun blinding_get_flags = BN_BLINDING_get_flags(x0 : Blinding) : LibC::ULong
  fun blinding_set_flags = BN_BLINDING_set_flags(x0 : Blinding, x1 : LibC::ULong)
  fun blinding_create_param = BN_BLINDING_create_param(b : Blinding, e : Bignum*, m : Bignum*, ctx : Ctx, bn_mod_exp : (Bignum*, Bignum*, Bignum*, Bignum*, Ctx, MontCtx* -> LibC::Int), m_ctx : MontCtx*) : Blinding
  fun set_params = BN_set_params(mul : LibC::Int, high : LibC::Int, low : LibC::Int, mont : LibC::Int)
  fun get_params = BN_get_params(which : LibC::Int) : LibC::Int
  fun recp_ctx_init = BN_RECP_CTX_init(recp : RecpCtx*)

  struct BnRecpCtxSt
    n : Bignum
    nr : Bignum
    num_bits : LibC::Int
    shift : LibC::Int
    flags : LibC::Int
  end

  type RecpCtx = BnRecpCtxSt
  fun recp_ctx_new = BN_RECP_CTX_new : RecpCtx*
  fun recp_ctx_free = BN_RECP_CTX_free(recp : RecpCtx*)
  fun recp_ctx_set = BN_RECP_CTX_set(recp : RecpCtx*, rdiv : Bignum*, ctx : Ctx) : LibC::Int
  fun mod_mul_reciprocal = BN_mod_mul_reciprocal(r : Bignum*, x : Bignum*, y : Bignum*, recp : RecpCtx*, ctx : Ctx) : LibC::Int
  fun mod_exp_recp = BN_mod_exp_recp(r : Bignum*, a : Bignum*, p : Bignum*, m : Bignum*, ctx : Ctx) : LibC::Int
  fun div_recp = BN_div_recp(dv : Bignum*, rem : Bignum*, m : Bignum*, recp : RecpCtx*, ctx : Ctx) : LibC::Int
  fun nist_mod_192 = BN_nist_mod_192(r : Bignum*, a : Bignum*, p : Bignum*, ctx : Ctx) : LibC::Int
  fun nist_mod_224 = BN_nist_mod_224(r : Bignum*, a : Bignum*, p : Bignum*, ctx : Ctx) : LibC::Int
  fun nist_mod_256 = BN_nist_mod_256(r : Bignum*, a : Bignum*, p : Bignum*, ctx : Ctx) : LibC::Int
  fun nist_mod_384 = BN_nist_mod_384(r : Bignum*, a : Bignum*, p : Bignum*, ctx : Ctx) : LibC::Int
  fun nist_mod_521 = BN_nist_mod_521(r : Bignum*, a : Bignum*, p : Bignum*, ctx : Ctx) : LibC::Int
  fun get0_nist_prime_192 = BN_get0_nist_prime_192 : Bignum*
  fun get0_nist_prime_224 = BN_get0_nist_prime_224 : Bignum*
  fun get0_nist_prime_256 = BN_get0_nist_prime_256 : Bignum*
  fun get0_nist_prime_384 = BN_get0_nist_prime_384 : Bignum*
  fun get0_nist_prime_521 = BN_get0_nist_prime_521 : Bignum*
  fun bntest_rand = BN_bntest_rand(rnd : Bignum*, bits : LibC::Int, top : LibC::Int, bottom : LibC::Int) : LibC::Int
end
