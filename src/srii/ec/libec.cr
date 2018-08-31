@[Link(ldflags: "`command -v pkg-config > /dev/null && pkg-config --libs --silence-errors libcrypto || printf %s '-lcrypto'`")]
lib LibCryptoEC
  enum Curves
    Scep112R1 = 704
    Scep112R2 = 705
    Scep128R1 = 706
    Scep128R2 = 707
    Scep160K1 = 708
    Scep160R1 = 709
    Scep160R2 = 710
    Scep192K1 = 711
    Scep224K1 = 712
    Scep224R1 = 713
    Scep256K1 = 714
    Scep384R1 = 715
    Scep521R1 = 716
    Scet113R1 = 717
    Scet113R2 = 718
    Scet131R1 = 719
    Scet131R2 = 720
    Scet163K1 = 721
    Scet163R1 = 722
    Scet163R2 = 723
    Scet193R1 = 724
    Scet193R2 = 725
    Scet233K1 = 726
    Scet233R1 = 727
    Scet239K1 = 728
    Scet283K1 = 729
    Scet283R1 = 730
    Scet409K1 = 731
    Scet409R1 = 732
    Scet571K1 = 733
    Scet571R1 = 734
  end
  PKEY_NO_PARAMETERS                               =   1
  PKEY_NO_PUBKEY                                   =   2
  FLAG_NON_FIPS_ALLOW                              =   1
  FLAG_FIPS_CHECKED                                =   2
  F_BN_TO_FELEM                                    = 224
  F_COMPUTE_WNAF                                   = 143
  F_D2I_ECPARAMETERS                               = 144
  F_D2I_ECPKPARAMETERS                             = 145
  F_D2I_ECPRIVATEKEY                               = 146
  F_DO_EC_KEY_PRINT                                = 221
  F_ECDH_CMS_DECRYPT                               = 238
  F_ECDH_CMS_SET_SHARED_INFO                       = 239
  F_ECKEY_PARAM2TYPE                               = 223
  F_ECKEY_PARAM_DECODE                             = 212
  F_ECKEY_PRIV_DECODE                              = 213
  F_ECKEY_PRIV_ENCODE                              = 214
  F_ECKEY_PUB_DECODE                               = 215
  F_ECKEY_PUB_ENCODE                               = 216
  F_ECKEY_TYPE2PARAM                               = 220
  F_ECPARAMETERS_PRINT                             = 147
  F_ECPARAMETERS_PRINT_FP                          = 148
  F_ECPKPARAMETERS_PRINT                           = 149
  F_ECPKPARAMETERS_PRINT_FP                        = 150
  F_ECP_NISTZ256_GET_AFFINE                        = 240
  F_ECP_NISTZ256_MULT_PRECOMPUTE                   = 243
  F_ECP_NISTZ256_POINTS_MUL                        = 241
  F_ECP_NISTZ256_PRE_COMP_NEW                      = 244
  F_ECP_NISTZ256_SET_WORDS                         = 245
  F_ECP_NISTZ256_WINDOWED_MUL                      = 242
  F_ECP_NIST_MOD_192                               = 203
  F_ECP_NIST_MOD_224                               = 204
  F_ECP_NIST_MOD_256                               = 205
  F_ECP_NIST_MOD_521                               = 206
  F_EC_ASN1_GROUP2CURVE                            = 153
  F_EC_ASN1_GROUP2FIELDID                          = 154
  F_EC_ASN1_GROUP2PARAMETERS                       = 155
  F_EC_ASN1_GROUP2PKPARAMETERS                     = 156
  F_EC_ASN1_PARAMETERS2GROUP                       = 157
  F_EC_ASN1_PKPARAMETERS2GROUP                     = 158
  F_EC_EX_DATA_SET_DATA                            = 211
  F_EC_GF2M_MONTGOMERY_POINT_MULTIPLY              = 208
  F_EC_GF2M_SIMPLE_GROUP_CHECK_DISCRIMINANT        = 159
  F_EC_GF2M_SIMPLE_GROUP_SET_CURVE                 = 195
  F_EC_GF2M_SIMPLE_OCT2POINT                       = 160
  F_EC_GF2M_SIMPLE_POINT2OCT                       = 161
  F_EC_GF2M_SIMPLE_POINT_GET_AFFINE_COORDINATES    = 162
  F_EC_GF2M_SIMPLE_POINT_SET_AFFINE_COORDINATES    = 163
  F_EC_GF2M_SIMPLE_SET_COMPRESSED_COORDINATES      = 164
  F_EC_GFP_MONT_FIELD_DECODE                       = 133
  F_EC_GFP_MONT_FIELD_ENCODE                       = 134
  F_EC_GFP_MONT_FIELD_MUL                          = 131
  F_EC_GFP_MONT_FIELD_SET_TO_ONE                   = 209
  F_EC_GFP_MONT_FIELD_SQR                          = 132
  F_EC_GFP_MONT_GROUP_SET_CURVE                    = 189
  F_EC_GFP_MONT_GROUP_SET_CURVE_GFP                = 135
  F_EC_GFP_NISTP224_GROUP_SET_CURVE                = 225
  F_EC_GFP_NISTP224_POINTS_MUL                     = 228
  F_EC_GFP_NISTP224_POINT_GET_AFFINE_COORDINATES   = 226
  F_EC_GFP_NISTP256_GROUP_SET_CURVE                = 230
  F_EC_GFP_NISTP256_POINTS_MUL                     = 231
  F_EC_GFP_NISTP256_POINT_GET_AFFINE_COORDINATES   = 232
  F_EC_GFP_NISTP521_GROUP_SET_CURVE                = 233
  F_EC_GFP_NISTP521_POINTS_MUL                     = 234
  F_EC_GFP_NISTP521_POINT_GET_AFFINE_COORDINATES   = 235
  F_EC_GFP_NIST_FIELD_MUL                          = 200
  F_EC_GFP_NIST_FIELD_SQR                          = 201
  F_EC_GFP_NIST_GROUP_SET_CURVE                    = 202
  F_EC_GFP_SIMPLE_GROUP_CHECK_DISCRIMINANT         = 165
  F_EC_GFP_SIMPLE_GROUP_SET_CURVE                  = 166
  F_EC_GFP_SIMPLE_GROUP_SET_CURVE_GFP              = 100
  F_EC_GFP_SIMPLE_GROUP_SET_GENERATOR              = 101
  F_EC_GFP_SIMPLE_MAKE_AFFINE                      = 102
  F_EC_GFP_SIMPLE_OCT2POINT                        = 103
  F_EC_GFP_SIMPLE_POINT2OCT                        = 104
  F_EC_GFP_SIMPLE_POINTS_MAKE_AFFINE               = 137
  F_EC_GFP_SIMPLE_POINT_GET_AFFINE_COORDINATES     = 167
  F_EC_GFP_SIMPLE_POINT_GET_AFFINE_COORDINATES_GFP = 105
  F_EC_GFP_SIMPLE_POINT_SET_AFFINE_COORDINATES     = 168
  F_EC_GFP_SIMPLE_POINT_SET_AFFINE_COORDINATES_GFP = 128
  F_EC_GFP_SIMPLE_SET_COMPRESSED_COORDINATES       = 169
  F_EC_GFP_SIMPLE_SET_COMPRESSED_COORDINATES_GFP   = 129
  F_EC_GROUP_CHECK                                 = 170
  F_EC_GROUP_CHECK_DISCRIMINANT                    = 171
  F_EC_GROUP_COPY                                  = 106
  F_EC_GROUP_GET0_GENERATOR                        = 139
  F_EC_GROUP_GET_COFACTOR                          = 140
  F_EC_GROUP_GET_CURVE_GF2M                        = 172
  F_EC_GROUP_GET_CURVE_GFP                         = 130
  F_EC_GROUP_GET_DEGREE                            = 173
  F_EC_GROUP_GET_ORDER                             = 141
  F_EC_GROUP_GET_PENTANOMIAL_BASIS                 = 193
  F_EC_GROUP_GET_TRINOMIAL_BASIS                   = 194
  F_EC_GROUP_NEW                                   = 108
  F_EC_GROUP_NEW_BY_CURVE_NAME                     = 174
  F_EC_GROUP_NEW_FROM_DATA                         = 175
  F_EC_GROUP_PRECOMPUTE_MULT                       = 142
  F_EC_GROUP_SET_CURVE_GF2M                        = 176
  F_EC_GROUP_SET_CURVE_GFP                         = 109
  F_EC_GROUP_SET_EXTRA_DATA                        = 110
  F_EC_GROUP_SET_GENERATOR                         = 111
  F_EC_KEY_CHECK_KEY                               = 177
  F_EC_KEY_COPY                                    = 178
  F_EC_KEY_GENERATE_KEY                            = 179
  F_EC_KEY_NEW                                     = 182
  F_EC_KEY_PRINT                                   = 180
  F_EC_KEY_PRINT_FP                                = 181
  F_EC_KEY_SET_PUBLIC_KEY_AFFINE_COORDINATES       = 229
  F_EC_POINTS_MAKE_AFFINE                          = 136
  F_EC_POINT_ADD                                   = 112
  F_EC_POINT_CMP                                   = 113
  F_EC_POINT_COPY                                  = 114
  F_EC_POINT_DBL                                   = 115
  F_EC_POINT_GET_AFFINE_COORDINATES_GF2M           = 183
  F_EC_POINT_GET_AFFINE_COORDINATES_GFP            = 116
  F_EC_POINT_GET_JPROJECTIVE_COORDINATES_GFP       = 117
  F_EC_POINT_INVERT                                = 210
  F_EC_POINT_IS_AT_INFINITY                        = 118
  F_EC_POINT_IS_ON_CURVE                           = 119
  F_EC_POINT_MAKE_AFFINE                           = 120
  F_EC_POINT_MUL                                   = 184
  F_EC_POINT_NEW                                   = 121
  F_EC_POINT_OCT2POINT                             = 122
  F_EC_POINT_POINT2OCT                             = 123
  F_EC_POINT_SET_AFFINE_COORDINATES_GF2M           = 185
  F_EC_POINT_SET_AFFINE_COORDINATES_GFP            = 124
  F_EC_POINT_SET_COMPRESSED_COORDINATES_GF2M       = 186
  F_EC_POINT_SET_COMPRESSED_COORDINATES_GFP        = 125
  F_EC_POINT_SET_JPROJECTIVE_COORDINATES_GFP       = 126
  F_EC_POINT_SET_TO_INFINITY                       = 127
  F_EC_PRE_COMP_DUP                                = 207
  F_EC_PRE_COMP_NEW                                = 196
  F_EC_WNAF_MUL                                    = 187
  F_EC_WNAF_PRECOMPUTE_MULT                        = 188
  F_I2D_ECPARAMETERS                               = 190
  F_I2D_ECPKPARAMETERS                             = 191
  F_I2D_ECPRIVATEKEY                               = 192
  F_I2O_ECPUBLICKEY                                = 151
  F_NISTP224_PRE_COMP_NEW                          = 227
  F_NISTP256_PRE_COMP_NEW                          = 236
  F_NISTP521_PRE_COMP_NEW                          = 237
  F_O2I_ECPUBLICKEY                                = 152
  F_OLD_EC_PRIV_DECODE                             = 222
  F_PKEY_EC_CTRL                                   = 197
  F_PKEY_EC_CTRL_STR                               = 198
  F_PKEY_EC_DERIVE                                 = 217
  F_PKEY_EC_KEYGEN                                 = 199
  F_PKEY_EC_PARAMGEN                               = 219
  F_PKEY_EC_SIGN                                   = 218
  R_ASN1_ERROR                                     = 115
  R_ASN1_UNKNOWN_FIELD                             = 116
  R_BIGNUM_OUT_OF_RANGE                            = 144
  R_BUFFER_TOO_SMALL                               = 100
  R_COORDINATES_OUT_OF_RANGE                       = 146
  R_D2I_ECPKPARAMETERS_FAILURE                     = 117
  R_DECODE_ERROR                                   = 142
  R_DISCRIMINANT_IS_ZERO                           = 118
  R_EC_GROUP_NEW_BY_NAME_FAILURE                   = 119
  R_FIELD_TOO_LARGE                                = 143
  R_GF2M_NOT_SUPPORTED                             = 147
  R_GROUP2PKPARAMETERS_FAILURE                     = 120
  R_I2D_ECPKPARAMETERS_FAILURE                     = 121
  R_INCOMPATIBLE_OBJECTS                           = 101
  R_INVALID_ARGUMENT                               = 112
  R_INVALID_COMPRESSED_POINT                       = 110
  R_INVALID_COMPRESSION_BIT                        = 109
  R_INVALID_CURVE                                  = 141
  R_INVALID_DIGEST                                 = 151
  R_INVALID_DIGEST_TYPE                            = 138
  R_INVALID_ENCODING                               = 102
  R_INVALID_FIELD                                  = 103
  R_INVALID_FORM                                   = 104
  R_INVALID_GROUP_ORDER                            = 122
  R_INVALID_PENTANOMIAL_BASIS                      = 132
  R_INVALID_PRIVATE_KEY                            = 123
  R_INVALID_TRINOMIAL_BASIS                        = 137
  R_KDF_PARAMETER_ERROR                            = 148
  R_KEYS_NOT_SET                                   = 140
  R_MISSING_PARAMETERS                             = 124
  R_MISSING_PRIVATE_KEY                            = 125
  R_NOT_A_NIST_PRIME                               = 135
  R_NOT_A_SUPPORTED_NIST_PRIME                     = 136
  R_NOT_IMPLEMENTED                                = 126
  R_NOT_INITIALIZED                                = 111
  R_NO_FIELD_MOD                                   = 133
  R_NO_PARAMETERS_SET                              = 139
  R_PASSED_NULL_PARAMETER                          = 134
  R_PEER_KEY_ERROR                                 = 149
  R_PKPARAMETERS2GROUP_FAILURE                     = 127
  R_POINT_AT_INFINITY                              = 106
  R_POINT_IS_NOT_ON_CURVE                          = 107
  R_SHARED_INFO_ERROR                              = 150
  R_SLOT_FULL                                      = 108
  R_UNDEFINED_GENERATOR                            = 113
  R_UNDEFINED_ORDER                                = 128
  R_UNKNOWN_GROUP                                  = 129
  R_UNKNOWN_ORDER                                  = 114
  R_UNSUPPORTED_FIELD                              = 131
  R_WRONG_CURVE_PARAMETERS                         = 145
  R_WRONG_ORDER                                    = 130
  fun GFp_simple_method = EC_GFp_simple_method : Method
  type Method = Void*
  fun GFp_mont_method = EC_GFp_mont_method : Method
  fun GFp_nist_method = EC_GFp_nist_method : Method
  fun GFp_nistp256_method = EC_GFp_nistp256_method : Method
  fun GFp_nistp521_method = EC_GFp_nistp521_method : Method
  fun group_new = EC_GROUP_new(meth : Method) : Group
  type Group = Void*
  fun group_free = EC_GROUP_free(group : Group)
  fun group_clear_free = EC_GROUP_clear_free(group : Group)
  fun group_copy = EC_GROUP_copy(dst : Group, src : Group) : LibC::Int
  fun group_dup = EC_GROUP_dup(src : Group) : Group
  fun group_method_of = EC_GROUP_method_of(group : Group) : Method
  fun method_get_field_type = EC_METHOD_get_field_type(meth : Method) : LibC::Int
  fun group_set_generator = EC_GROUP_set_generator(group : Group, generator : Point, order : Bignum*, cofactor : Bignum*) : LibC::Int
  type Point = Void*

  alias Bignum = LibCryptoBN::Bignum
  fun group_get0_generator = EC_GROUP_get0_generator(group : Group) : Point
  fun group_get_mont_data = EC_GROUP_get_mont_data(group : Group) : BnMontCtx*

  struct BnMontCtxSt
    ri : LibC::Int
    rr : Bignum
    n : Bignum
    ni : Bignum
    n0 : LibC::ULong[2]
    flags : LibC::Int
  end

  type BnMontCtx = BnMontCtxSt
  fun group_get_order = EC_GROUP_get_order(group : Group, order : Bignum*, ctx : BnCtx) : LibC::Int
  type BnCtx = Void*
  fun group_get_cofactor = EC_GROUP_get_cofactor(group : Group, cofactor : Bignum*, ctx : BnCtx) : LibC::Int
  fun group_set_curve_name = EC_GROUP_set_curve_name(group : Group, nid : LibC::Int)
  fun group_get_curve_name = EC_GROUP_get_curve_name(group : Group) : LibC::Int
  fun group_set_asn1_flag = EC_GROUP_set_asn1_flag(group : Group, flag : LibC::Int)
  fun group_get_asn1_flag = EC_GROUP_get_asn1_flag(group : Group) : LibC::Int
  fun group_set_point_conversion_form = EC_GROUP_set_point_conversion_form(group : Group, form : PointConversionFormT)
  enum PointConversionFormT
    Compressed   = 2
    Uncompressed = 4
    Hybrid       = 6
  end
  fun group_get_point_conversion_form = EC_GROUP_get_point_conversion_form(x0 : Group) : PointConversionFormT
  fun group_get0_seed = EC_GROUP_get0_seed(x : Group) : UInt8*
  fun group_get_seed_len = EC_GROUP_get_seed_len(x0 : Group) : LibC::SizeT
  fun group_set_seed = EC_GROUP_set_seed(x0 : Group, x1 : UInt8*, len : LibC::SizeT) : LibC::SizeT
  fun group_set_curve_GFp = EC_GROUP_set_curve_GFp(group : Group, p : Bignum*, a : Bignum*, b : Bignum*, ctx : BnCtx) : LibC::Int
  fun group_get_curve_GFp = EC_GROUP_get_curve_GFp(group : Group, p : Bignum*, a : Bignum*, b : Bignum*, ctx : BnCtx) : LibC::Int
  fun group_get_degree = EC_GROUP_get_degree(group : Group) : LibC::Int
  fun group_check = EC_GROUP_check(group : Group, ctx : BnCtx) : LibC::Int
  fun group_check_discriminant = EC_GROUP_check_discriminant(group : Group, ctx : BnCtx) : LibC::Int
  fun group_cmp = EC_GROUP_cmp(a : Group, b : Group, ctx : BnCtx) : LibC::Int
  fun group_new_curve_GFp = EC_GROUP_new_curve_GFp(p : Bignum*, a : Bignum*, b : Bignum*, ctx : BnCtx) : Group
  fun group_new_by_curve_name = EC_GROUP_new_by_curve_name(nid : LibC::Int) : Group
  fun get_builtin_curves = EC_get_builtin_curves(r : BuiltinCurve*, nitems : LibC::SizeT) : LibC::SizeT

  struct BuiltinCurve
    nid : LibC::Int
    comment : LibC::Char*
  end

  fun curve_nid2nist = EC_curve_nid2nist(nid : LibC::Int) : LibC::Char*
  fun curve_nist2nid = EC_curve_nist2nid(name : LibC::Char*) : LibC::Int
  fun point_new = EC_POINT_new(group : Group) : Point
  fun point_free = EC_POINT_free(point : Point)
  fun point_clear_free = EC_POINT_clear_free(point : Point)
  fun point_copy = EC_POINT_copy(dst : Point, src : Point) : LibC::Int
  fun point_dup = EC_POINT_dup(src : Point, group : Group) : Point
  fun point_method_of = EC_POINT_method_of(point : Point) : Method
  fun point_set_to_infinity = EC_POINT_set_to_infinity(group : Group, point : Point) : LibC::Int
  fun point_set_jprojective_coordinates_GFp = EC_POINT_set_Jprojective_coordinates_GFp(group : Group, p : Point, x : Bignum*, y : Bignum*, z : Bignum*, ctx : BnCtx) : LibC::Int
  fun point_get_jprojective_coordinates_GFp = EC_POINT_get_Jprojective_coordinates_GFp(group : Group, p : Point, x : Bignum*, y : Bignum*, z : Bignum*, ctx : BnCtx) : LibC::Int
  fun point_set_affine_coordinates_GFp = EC_POINT_set_affine_coordinates_GFp(group : Group, p : Point, x : Bignum*, y : Bignum*, ctx : BnCtx) : LibC::Int
  fun point_get_affine_coordinates_GFp = EC_POINT_get_affine_coordinates_GFp(group : Group, p : Point, x : Bignum*, y : Bignum*, ctx : BnCtx) : LibC::Int
  fun point_set_compressed_coordinates_GFp = EC_POINT_set_compressed_coordinates_GFp(group : Group, p : Point, x : Bignum*, y_bit : LibC::Int, ctx : BnCtx) : LibC::Int
  fun point_point2oct = EC_POINT_point2oct(group : Group, p : Point, form : PointConversionFormT, buf : UInt8*, len : LibC::SizeT, ctx : BnCtx) : LibC::SizeT
  fun point_oct2point = EC_POINT_oct2point(group : Group, p : Point, buf : UInt8*, len : LibC::SizeT, ctx : BnCtx) : LibC::Int
  fun point_point2bn = EC_POINT_point2bn(x0 : Group, x1 : Point, form : PointConversionFormT, x3 : Bignum*, x4 : BnCtx) : Bignum*
  fun point_bn2point = EC_POINT_bn2point(x0 : Group, x1 : Bignum*, x2 : Point, x3 : BnCtx) : Point
  fun point_point2hex = EC_POINT_point2hex(x0 : Group, x1 : Point, form : PointConversionFormT, x3 : BnCtx) : LibC::Char*
  fun point_hex2point = EC_POINT_hex2point(x0 : Group, x1 : LibC::Char*, x2 : Point, x3 : BnCtx) : Point
  fun point_add = EC_POINT_add(group : Group, r : Point, a : Point, b : Point, ctx : BnCtx) : LibC::Int
  fun point_dbl = EC_POINT_dbl(group : Group, r : Point, a : Point, ctx : BnCtx) : LibC::Int
  fun point_invert = EC_POINT_invert(group : Group, a : Point, ctx : BnCtx) : LibC::Int
  fun point_is_at_infinity = EC_POINT_is_at_infinity(group : Group, p : Point) : LibC::Int
  fun point_is_on_curve = EC_POINT_is_on_curve(group : Group, point : Point, ctx : BnCtx) : LibC::Int
  fun point_cmp = EC_POINT_cmp(group : Group, a : Point, b : Point, ctx : BnCtx) : LibC::Int
  fun point_make_affine = EC_POINT_make_affine(group : Group, point : Point, ctx : BnCtx) : LibC::Int
  fun poin_ts_make_affine = EC_POINTs_make_affine(group : Group, num : LibC::SizeT, points : Point*, ctx : BnCtx) : LibC::Int
  fun poin_ts_mul = EC_POINTs_mul(group : Group, r : Point, n : Bignum*, num : LibC::SizeT, p : Point*, m : Bignum**, ctx : BnCtx) : LibC::Int
  fun point_mul = EC_POINT_mul(group : Group, r : Point, n : Bignum*, q : Point, m : Bignum*, ctx : BnCtx) : LibC::Int
  fun group_precompute_mult = EC_GROUP_precompute_mult(group : Group, ctx : BnCtx) : LibC::Int
  fun group_have_precompute_mult = EC_GROUP_have_precompute_mult(group : Group) : LibC::Int
  fun group_get_basis_type = EC_GROUP_get_basis_type(x0 : Group) : LibC::Int
  fun key_new = EC_KEY_new : Key
  type Key = Void*
  fun key_get_flags = EC_KEY_get_flags(key : Key) : LibC::Int
  fun key_set_flags = EC_KEY_set_flags(key : Key, flags : LibC::Int)
  fun key_clear_flags = EC_KEY_clear_flags(key : Key, flags : LibC::Int)
  fun key_new_by_curve_name = EC_KEY_new_by_curve_name(nid : LibC::Int) : Key
  fun key_free = EC_KEY_free(key : Key)
  fun key_copy = EC_KEY_copy(dst : Key, src : Key) : Key
  fun key_dup = EC_KEY_dup(src : Key) : Key
  fun key_up_ref = EC_KEY_up_ref(key : Key) : LibC::Int
  fun key_get0_group = EC_KEY_get0_group(key : Key) : Group
  fun key_set_group = EC_KEY_set_group(key : Key, group : Group) : LibC::Int
  fun key_get0_private_key = EC_KEY_get0_private_key(key : Key) : Bignum*
  fun key_set_private_key = EC_KEY_set_private_key(key : Key, prv : Bignum*) : LibC::Int
  fun key_get0_public_key = EC_KEY_get0_public_key(key : Key) : Point
  fun key_set_public_key = EC_KEY_set_public_key(key : Key, pub : Point) : LibC::Int
  fun key_get_enc_flags = EC_KEY_get_enc_flags(key : Key) : LibC::UInt
  fun key_set_enc_flags = EC_KEY_set_enc_flags(eckey : Key, flags : LibC::UInt)
  fun key_get_conv_form = EC_KEY_get_conv_form(key : Key) : PointConversionFormT
  fun key_set_conv_form = EC_KEY_set_conv_form(eckey : Key, cform : PointConversionFormT)
  fun key_get_key_method_data = EC_KEY_get_key_method_data(key : Key, dup_func : (Void* -> Void*), free_func : (Void* -> Void), clear_free_func : (Void* -> Void)) : Void*
  fun key_insert_key_method_data = EC_KEY_insert_key_method_data(key : Key, data : Void*, dup_func : (Void* -> Void*), free_func : (Void* -> Void), clear_free_func : (Void* -> Void)) : Void*
  fun key_set_asn1_flag = EC_KEY_set_asn1_flag(eckey : Key, asn1_flag : LibC::Int)
  fun key_precompute_mult = EC_KEY_precompute_mult(key : Key, ctx : BnCtx) : LibC::Int
  fun key_generate_key = EC_KEY_generate_key(key : Key) : LibC::Int
  fun key_check_key = EC_KEY_check_key(key : Key) : LibC::Int
  fun key_set_public_key_affine_coordinates = EC_KEY_set_public_key_affine_coordinates(key : Key, x : Bignum*, y : Bignum*) : LibC::Int
  fun key_print = EC_KEY_print(bp : Bio*, key : Key, off : LibC::Int) : LibC::Int

  struct BioSt
    method : BioMethod*
    callback : (BioSt*, LibC::Int, LibC::Char*, LibC::Int, LibC::Long, LibC::Long -> LibC::Long)
    cb_arg : LibC::Char*
    init : LibC::Int
    shutdown : LibC::Int
    flags : LibC::Int
    retry_reason : LibC::Int
    num : LibC::Int
    ptr : Void*
    next_bio : BioSt*
    prev_bio : BioSt*
    references : LibC::Int
    num_read : LibC::ULong
    num_write : LibC::ULong
    ex_data : CryptoExData
  end

  type Bio = BioSt

  struct BioMethodSt
    type : LibC::Int
    name : LibC::Char*
    bwrite : (Bio*, LibC::Char*, LibC::Int -> LibC::Int)
    bread : (Bio*, LibC::Char*, LibC::Int -> LibC::Int)
    bputs : (Bio*, LibC::Char* -> LibC::Int)
    bgets : (Bio*, LibC::Char*, LibC::Int -> LibC::Int)
    ctrl : (Bio*, LibC::Int, LibC::Long, Void* -> LibC::Long)
    create : (Bio* -> LibC::Int)
    destroy : (Bio* -> LibC::Int)
    callback_ctrl : (Bio*, LibC::Int, (BioSt*, LibC::Int, LibC::Char*, LibC::Int, LibC::Long, LibC::Long -> Void) -> LibC::Long)
  end

  type BioMethod = BioMethodSt

  struct CryptoExDataSt
    sk : StackStVoid*
    dummy : LibC::Int
  end

  type CryptoExData = CryptoExDataSt

  struct StackStVoid
    stack : X_Stack
  end

  struct StackSt
    num : LibC::Int
    data : LibC::Char**
    sorted : LibC::Int
    num_alloc : LibC::Int
    comp : (Void*, Void* -> LibC::Int)
  end

  type X_Stack = StackSt
  fun key_print_fp = EC_KEY_print_fp(fp : File*, key : Key, off : LibC::Int) : LibC::Int

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
end
