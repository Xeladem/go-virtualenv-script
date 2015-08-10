export OLDPS1=$PS1
export OLDPATH=$PATH
export OLDGOPATH=$GOPATH
export OLDGOROOT=$GOROOT

export GOPATH=$(cd $(dirname ${BASH_SOURCE[0]} ) && pwd)
export GOROOT=$GOPATH/bin/go
export PS1="[go:$(basename $GOPATH)] $PS1"
export PATH=$GOPATH/bin:$PATH

alias gcd="cd $GOPATH"

arch_output=$(uname -m)
ARCH="386"

if [ $arch_output == "x86_64" ]; then
    ARCH="amd64"
fi

GOURL=$(curl https://golang.org/dl/ 2> /dev/null | perl -n -e '/class="download" href="(https:\/\/.*?linux-$ARCH.*?tar.gz)"/ && print $1')
GOARCHIVE=$(basename $GOURL)
GOVERSION=$(echo $GOARCHIVE | perl -n -e  '/(go\d+\.\d+(\.\d+)?).*/ && print $1')

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

# Make the bin folder
if [ ! -d $GOPATH/bin ]; then
    mkdir $GOPATH/bin
fi

DOWNLOAD=true

if [ -f /usr/local/go/bin/go ] && [ ! -d $GOPATH/bin/go ]; then
    GOVERSION_LOCAL=$(go version | cut -d" " -f3)

    if [ ! $GOVERSION == $GOVERSION_LOCAL ]; then
	echo "Latest Go version is $GOVERSION, you have $GOVERSION_LOCAL currently installed. "
	echo "Would you like to use the latest version? (y/n)"
	read answer
	
	if [ ! $answer == "y" ]; then
	    DOWNLOAD=false
	    mkdir -p ./bin/go
	    ln -s /usr/local/go/bin/go ./bin/go
	fi
    fi
fi

# Download go
if [ ! -d $GOPATH/bin/go ] && [ "$DOWNLOAD" = true ]; then
    wget $GOURL -P $GOPATH/bin
    tar -C $GOPATH/bin -xzf $GOPATH/bin/$GOARCHIVE
    rm $GOPATH/bin/$GOARCHIVE
fi

export PATH=$GOPATH/bin/go/bin:$PATH

