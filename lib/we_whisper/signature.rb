require 'digest/sha2'

module WeWhisper
  module Signature
    def self.hexdigest(token, timestamp, nonce, msg_encrypt)
      array = [token, timestamp, nonce]
      array << msg_encrypt unless msg_encrypt.nil?
      Digest::SHA1.hexdigest array.compact.collect(&:to_s).sort.join
    end
  end
end
