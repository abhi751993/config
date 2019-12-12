[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion
PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
PATH="$GOPATH/bin:$PATH"
KAFKA_PATH="/Users/abhisheksharma/Downloads/kafka_2.12-2.2.0"
function screw_my_prompt {
    local __cur_location="\w"
    local __git_branch='`git branch 2> /dev/null | grep -e ^* | sed -E  s/^\\\\\*\ \(.+\)$/\(\\\\\1\)\ /`'
    local __prompt_tail="$"
    local __last_color="\[\033[00m\]"
    export PS1="$__cur_location $__git_branch$__prompt_tail$__last_color "
}
screw_my_prompt

# Set Git editor
export VISUAL="/usr/local/bin/vim"
export EDITOR="$VISUAL"

# Alias
alias eb="vim ~/.bash_profile"
alias sb="source ~/.bash_profile"
alias ctags="`brew --prefix`/bin/ctags"
alias sshmysql='ssh abhishek@35.200.154.31'
alias sshredis='ssh abhishek@35.200.170.183'
alias sshneoapifp='ssh abhishek@35.244.33.168'
alias sshdashboard='ssh abhishek@35.244.6.80'
alias sshes='ssh abhishek@35.244.29.112'
alias sshstaging='ssh abhishek@35.244.5.109'
alias generatestring="head /dev/urandom | tr -dc 'A-Za-z0-9!@#%^&*()' | head -c 13 ; echo ''"
alias sum="paste -s -d+ infile | bc"
alias zookeeper="$KAFKA_PATH/bin/zookeeper-server-start.sh $KAFKA_PATH/config/zookeeper.properties"
alias kafka="$KAFKA_PATH/bin/kafka-server-start.sh $KAFKA_PATH/config/server.properties"
alias listtopics="$KAFKA_PATH/bin/kafka-topics.sh --list --bootstrap-server localhost:9092"

createtopic() {
  $KAFKA_PATH/bin/kafka-topics.sh --create --bootstrap-server localhost:9092 --replication-factor 1 --partitions 1 --topic $1
}

producer() {
  $KAFKA_PATH/bin/kafka-console-producer.sh --broker-list localhost:9092 --topic $1
}

consumer() {
  $KAFKA_PATH/bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic $1 --from-beginning
}

export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"

export GOPATH=~/workspace/go
PATH="$GOPATH/bin:$PATH"
export SBT_OPTS="-Xmx4G -XX:+UseConcMarkSweepGC -XX:+CMSClassUnloadingEnabled -XX:MaxPermSize=3G -Xss6M  -Duser.timezone=GMT"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/abhisheksharma/Downloads/google-cloud-sdk/path.bash.inc' ]; then . '/Users/abhisheksharma/Downloads/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/abhisheksharma/Downloads/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/abhisheksharma/Downloads/google-cloud-sdk/completion.bash.inc'; fi
