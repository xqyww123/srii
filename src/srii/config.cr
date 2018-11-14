module SRII
  module Config
    Endian = IO::ByteFormat::LittleEndian
    Digest = "SHA1"

    def self.digest(data : Bytes)
      Bytes.new OpenSSL::SHA1.hash(data.to_unsafe, data.size).to_unsafe, 20
    end

    module EC
      METHOD = OpenSSL::EC::NISTp256
      GROUP  = OpenSSL::EC::Group.new OpenSSL::EC::Curves::Scep256K1
    end
  end
end
