Wechat Message Encryption Wrapper
========

[微信加密解密技术方案](https://open.weixin.qq.com/cgi-bin/showdocument?action=dir_list&t=resource/res_list&verify=1&id=open1419318482&token=6e18ec982b3bc11a95683a6b6045cd3cf373f09d&lang=zh_CN)

### install gem
```
gem install 'we_whisper'

or using bundler:
gem 'we_whisper'
```

#### Create whisper

```Ruby
whisper = WeWhisper::Whisper.new appid, token, encoding_aes_key
```

#### Decrypt message

```Ruby
whisper.decrypt_message(encrypted_message, nonce, timestamp)
```


#### Encrypt message

```Ruby
whisper.encrypt_message(message, nonce, timestamp)
```
