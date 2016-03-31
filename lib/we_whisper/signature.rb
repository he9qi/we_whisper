require 'digest/sha2'

module WeWhisper
  module Signature
    def self.sign(token, timestamp, nonce, encrypted)
      array = [token, timestamp, nonce]
      array << encrypted unless encrypted.nil?
      Digest::SHA1.hexdigest array.compact.collect(&:to_s).sort.join
    end
  end
end
