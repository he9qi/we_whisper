require 'digest/sha2'

module WeWhisper
  module Signature
    def self.sign(token, timestamp, nonce, encrypted)
      Digest::SHA1.hexdigest \
        [token, timestamp, nonce, encrypted].compact.collect(&:to_s).sort.join
    end
  end
end
