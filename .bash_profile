[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

PATH="/usr/local/opt/mysql@5.7/bin:$PATH"

function screw_my_prompt {
    local __cur_location="\w"
    local __git_branch='`git branch 2> /dev/null | grep -e ^* | sed -E  s/^\\\\\*\ \(.+\)$/\(\\\\\1\)\ /`'
    local __last_color="\[\033[00m\]"
    local __aws_context='(aws: $(echo $AWS_PROFILE | cut -d "-" -f 2))'
    local __kubectl_context='(`case $(cat ~/.kube/config | grep "current-context:" | sed "s/current-context: //" | cut -d ":" -f 5) in 475466206101) echo "k8s: stage" ;; 595267689719) echo "k8s: prod";; *) echo "k8s: other";; esac`)'
    local __prompt_tail=" $ "
    export PS1="$__cur_location $__git_branch$__kubectl_context $__aws_context$__prompt_tail"
}
screw_my_prompt

# Set Git editor
export VISUAL="/usr/local/bin/vim"
export EDITOR="$VISUAL"

# Alias
alias eb="vim ~/.bash_profile"
alias sb="source ~/.bash_profile"
alias venv="source ~/workspace/venv/bin/activate"
alias ctags="`brew --prefix`/bin/ctags"
alias sshmysql='echo QWbdJ6VZ27l4eF3slKmQ | pbcopy && ssh abhishek@35.200.154.31'
alias sshredis='echo CmbrFDOT0TV3Dxz5deEn | pbcopy && ssh abhishek@35.200.170.183'
alias sshneoapifp='echo T2meeBi5Dc2ldtvOed2o | pbcopy && ssh abhishek@35.244.33.168'
alias sshdashboard='echo 5rlXZsvkuyaa5qq9wAJy | pbcopy && ssh abhishek@35.244.6.80'
alias sshes='ssh abhishek@35.244.29.112'
alias sshstaging='echo Ml8mivN&dzYG | pbcopy && ssh abhishek@35.244.5.109'
alias sshshopify='echo hy3v2Vj5xsHy2MqhnRmc | pbcopy && ssh abhishek@35.244.8.113'
alias generatestring="head /dev/urandom | tr -dc 'A-Za-z0-9!@#%^&*()' | head -c 13 ; echo ''"
alias sum="paste -s -d+ infile | bc"
alias listtopics="kafka-topics --list --bootstrap-server localhost:9092"
alias espy="~/Downloads/es.py"
alias clear_branch="git branch | grep -v '\*' | grep -v master | xargs git branch -D"
alias awsprod="export AWS_PROFILE=thirdwatch-prod"
alias awsstage="export AWS_PROFILE=thirdwatch-stage"
alias k8prod="kubectl config use-context arn:aws:eks:ap-south-1:595267689719:cluster/thirdwatch"
alias k8stage="kubectl config use-context arn:aws:eks:ap-south-1:475466206101:cluster/thirdwatch"

createtopic() {
  kafka-topics --create --bootstrap-server localhost:9092 --replication-factor 1 --partitions 1 --topic $1
}

producer() {
  kafka-console-producer --broker-list localhost:9092 --topic $1
}

consumer() {
  kafka-console-consumer --bootstrap-server localhost:9092 --topic $1 --from-beginning
}

podlist() {
    kubectl get pod -n ${1:-rajeev-test}
}

podbash() {
    kubectl exec -it $(podlist ${2:-rajeev-test}| awk '{print $1}' | grep $1) -n ${2:-rajeev-test} bash
}

poddeployment() {
    kubectl edit deployments $(kubectl get deployments -n ${2:-rajeev-test} | awk '{print $1}' | grep $1) -n ${2:-rajeev-test}
}

podkill() {
    kubectl delete pod $(podlist ${2:-rajeev-test}| awk '{print $1}' | grep $1) -n ${2:-rajeev-test}
}

podlogs() {
    kubectl logs -f $(podlist ${2:-rajeev-test}| awk '{print $1}' | grep $1) -n ${2:-rajeev-test}
}

podsecrets() {
    kubectl edit secrets $(kubectl get deployments -n ${2:-rajeev-test} | awk '{print $1}' | grep $1) -n ${2:-rajeev-test}
}

export GOPATH=~/workspace/go
PATH="$GOPATH/bin:$PATH"
export SBT_OPTS="-Xmx4G -XX:+UseConcMarkSweepGC -XX:+CMSClassUnloadingEnabled -XX:MaxPermSize=3G -Xss6M  -Duser.timezone=GMT"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/abhisheksharma/Downloads/google-cloud-sdk/path.bash.inc' ]; then . '/Users/abhisheksharma/Downloads/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/abhisheksharma/Downloads/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/abhisheksharma/Downloads/google-cloud-sdk/completion.bash.inc'; fi
export PATH="/usr/local/opt/ruby/bin:$PATH"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export BUILD_LIBRDKAFKA=0
export LC_ALL=en_US.UTF-8
