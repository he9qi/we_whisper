require_relative 'cipher'

module WeWhisper
  class Cryptor
    include Cipher

    attr_reader :value

    def self.encrypt(content, appid, encoding_aes_key)
      new(content).encrypt(appid, encoding_aes_key)
    end

    def self.decrypt(encrypted_content, encoding_aes_key)
      new(encrypted_content).decrypt(encoding_aes_key)
    end

    def initialize(content)
      @value = content
      self
    end

    def encrypt(appid, encoding_aes_key)
      pack_with_appid(appid)
        .encrypt_with_aes_key(encoding_aes_key)
        .encode()
        .value
    end

    def decrypt(encoding_aes_key)
      decode()
        .decrypt_with_aes_key(encoding_aes_key)
        .unpack_with_appid()
        .value
    end

    protected

    def decode
      @value = Base64.decode64(@value)
      self
    end

    def decrypt_with_aes_key(encoding_aes_key)
      @value = cipher_decrypt(@value, encoding_aes_key)
      self
    end

    def unpack_with_appid
      @value = unpack(@value)
      self
    end

    # pack
    def pack_with_appid(appid)
      @value = pack(@value, appid)
      self
    end

    # encrypt
    def encrypt_with_aes_key(encoding_aes_key)
      @value = cipher_encrypt(@value, encoding_aes_key)
      self
    end

    # encode
    def encode
      @value = Base64.strict_encode64(@value)
      self
    end

  end
end
