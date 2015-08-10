export OLDPS1=$PS1
export OLDPATH=$PATH
export OLDGOPATH=$GOPATH
export OLDGOROOT=$GOROOT

export GOPATH=$(cd $(dirname ${BASH_SOURCE[0]} ) && pwd)
export GOROOT=$GOPATH/bin/go
export PS1="[go:$(basename $GOPATH)] $PS1"
export PATH=$GOPATH/bin:$PATH

alias gcd="cd $GOPATH"

GOARCHIVE="go1.4.linux-amd64.tar.gz"

deactivate() {
        export PS1=$OLDPS1
        export PATH=$OLDPATH
        export GOPATH=$OLDGOPATH
        export GOROOT=$OLDGOROOT

        unset GOPATH
        unset OLDPS1
        unalias gcd
        unset deactivate
}

#Make the bin folder
if [ ! -d $GOPATH/bin ];
then
    mkdir $GOPATH/bin
fi

#Download go
if [ ! -d $GOPATH/bin/go ];
then
    wget "https://storage.googleapis.com/golang/$GOARCHIVE" -P $GOPATH/bin
    tar -C $GOPATH/bin -xzf $GOPATH/bin/$GOARCHIVE
    rm $GOPATH/bin/$GOARCHIVE
fi

export PATH=$GOPATH/bin/go/bin:$PATH

