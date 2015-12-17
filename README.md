# Build Image

    $ docker build -t "lx-mms" .

# Run Container

    $ docker run --name lx-mms -p 3333:3333 -v /data/lxmms:/root/.mms -d lx-mms 
