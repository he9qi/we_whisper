require 'spec_helper'

describe WeWhisper::Message do

  it "constructs XML message" do
    expect(subject.to_xml("hello", "signature", "2016/10/10", "nonce")).to \
      eq """<xml>
<Encrypt><![CDATA[hello]]></Encrypt>
<MsgSignature><![CDATA[signature]]></MsgSignature>
<TimeStamp>2016/10/10</TimeStamp>
<Nonce><![CDATA[nonce]]></Nonce>
</xml>"""
  end

  describe "Message parsing" do
    let(:hash_message) { { Encrypt: "hash_encrypted" } }
    let(:xml_message) { """<xml>
<Encrypt>xml_encrypted_message</Encrypt>
</xml>"""
      }

    it "parses encrypted content from Hash message" do
      expect(subject.get_encrypted_content_from_message(hash_message)).to \
        eq "hash_encrypted"
    end

    it "parses encrypted content from XML message" do
      expect(subject.get_encrypted_content_from_message(xml_message)).to \
        eq "xml_encrypted_message"
    end

    it "raises invalid message class error from unknown message" do
      expect{ subject.get_encrypted_content_from_message(nil) }.to \
        raise_error WeWhisper::InvalidMessageClassError
    end
  end

end
