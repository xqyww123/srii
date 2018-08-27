# # Generated from router.proto for SRII.router
require "protobuf"

struct Host
  include Protobuf::Message

  contract_of "proto2" do
    required :identity, :bytes, 1
  end
end

struct Group
  include Protobuf::Message

  contract_of "proto2" do
    repeated :hosts, Host, 1
  end
end

struct Edge
end

struct RouterPeice
end

struct Send
  include Protobuf::Message

  contract_of "proto2" do
    required :dest_ref, :uint32, 1
    required :data, :bytes, 2
  end
end

struct Recv
  include Protobuf::Message

  contract_of "proto2" do
    required :from_ref, :uint32, 1
    required :data, :bytes, 2
  end
end

struct Query
  include Protobuf::Message

  struct Result
    include Protobuf::Message

    contract_of "proto2" do
      optional :host, Host, 2
      optional :group, Group, 3
    end
  end

  contract_of "proto2" do
    required :ref, :uint32, 1
  end
end

struct Judge
  include Protobuf::Message

  contract_of "proto2" do
    required :ok, :bool, 1
    optional :reason, :uint32, 2
    optional :message, :string, 3
  end
end
