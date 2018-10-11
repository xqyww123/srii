require "bridge"
require "./base.cr"

module SRII
  class Interface
    include Bridge::Host

    directory control do
      # get or create a new host
      # input : identity as bytes (the public key)
      # output: reference of the host in srii, as int32
      api def host(identity : Host::Identity) : Host::Ref
        Host.register_host(identity).ref_id
      end
    end
  end
end
