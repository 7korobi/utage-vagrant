#!/usr/bin/env ruby-local-exec

no = ARGV[0][0..2]
hwaddr = no[1..2]

open('/home/vagrant/web-env','w').puts <<-_SH_
echo "no: #{no}  environment set."

PATH=/utage:/home/vagrant/.rbenv/shims:/home/vagrant/.rbenv/bin:/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/usr/local/rvm/bin:/home/vagrant/bin
UTAGE=#{no}
SSH_PORT=#{no}0
WEB_PORT=#{no}9
WSS_PORT=#{no}8
RESQUE_PORT=#{no}7

export LANG=ja_JP.UTF-8
export PATH
export UTAGE
export SSH_PORT
export WEB_PORT
export WSS_PORT
export RESQUE_PORT
export RBENV_VERSION=2.0.0-p195
export MONGO_URL="mongodb://7korobi:kotatsu3@mongo.family.jp/giji"
export REDIS_URL="redis://mongo.family.jp:6379/0"

eval "$(rbenv init -)"
_SH_


open('/home/vagrant/.bash_profile','w').puts <<-_SH_
# .bash_profile
test -f ~/.bashrc  && . ~/.bashrc
test -f ~/web-env  && . ~/web-env
_SH_


commands = <<-_SH_
chmod 755  ~/web-env ~/.bash_profile
_SH_
commands.each_line {|sh| system sh}
