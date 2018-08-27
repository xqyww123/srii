module SRII
  module Config
    Endian = IO::ByteFormat::LittleEndian

    module EC
      METHOD = OpenSSL::EC::NISTp256
      GROUP  = OpenSSL::EC::Group.new OpenSSL::EC::Curves::Scep256K1
    end
  end
end
