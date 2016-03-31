require 'spec_helper'

describe WeWhisper::Whisper do

  let(:timestamp) { "1415979516" }
  let(:nonce)     { "1320562132" }
  let(:signature) { "096d8cda45e4678ca23460f6b8cd281b3faf1fc3" }
  let(:message)   { "<xml><ToUserName><![CDATA[oia2TjjewbmiOUlr6X-1crbLOvLw]]></ToUserName><FromUserName><![CDATA[gh_7f083739789a]]></FromUserName><CreateTime>1407743423</CreateTime><MsgType>  <![CDATA[video]]></MsgType><Video><MediaId><![CDATA[eYJ1MbwPRJtOvIEabaxHs7TX2D-HV71s79GUxqdUkjm6Gs2Ed1KF3ulAOA9H1xG0]]></MediaId><Title><![CDATA[testCallBackReplyVideo]]></Title><Description><![CDATA[testCallBackReplyVideo]]></Description></Video></xml>" }
  let(:whisper) { WeWhisper::Whisper.new "wx2c2769f8efd9abc2", "spamtest", "abcdefghijklmnopqrstuvwxyz0123456789ABCDEFG" }
  let(:encrypted_message) {
    """<xml>
<Encrypt><![CDATA[3kKZ++U5ocvIF8dAHPct7xvUqEv6vplhuzA8Vwj7OnVcBu9fdmbbI41zclSfKqP6/bdYAxuE3x8jse43ImHaV07siJF473TsXhl8Yt8task0n9KC7BDA73mFTwlhYvuCIFnU6wFlzOkHyM5Bh2qpOHYk5nSMRyUG4BwmXpxq8TvLgJV1jj2DXdGW4qdknGLfJgDH5sCPJeBzNC8j8KtrJFxmG7qIwKHn3H5sqBf6UqhXFdbLuTWL3jwE7yMLhzOmiHi/MX/ZsVQ7sMuBiV6bW0wkgielESC3yNUPo4q/RMAFEH0fRLr76BR5Ct0nUbf9PdClc0RdlYcztyOs54X/KLbYRNCQ2kXxmJYL6ekdNe70PCAReIEfXEp+pGpry4ss8bD6LKAtNvBJUwHshZe6sbf+fOiDiuKEqp1wdQLmgN+8nX62LklySWr8QrNCpsmKClxco0kbVYNX/QVh5yd0UA1sAqIn6baZ9G+Z/OXG+Q4n9lUuzLprLhDBPaCvXm4N14oqXNcw7tqU2xfhYNIDaD72djyIc/4eyAi2ZsJ+3hb+jgiISR5WVveRWYYqGZGTW3u+27JiXEo0fs3DQDbGVIcYxaMgU/RRIDdXzZSFcf6Z1azjzCDyV9FFEsicghHn]]></Encrypt>
<MsgSignature><![CDATA[096d8cda45e4678ca23460f6b8cd281b3faf1fc3]]></MsgSignature>
<TimeStamp>1415979516</TimeStamp>
<Nonce><![CDATA[1320562132]]></Nonce>
</xml>"""
  }

  it "decrypts message" do
    decrypted_message = whisper.decrypt_message(encrypted_message, nonce, timestamp)
    expect(decrypted_message).to eq message
  end

  it "encryptes message" do
    expect(SecureRandom).to receive(:hex).with(8).and_return("HLFOQjbkfgUh46s8")
    encrypted_msg = whisper.encrypt_message(message, nonce, timestamp)

    expect(encrypted_msg).to eq encrypted_message
  end

end
