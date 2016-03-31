require "openssl"
require 'digest/sha2'
require 'base64'
require 'securerandom'
require 'nokogiri'

require_relative 'cipher'
require_relative 'signature'
require_relative 'message'

module WeWhisper
  InvalidSignature = Class.new StandardError
  AppIdNotMatch = Class.new StandardError

  class Whisper
    include Cipher

    attr_reader :appid, :encoding_aes_key, :token, :options

    def initialize(appid, token, encoding_aes_key, opts={})
      @options = {
        assert_signature: true,
        assert_appid: true
      }.merge(opts)

      @appid = appid
      @token = token
      @encoding_aes_key = encoding_aes_key
    end

    def decrypt_message(message, nonce="", timestamp="")
      # 1. Get the encrypted content from XML Message
      encrypted_text = Message.get_encrypted_content_from_message(message)

      # 2. If we need to validate signature, generate one from the encrypted text
      #    and check with the Signature in message
      if options[:assert_signature] && signature = Message.get_signature_from_messge(message)
        sign = Signature.hexdigest(token, timestamp, nonce, encrypted_text)
        raise InvalidSignature if sign != signature
      end

      # 3. Decode and decrypt the encrypted text
      decrypted_message, decrypted_appid = \
        unpack(decrypt(Base64.decode64(encrypted_text), encoding_aes_key))

      if options[:assert_appid]
        raise AppIdNotMatch if decrypted_appid != appid
      end

      decrypted_message
    end

    def encrypt_message(message, nonce, timestamp)
      # 1. Encrypt and encode the xml message
      encrypt = Base64.strict_encode64(encrypt(pack(message, appid), encoding_aes_key))

      # 2. Create signature
      sign = Signature.hexdigest(token, timestamp, nonce, encrypt)

      # 3. Construct xml
      Message.to_xml(encrypt, sign, timestamp, nonce)
    end

  end
end
