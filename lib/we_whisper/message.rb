require 'active_support/core_ext/hash'

module WeWhisper

  InvalidMessageClassError = Class.new StandardError

  module Message
    extend self

    def to_xml(content, signature, timestamp, nonce)
"""<xml>
<Encrypt><![CDATA[#{content}]]></Encrypt>
<MsgSignature><![CDATA[#{signature}]]></MsgSignature>
<TimeStamp>#{timestamp}</TimeStamp>
<Nonce><![CDATA[#{nonce}]]></Nonce>
</xml>"""
    end

    def get_value_of_key_in_message(message, key)
      case message.class.name
      when "String"
        message_hash = Hash.from_xml(message)
        message_hash[key] || message_hash["xml"][key]
      when "Hash"
        message[key] || message[key.to_sym]
      else
        raise InvalidMessageClassError, "Message can only be a String or a Hash"
      end
    end

    def get_encrypted_content_from_message(message)
      get_value_of_key_in_message(message, "Encrypt")
    end

    def get_signature_from_messge(message)
      get_value_of_key_in_message(message, "MsgSignature")
    end

  end
end
