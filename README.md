Wechat Message Encryption Wrapper
========
[![Build Status][travis-img]][travis] [![Coverage Status][coverage-img]][coverage] [![Gem Version][gem-img]][gem] [![License][license-img]][license]

[coverage-img]: https://coveralls.io/repos/he9qi/we_whisper/badge.svg?branch=master&service=github
[coverage]: https://coveralls.io/github/he9qi/we_whisper?branch=master
[travis-img]: https://travis-ci.org/he9qi/we_whisper.svg?branch=master
[travis]: https://travis-ci.org/he9qi/we_whisper
[gem-img]: https://badge.fury.io/rb/we_whisper.svg
[gem]: https://rubygems.org/gems/we_whisper
[license-img]: http://img.shields.io/badge/license-MIT-brightgreen.svg
[license]: http://opensource.org/licenses/MIT

> [微信加密解密技术方案](https://open.weixin.qq.com/cgi-bin/showdocument?action=dir_list&t=resource/res_list&verify=1&id=open1419318482&token=6e18ec982b3bc11a95683a6b6045cd3cf373f09d&lang=zh_CN)

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
