module SRII
  module Crypto
    extend self

    @[Link("bls-srii")]
    lib LibBLS
      fun core_init
      fun core_clean
      fun set_parm = pc_param_set_any
      fun pubkey_write = ep_write_bin(bin : UInt8*, len : LibC::Int, ep : Void*, pack : LibC::Int)
      fun pubkey_size = ep_size_bin(ep : Void*, pack : LibC::Int) : LibC::Int
      fun pubkey_read = ep_read_bin(ep : Void*, bin : UInt8*, len : LibC::Int)
      fun bls_gen = cp_bls_gen
    end
  end
end
