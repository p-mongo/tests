## Result

    serene% docker build .
    Sending build context to Docker daemon  11.78kB
    Step 1/5 : FROM ruby
     ---> 958d3491c09a
    Step 2/5 : COPY resolv.conf /etc/resolv.conf
     ---> Using cache
     ---> eb557767667c
    Step 3/5 : WORKDIR /app
     ---> Using cache
     ---> a5d4332cfbe0
    Step 4/5 : COPY . .
     ---> b34cee5e35fd
    Step 5/5 : RUN bash test.sh
     ---> Running in b85056c1a27c
    PING gw.here (10.0.3.254) 56(84) bytes of data.
    From gw.here (10.0.3.254) icmp_seq=1 Destination Port Unreachable

    --- gw.here ping statistics ---
    1 packets transmitted, 0 received, +1 errors, 100% packet loss, time 0ms

    ping: gw: No address associated with hostname
    {:nameserver=>["10.0.2.254"], :search=>["here"], :ndots=>1}
    Removing intermediate container b85056c1a27c
     ---> db4339c40cac
    Successfully built db4339c40cac
